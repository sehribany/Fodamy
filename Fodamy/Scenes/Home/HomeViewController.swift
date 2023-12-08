//
//  HomeViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Segmentio
import KeychainSwift
import MobilliumBuilders
import MobilliumUserDefaults

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let logoView    = LogoView()
    private let segmentView = Segmentio()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var subViewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        addSegmentView()
        addPageViewController()
        addNavigationBarLogo()
    }
    
    private func addSegmentView() {
        view.addSubview(segmentView)
        segmentView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        segmentView.height(46)
    }
    
    private func addPageViewController() {
        view.addSubview(pageViewController.view)
        pageViewController.view.edgesToSuperview(excluding: .top, usingSafeArea: true)
        pageViewController.view.topToBottom(of: segmentView)
    }
}

// MARK: - Configure and Set Localize
extension HomeViewController {
    
    private func configureContents() {
        navigationItem.titleView = logoView
        view.backgroundColor = Asset.Colors.appSecondaryBackground.color
        segmentView.setup(content: [SegmentioItem(title: viewModel.segmentedControlTitles[0], image: nil),
                                    SegmentioItem(title: viewModel.segmentedControlTitles[1], image: nil)], style: .onlyLabel, options: .options())
        segmentView.selectedSegmentioIndex = viewModel.selectedSegmentIndex
        definesPresentationContext = true
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([subViewControllers[viewModel.selectedSegmentIndex]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        setSegmentHandler()
    }
}

// MARK: - Helper
extension HomeViewController {
    private func preparedViewControllers() -> [UIViewController] {
        let editorChoiceRouter            = RecipesRouter()
        let editorChoiceViewModel         = RecipesViewModel(recipesListingType: .editorChoiceRecipes, router: editorChoiceRouter)
        let editorChoiceViewController    = RecipesViewController(viewModel: editorChoiceViewModel)
        editorChoiceRouter.viewController = editorChoiceViewController
        
        let recentlyAddedRouter                = RecipesRouter()
        let recentlyAddedRecipesViewModel      = RecipesViewModel(recipesListingType: .recentlyAddedRecipes, router: recentlyAddedRouter)
        let recentlyAddedRecipesViewController = RecipesViewController(viewModel: recentlyAddedRecipesViewModel)
        recentlyAddedRouter.viewController     = recentlyAddedRecipesViewController
        
        return [
            editorChoiceViewController,
            recentlyAddedRecipesViewController
        ]
    }
    
    private func setSegmentHandler() {
        segmentView.valueDidChange = { [weak self] _, segmentIndex in
            guard let self = self else { return }
            var direction: UIPageViewController.NavigationDirection = .forward
            if segmentIndex < self.viewModel.selectedSegmentIndex {
                direction = .reverse
            }
            self.pageViewController.setViewControllers([self.subViewControllers[segmentIndex]], direction: direction, animated: true, completion: nil)
            self.viewModel.selectedSegmentIndex = segmentIndex
        }
    }
}

// MARK: - UIPageViewController
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = subViewControllers.firstIndex(of: currentViewController) {
                segmentView.selectedSegmentioIndex = index
            }
        }
    }
}
