//
//  CommentListViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit

final class CommentListViewController: BaseViewController<CommentListViewModel> {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Asset.Colors.appSecondaryBackground.color
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
        return collectionView
    }()
    
    private let commentInputView = CommentInputView()
    private let refreshControl = UIRefreshControl()
    
    private var commentInputViewBottomConstraint: NSLayoutConstraint?
    var isKeyboardOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        viewModel.fetchComments()
        subscribeViewModel()
        addObserver()
        setSendButtonAction()
    }
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.postCommentDidSuccess = { [weak self] in
            guard let self = self else { return }
            self.commentInputView.textView.text = ""
            self.view.endEditing(true)
            self.viewModel.postNotification()
        }
        
        viewModel.deleteCommentDidSuccess = { [weak self] indexPath in
            guard let self = self else { return }
            self.collectionView.deleteItems(at: [indexPath])
            self.viewModel.postNotification()
        }
    }
}

// MARK: - UILayout
extension CommentListViewController {
    
    private func addSubViews() {
        addCollectionView()
        addCommentInputView()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        collectionView.contentInset.bottom = 15
        refreshControl.addTarget(self, action: #selector(pullToRefreshValueChanged), for: .valueChanged)
    }
    
    private func addCommentInputView() {
        view.addSubview(commentInputView)
        commentInputView.topToBottom(of: collectionView)
        commentInputView.leftToSuperview().constant = 15
        commentInputView.rightToSuperview().constant = -15
        commentInputViewBottomConstraint = commentInputView.bottomToSuperview(usingSafeArea: true)
        commentInputViewBottomConstraint?.isActive = true
    }
}

// MARK: - Configure and Set Localize
extension CommentListViewController {
    
    private func configureContents() {
        title = L10n.General.comments
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshValueChanged), for: .valueChanged)
    }
}

// MARK: - Actions
extension CommentListViewController {
    
    private func setSendButtonAction() {
        commentInputView.sendButtonTappedCallBack = { [weak self] text in
            guard let self = self else { return }
            guard !text.isEmpty else {
                self.showWarningToast(message: L10n.Error.empty(L10n.General.comment))
                return
            }
            self.viewModel.sendButtonTapped(text: text)
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardNotification(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.commentInputViewBottomConstraint?.constant = 0
        } else {
            self.commentInputViewBottomConstraint?.constant = self.view.safeAreaInsets.bottom - (endFrame?.height ?? CGFloat(0))
        }
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    @objc
    private func pullToRefreshValueChanged() {
        viewModel.cellItems.isEmpty ? viewModel.fetchComments() : collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - ScrollViewDelegate
extension CommentListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height && viewModel.isPagingEnabled && viewModel.isRequestEnabled {
            viewModel.fetchMorePages()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDataSource
extension CommentListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        
        cellItem.moreButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.moreButtonTapped(at: indexPath)
        }
        
        cell.set(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = viewModel.isPagingEnabled ? 100 : 0
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
