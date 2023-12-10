//
//  RecipeDetailViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import MobilliumBuilders

final class RecipeDetailViewController: BaseViewController<RecipeDetailViewModel> {

    private let imageSliderView = ImageSliderView()
    private let scrollView = UIScrollViewBuilder()
        .showsHorizontalScrollIndicator(false)
        .showsVerticalScrollIndicator(false)
        .alwaysBounceVertical(false)
        .build()
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    
    private let infoView = InfoCardView()
    private let countInfoStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(1)
        .distribution(.fillEqually)
        .build()
    private let userCardView = UserCardView()
    private let ingredientsView = IngredientsView()
    private let stepsView = StepsView()
    private let commentsContainerView = UIViewBuilder()
        .backgroundColor(Asset.Colors.appWhite.color)
        .build()
    private let commentsTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(Asset.Colors.appCinder.color)
        .text(L10n.General.comments)
        .build()
    private let commentsSeparator = UIViewBuilder()
        .backgroundColor(Asset.Colors.appZircon.color)
        .build()
   
    private let commentsCollectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Asset.Colors.appSecondaryBackground.color
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        return collectionView
    }()
    
    private let commentButtonContainerView = UIViewBuilder()
        .backgroundColor(.clear)
        .build()
    private let commentButton = ButtonFactory.createPrimaryButton(style: .large)
    private var observer: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRecipeComment()
        viewModel.getRecipeDetail()
        addSubViews()
        setLocalize()
        subscribeViewModel()
        configureContents()
        subscribeViewModel()
        subscribeActions()
        addObserver()
    }
    
    private func subscribeViewModel() {
        viewModel.reloadCommentData = { [weak self] in
            self?.configureContents()
            self?.commentsCollectionView.reloadData()
        }
        
        viewModel.reloadDetailData = { [weak self] in
            self?.updateConfigureContents()
            self?.configureContents()
        }
    }
    
    private func addObserver() {
        observer = NotificationCenter.default.addObserver(forName: .reloadDetailView, object: nil, queue: nil, using: { [weak self] _ in
            self?.viewModel.resetData()
            self?.viewModel.getRecipeComment()
            self?.viewModel.getRecipeDetail()
        })
    }
}

// MARK: - UILayout
extension RecipeDetailViewController {
    
    private func addSubViews() {
        addScrollView()
        addContentStackView()
        addCommentsContainerView()
        addShareButton()
    }
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(excluding: .top)
        scrollView.topToSuperview(usingSafeArea: true)
    }
    
    private func addContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.widthToSuperview()
        contentStackView.edgesToSuperview()
        
        contentStackView.addArrangedSubview(imageSliderView)
        contentStackView.setCustomSpacing(0, after: imageSliderView)
        contentStackView.addArrangedSubview(infoView)
        contentStackView.addArrangedSubview(userCardView)
        contentStackView.addArrangedSubview(ingredientsView)
        contentStackView.addArrangedSubview(stepsView)
        contentStackView.addArrangedSubview(commentsContainerView)
        contentStackView.addArrangedSubview(commentButtonContainerView)
        
        imageSliderView.aspectRatio(1)
    }
    
    private func addCommentsContainerView() {
        commentsContainerView.addSubview(commentsTitleLabel)
        commentsContainerView.addSubview(commentsSeparator)
        commentsContainerView.addSubview(commentsCollectionView)
        
        commentsTitleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 11, left: 15, bottom: 11, right: 15))
        
        commentsSeparator.height(1)
        commentsSeparator.edgesToSuperview(excluding: [.top, .bottom])
        commentsSeparator.topToBottom(of: commentsTitleLabel).constant = 11
        
        commentsCollectionView.edgesToSuperview(excluding: .top)
        commentsCollectionView.topToBottom(of: commentsSeparator)
        
        commentButtonContainerView.addSubview(commentButton)
        commentButton.edgesToSuperview(insets: .init(top: 0, left: 15, bottom: 15, right: 15))
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    private func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.Icons.icShare.image, style: .plain, target: self, action: #selector(shareButtonTapped))
    }
}

// MARK: - Configure and Set Localize
extension RecipeDetailViewController {
    
    private func configureContents() {
        title                             = viewModel.recipe.title
        commentsCollectionView.dataSource = self
        commentsCollectionView.delegate   = self
        
        view.backgroundColor = Asset.Colors.appSecondaryBackground.color
        viewModel.showInfo()
        imageSliderView.set(viewModel: ImageSliderViewModel(cellItems: viewModel.imageSliderCellItems))
        ingredientsView.set(viewModel: IngredientsViewModel(ingredients: viewModel.recipe.ingredients, numberOfPerson: viewModel.recipe.numberOfPerson.text))
        infoView.set(viewModel: InfoCardViewModel(recipeName: viewModel.recipe.title,
                                                  categoryName: viewModel.recipe.category.name,
                                                  difference: viewModel.recipe.difference,
                                                  commentCount: viewModel.recipe.commentCount,
                                                  likeCount: viewModel.recipe.likeCount))
        stepsView.set(viewModel: StepsViewModel(directions: viewModel.recipe.directions, timeOfRecipe: viewModel.recipe.timeOfRecipe.text))
        userCardView.set(viewModel: UserCardViewModel(userId: viewModel.recipe.user.id,
                                                      userImageUrl: viewModel.recipe.user.image?.url,
                                                      username: viewModel.recipe.user.username,
                                                      isfollowing: viewModel.recipe.user.isFollowing,
                                                      recipeCount: viewModel.recipe.user.recipeCount,
                                                      followedCount: viewModel.recipe.user.followingCount,
                                                      followButtonisHidden: false))
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    private func updateConfigureContents() {
        
        infoView.set(viewModel: InfoCardViewModel(recipeName: viewModel.recipe.title,
                                                  categoryName: viewModel.recipe.category.name,
                                                  difference: viewModel.recipe.difference,
                                                  commentCount: viewModel.recipe.commentCount,
                                                  likeCount: viewModel.recipeDetail?.likeCount ?? 0))
        userCardView.set(viewModel: UserCardViewModel(userId: viewModel.recipe.user.id,
                                                      userImageUrl: viewModel.recipe.user.image?.url,
                                                      username: viewModel.recipe.user.username,
                                                      isfollowing: viewModel.recipeDetail?.user.isFollowing,
                                                      recipeCount: viewModel.recipe.user.recipeCount,
                                                      followedCount: viewModel.recipe.user.followingCount,
                                                      followButtonisHidden: false))
    }
    private func setLocalize() {
        commentButton.setTitle(L10n.General.addComment, for: .normal)
    }
}

// MARK: - Actions
extension RecipeDetailViewController {
    
    private func subscribeActions() {
        infoView.infoButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.likeButtonTapped()
        }
        
        userCardView.followButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.followButtonTapped()
        }
    }
    
    @objc
    private func commentButtonTapped() {
        viewModel.commentButtonTapped()
    }
    
    @objc
    private func shareButtonTapped() {
        viewModel.shareButtonTapped()
    }
}
// MARK: - UICollectionViewDataSource
extension RecipeDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.commentNumberOfItemsAt(section: section) == 0 {
            return 1
        } else if viewModel.commentNumberOfItemsAt(section: section) > 3 {
            return 3
        }
        return viewModel.commentNumberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.commentNumberOfItemsAt(section: 0) == 0 {
            let cell: EmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCell.identifier, for: indexPath) as! EmptyCell
            return cell
        }
        
        let cell: CommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        let cellItem = viewModel.commentCellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        cell.isMoreButtonHidden = true
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension RecipeDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectComment()
    }
}

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 195)
    }
}
