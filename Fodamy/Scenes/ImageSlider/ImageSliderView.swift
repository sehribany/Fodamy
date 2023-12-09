//
//  ImageSliderView.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import UIKit
import MobilliumBuilders

public class ImageSliderView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: ImageSliderCell.identifier)
        return collectionView
    }()
    private let pageControl = UIPageControlBuilder()
        .pageIndicatorTintColor(Asset.Colors.appRed.color.withAlphaComponent(0.3))
        .currentPageIndicatorTintColor(Asset.Colors.appRed.color)
        .build()
    var imageSliderData: [ImageSliderCellProtocol] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = imageSliderData.count
            pageControl.isHidden      = pageControl.numberOfPages == 1
        }
    }
   
    var photoBrowserDelegate: PhotoBrowserDelegate?
    weak var viewModel      : ImageSliderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
        addSubViews()
    }
}
// MARK: - UILayout
extension ImageSliderView {
    
    private func addSubViews() {
        addSliderCollectionView()
        addPageControl()
    }
    
    private func addSliderCollectionView() {
        addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
    private func addPageControl() {
        addSubview(pageControl)
        pageControl.bottom(to: collectionView)
        pageControl.centerX(to: collectionView)
    }
}
// MARK: - Configure and SetLocalize
extension ImageSliderView {
    
    private func configureContents() {
        collectionView.delegate = self
        collectionView.dataSource = self
        configurePhotoBrowserDelegate()
    }
    
    public func set(viewModel: ImageSliderViewProtocol) {
        self.viewModel = viewModel
        self.imageSliderData = viewModel.cellItems
    }
    
    private func configurePhotoBrowserDelegate() {
        photoBrowserDelegate = PhotoBrowserDelegate()
        photoBrowserDelegate?.willDismissAtPage = { [weak self] (index) in
            guard let self = self else { return }
            let indexPath = IndexPath(item: index, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = index
        }
    }
}

// MARK: - UIScrollViewDelegate
extension ImageSliderView {
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = UIScreen.main.bounds.width
        let xPoint = targetContentOffset.pointee.x
        let pageIndex = Int(xPoint / width)
        pageControl.currentPage = pageIndex
    }

}
// MARK: - UICollectionViewDelegate
extension ImageSliderView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = photoBrowserDelegate else { return }
        let photos = imageSliderData.map { $0.imageUrl }
        AppRouter.shared.presentSKPhotoBrowser(with: photos, delegate: delegate, initialPageIndex: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension ImageSliderView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSliderData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageSliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCell.identifier, for: indexPath) as! ImageSliderCell
        let cellItem = imageSliderData[indexPath.row]
        cell.set(viewModel: cellItem)
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ImageSliderView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: width)
    }
    
}

// MARK: - UIScrollViewDelegate
extension ImageSliderView {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
