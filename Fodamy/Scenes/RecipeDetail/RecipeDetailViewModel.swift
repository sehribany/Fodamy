//
//  RecipeDetailViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//
import DataProvider
import KeychainSwift

protocol RecipeDetailViewDataSource {
    var recipe      : Recipe { get set }
    var recipeDetail: RecipeDetail? { get }
    var likeCount   : Int? { get }
    
    func commentNumberOfItemsAt(section: Int) -> Int
    func commentCellItemAt(indexPath: IndexPath) -> CommentCellProtocol
}

protocol RecipeDetailViewEventSource {
    var reloadCommentData: VoidClosure? { get set }
    var reloadDetailData : VoidClosure? { get set }
}

protocol RecipeDetailViewProtocol: RecipeDetailViewDataSource, RecipeDetailViewEventSource {
    //func likeButtonTapped()
    //func followButtonTapped()
    //func commentButtonTapped()
    //func didSelectComment()
}

final class RecipeDetailViewModel: BaseViewModel<RecipeDetailRouter>, RecipeDetailViewProtocol {

    var likeCount           : Int?
    var recipeDetail        : RecipeDetail?
    var reloadCommentData   : VoidClosure?
    var reloadDetailData    : VoidClosure?
    var recipe              : Recipe
    var imageSliderCellItems: [ImageSliderCellProtocol] = []
    let keychain = KeychainSwift()

    init(recipe: Recipe, router: RecipeDetailRouter) {
        self.recipe = recipe
        super.init(router: router)
    }
    
    func commentNumberOfItemsAt(section: Int) -> Int {
        return commentCellItems.count
    }
    
    func commentCellItemAt(indexPath: IndexPath) -> CommentCellProtocol {
        return commentCellItems[indexPath.row]
    }
    
    var commentCellItems: [CommentCellProtocol] = []
    func showInfo() {
        recipe.images?.forEach({ image in
            imageSliderCellItems.append(ImageSliderCellModel(imageUrl: image.url ?? "", isEditorChoice: recipe.isEditorChoice))
        })
    }
}
// MARK: - Actions
extension RecipeDetailViewModel {
    
    func resetData() {
        commentCellItems.removeAll()
        imageSliderCellItems.removeAll()
    }
    
    func shareButtonTapped() {
        let title          = recipe.title
        let imageUrlString = recipe.user.image?.url
        guard let imageUrl = URL(string: imageUrlString ?? "") else { return }
        let items: [Any]   = [title ?? "", imageUrl]
    }
}

// MARK: - Network
extension RecipeDetailViewModel {
    
    func getRecipeDetail() {
        dataProvider.request(for: GetRecipeDetailRequest(recipeId: recipe.id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recipeDetail):
                self.recipeDetail = recipeDetail
                self.reloadDetailData?()
            case .failure(let error ):
                print(error.localizedDescription)
            }
        }
    }
    
    func getRecipeComment() {
        let request = GetRecipeCommentsRequest(recipeId: recipe.id)
        dataProvider.request(for: request) { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                let commentCellItems = response.data.map({ CommentCellModel(comment: $0) })
                self.commentCellItems = commentCellItems
                self.reloadCommentData?()
            case .failure(_ ):
                self?.reloadCommentData?()
            }
        }
    }

    private func recipeLikeRequest() {
        let recipeId = recipe.id
        let isLiked  = recipeDetail?.isLiked ?? false
        let request: RecipeLikeRequest
        switch isLiked {
        case true:
            request = RecipeLikeRequest(recipeId: recipeId, likeType: .unlike)
        case false:
            request = RecipeLikeRequest(recipeId: recipeId, likeType: .like)
        }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response.message)
                self.getRecipeDetail()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func userFollowRequest(followType: UserFollowRequest.FollowType) {
        guard let followedId = recipeDetail?.user.id else { return }
        let request = UserFollowRequest(followedId: followedId, followType: followType)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response.message)
                self.getRecipeDetail()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
