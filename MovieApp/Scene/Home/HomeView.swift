//
//  HomeView.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit
import TinyConstraints

class HomeView: UIViewController {

    var viewModel: HomeViewModel
    var router: HomeRouter
    let networkManager = NetworkManager()
    private let apiKey = Config.shared.apiKey
    
    private var getPopularMoviesRequest: GetPopularMoviesRequest?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorManager.surfaceDark
        return collectionView
    }()

    private let sections = MockData.shared.pageData

    init(viewModel: HomeViewModel, router: HomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        collectionView.register(PortraitCollectionViewCell.self, forCellWithReuseIdentifier: "PortraitCollectionViewCell")
        collectionView.register(LandscapeCollectionViewCell.self, forCellWithReuseIdentifier: "LandscapeCollectionViewCell")
        collectionView.register(mediumCollectionViewCell.self, forCellWithReuseIdentifier: "mediumCollectionViewCell")
        collectionView.register(CollectionViewHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeaderReusableView")

        collectionView.collectionViewLayout = createLayout()
        configureUI()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .stories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(104), heightDimension: .absolute(40)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .popular:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(335), heightDimension: .absolute(189)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .comingSoon:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(240), heightDimension: .absolute(135)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 20, bottom: 55, trailing: 20)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .upcoming:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(240), heightDimension: .absolute(136)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                    section.interGroupSpacing = 10
                    section.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
                    section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                    section.supplementariesFollowContentInsets = false
                return section
            }
        }
    }
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }

    func configureUI() {
        view.backgroundColor = ColorManager.dark
        
        guard let apiKey = apiKey else {
            print("API Key is missing")
            return
        }
        
        getPopularMoviesRequest = GetPopularMoviesRequest(apiKey: apiKey, page: 1)
        
        if let request = getPopularMoviesRequest {
            networkManager.requestWithAlamofire(for: request) { result in
                switch result {
                case .success(let response):
                    print("Page: \(response.page)")
                    response.results.forEach { movie in
                        print("Movie: \(movie.releaseDate)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .stories(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            cell.setup(items[indexPath.row])
            return cell
        case .popular(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
            cell.setup(items[indexPath.row])
            return cell
        case .comingSoon(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandscapeCollectionViewCell", for: indexPath) as! LandscapeCollectionViewCell
            cell.setup(items[indexPath.row])
            return cell
        case .upcoming(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediumCollectionViewCell", for: indexPath) as! mediumCollectionViewCell
            cell.setup(items[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableView", for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

#Preview {
    let router = HomeRouter()
    let viewModel = HomeViewModel(router: router)
    return HomeView(viewModel: viewModel, router: router)
}
