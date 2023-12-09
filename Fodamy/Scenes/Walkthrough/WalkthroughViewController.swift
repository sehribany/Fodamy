//
//  WalkthroughViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIKit
import UIComponents
import MobilliumBuilders
import TinyConstraints

final class WalkthroughViewController: BaseViewController<WalkthroughViewModel> {
   
    private let pageControl = UIPageControlBuilder<PageControl>()
        .numberOfPages(4)
        .build()
    private let dismissButton = UIButtonBuilder()
        .image(Asset.Icons.icClose.image.withRenderingMode(.alwaysTemplate))
        .tintColor(Asset.Colors.appCinder.color)
        .build()
    private let nextButton = UIButtonBuilder()
        .cornerRadius(4)
        .backgroundColor(Asset.Colors.appRed.color)
        .titleFont(.font(.nunitoBold, size: .large))
        .titleColor(Asset.Colors.appWhite.color)
        .build()
    private let collectionView = UICollectionViewBuilder()
        .scrollDirection(.horizontal)
        .isPagingEnabled(true)
        .backgroundColor(.white)
        .registerCell(WalkthroughCell.self, reuseIdentifier: WalkthroughCell.identifier)
        .showsVerticalScrollIndicator(false)
        .showsHorizontalScrollIndicator(false)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        addSubviews()
    }
 }

// MARK: UILayout
extension WalkthroughViewController {
    private func addSubviews() {
        addNextButton()
        addPageControl()
        addCollectionView()
        addDismissButton()
    }
    private func addNextButton() {
        view.addSubview(nextButton)
        nextButton.bottomToSuperview(usingSafeArea: true)
        nextButton.trailingToSuperview().constant = -15
        nextButton.leadingToSuperview().constant  = 15
        nextButton.height(60)
    }
    
    private func addCollectionView() {
          view.addSubview(collectionView)
          collectionView.topToSuperview(usingSafeArea: true)
          collectionView.leadingToSuperview()
          collectionView.trailingToSuperview()
          collectionView.bottomToTop(of: pageControl).constant = -30
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        pageControl.centerXToSuperview()
        pageControl.bottomToTop(of: nextButton).constant = -20
    }
    
    private func addDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.topToSuperview(usingSafeArea: true).constant = 25
        dismissButton.trailingToSuperview().constant               = -20
    }
}

// MARK: Configure
extension WalkthroughViewController {
    private func contentConfigure() {
        view.backgroundColor                 = .white
        collectionView.delegate              = self
        collectionView.dataSource            = self
        pageControl.isUserInteractionEnabled = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.setTitle(L10n.Modules.WalkThrough.next, for: .normal)
    }
}

// MARK: UICollectionViewDataSource
extension WalkthroughViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsAt(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCell.identifier, for: indexPath) as? WalkthroughCell else {fatalError("Could not dequeu WalkthroughCell")}
        let cellItem   = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        return cell
    }
}

// MARK: - Actions
extension WalkthroughViewController {
    @objc
    private func nextButtonTapped() {
        if pageControl.currentPage == viewModel.numberOfItemsAt(section: 0) - 1 {
            viewModel.finishedIntro()
        } else {
            pageControl.currentPage += 1
            let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension WalkthroughViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        
        if pageControl.currentPage == viewModel.numberOfItemsAt(section: 0) - 1 {
            nextButton.setTitle(L10n.Modules.WalkThrough.start, for: .normal)
        } else {
            nextButton.setTitle(L10n.Modules.WalkThrough.next, for: .normal)
        }
    }
 }
