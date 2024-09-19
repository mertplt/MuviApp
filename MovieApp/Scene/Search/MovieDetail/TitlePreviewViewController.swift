//
//  TitlePreviewViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import UIKit
import WebKit
import TinyConstraints
import SDWebImage
import SafariServices

class TitlePreviewViewController: UIViewController {
    private var viewModel: TitlePreviewViewModel
    private var isOverviewExpanded = false

    init(viewModel: TitlePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.surfaceDark
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = ColorManager.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [ColorManager.surfaceDark.withAlphaComponent(1).cgColor, UIColor.clear.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()

    private lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, ColorManager.surfaceDark.withAlphaComponent(1).cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = ColorManager.surfaceLight.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var ratingView: MaRatingView = {
        let ratingView = MaRatingView()
        ratingView.configure(rating: 0.0, voteCount: 0)
        return ratingView
    }()

    private lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        return label
    }()

    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        return label
    }()

    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        label.numberOfLines = 4
        return label
    }()

    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.subtitleAndMenu()
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 4
        return label
    }()

    private lazy var expandOverviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(ColorManager.primary, for: .normal)
        button.titleLabel?.font = FontManager.bodyAndForms()
        button.addTarget(self, action: #selector(toggleOverview), for: .touchUpInside)
        return button
    }()

    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        return label
    }()

    private lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var trailerButton: MaButton = {
        let button = MaButton()
        button.style = .smallButtonYellow
        button.buttonTitle = "Watch Trailer"
        button.addTarget(self, action: #selector(watchTrailerTapped), for: .touchUpInside)
        return button
    }()

    private lazy var addListButton: MaButton = {
        let button = MaButton()
        button.style = .smallButtonDark
        button.Icon = .plus
        button.buttonTitle = "My List"
        button.addTarget(self, action: #selector(addListButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        setupGradientLayers()
        setupBackButton()
    }

    private func setupGradientLayers() {
        backdropImageView.layer.addSublayer(topGradientLayer)
        backdropImageView.layer.addSublayer(bottomGradientLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated) // Navigation bar'ı gizliyoruz
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated) // Navigation bar'ı gizliyoruz
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated) // Navigation bar'ı geri getiriyoruz
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark

        view.addSubview(scrollView)
        scrollView.edgesToSuperview()
        
        self.navigationItem.hidesBackButton = true

        scrollView.addSubview(contentView)
        contentView.edgesToSuperview()
        contentView.width(to: scrollView)

        [
            backdropImageView,
            posterImageView,
            titleLabel,
            infoStackView,
            genresLabel,
            overviewLabel,
            expandOverviewButton,
            directorLabel,
            castCollectionView,
            trailerButton,
            addListButton
        ].forEach {
            contentView.addSubview($0)
        }

        view.addSubview(backButton)

        backdropImageView.edgesToSuperview(excluding: .bottom)
        backdropImageView.height(230)

        backButton.topToSuperview(offset: 75)
        backButton.leadingToSuperview(offset: 20)
        backButton.size(CGSize(width: 40, height: 40))

        posterImageView.topToBottom(of: backdropImageView, offset: -50)
        posterImageView.leadingToSuperview(offset: 20)
        posterImageView.size(CGSize(width: 120, height: 180))

        titleLabel.topToBottom(of: backdropImageView, offset: -10)
        titleLabel.leadingToTrailing(of: posterImageView, offset: 20)
        titleLabel.trailingToSuperview(offset: 20)
        

        [runtimeLabel, releaseDateLabel, ratingView].forEach { view in
            infoStackView.addArrangedSubview(view)
            if let label = view as? UILabel {
                label.textColor = ColorManager.highEmphasis
                label.font = FontManager.bodyAndForms()
            }
        }

        genresLabel.topToBottom(of: titleLabel, offset: 10)
        genresLabel.leadingToTrailing(of: posterImageView,offset: 20)
        genresLabel.trailingToSuperview(offset: 20)

        overviewLabel.topToBottom(of: infoStackView, offset: 20)
        overviewLabel.leadingToSuperview(offset: 20)
        overviewLabel.trailingToSuperview(offset: 20)

        expandOverviewButton.topToBottom(of: overviewLabel, offset: 5)
        expandOverviewButton.leadingToSuperview(offset: 20)

                
        infoStackView.topToBottom(of: posterImageView, offset: 20)
        infoStackView.leading(to: posterImageView)
        infoStackView.trailingToSuperview(offset: 175)
        
        directorLabel.topToBottom(of: expandOverviewButton, offset: 10)
        directorLabel.leadingToSuperview(offset: 20)
        directorLabel.trailingToSuperview(offset: 20)

        castCollectionView.topToBottom(of: directorLabel, offset: 20)
        castCollectionView.leadingToSuperview(offset: 20)
        castCollectionView.trailingToSuperview(offset: 20)
        castCollectionView.height(250)

        trailerButton.topToBottom(of: castCollectionView, offset: 20)
        trailerButton.leadingToSuperview(offset: 20)

        addListButton.top(to: trailerButton)
        addListButton.trailingToSuperview(offset: 20)
        addListButton.bottomToSuperview(offset: -20)
    }

    // MARK: - ViewModel Binding

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }

        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }
    }

    // MARK: - UI Update Methods

    private func updateGradientFrames() {
        let height = backdropImageView.bounds.height
        let width = backdropImageView.bounds.width
        let gradientHeight = height * 0.3

        topGradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: gradientHeight)
        bottomGradientLayer.frame = CGRect(x: 0, y: height - gradientHeight, width: width, height: gradientHeight)
    }
    private func updateUI() {
        updateAddListButton()

        if let movie = viewModel.movieDetails {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            ratingView.configure(rating: movie.voteAverage ?? 0.0, voteCount: movie.voteCount ?? 0)
            genresLabel.text = viewModel.getFormattedGenres()
            runtimeLabel.text = viewModel.getFormattedRuntime()
            releaseDateLabel.text = viewModel.getFormattedReleaseDate()
            infoStackView.trailingToSuperview(offset: 20)

            if let posterPath = movie.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: url, completed: nil)
            }

            if let backdropPath = movie.backdropPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
                backdropImageView.sd_setImage(with: url, completed: nil)
            }
            
        } else if let tvShow = viewModel.tvShowDetails {
            titleLabel.text = tvShow.name
            overviewLabel.text = tvShow.overview
            ratingView.configure(rating: tvShow.voteAverage ?? 0.0, voteCount: tvShow.voteCount ?? 0)
            genresLabel.text = viewModel.getFormattedGenres()
            runtimeLabel.isHidden = true
            releaseDateLabel.text = viewModel.getFormattedReleaseDate()
            infoStackView.trailingToSuperview(offset: 75)

            if let posterPath = tvShow.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: url, completed: nil)
            }

            if let backdropPath = tvShow.backdropPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
                backdropImageView.sd_setImage(with: url, completed: nil)
            }
        }

        if viewModel.credits != nil {
            directorLabel.text = "Directed by \(viewModel.getDirector())"
        } else if viewModel.tvCredits != nil {
            directorLabel.text = "\(viewModel.getDirector())"
        }
        castCollectionView.reloadData()
    }

    // MARK: - Button Actions

    @objc private func toggleOverview() {
        isOverviewExpanded.toggle()
        UIView.animate(withDuration: 0.3) {
            self.overviewLabel.numberOfLines = self.isOverviewExpanded ? 0 : 4
            self.expandOverviewButton.setTitle(self.isOverviewExpanded ? "Read Less" : "Read More", for: .normal)
            self.view.layoutIfNeeded()
        }
    }

    @objc private func watchTrailerTapped() {
        if let videoID = viewModel.videoID {
            guard let url = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else {
                showAlert(title: "Trailer Unavailable", message: "Invalid video URL.")
                return
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        } else {
            showAlert(title: "Trailer Unavailable", message: "Sorry, the trailer is not available at the moment.")
        }
    }

    private func updateAddListButton() {
        guard let listItem = createListItem() else { return }
        ListViewModel.shared.isInList(listItem) { [weak self] isInList in
            DispatchQueue.main.async {
                self?.addListButton.Icon = isInList ? .check : .plus
                self?.addListButton.buttonTitle = isInList ? "In My List" : "My List"
            }
        }
    }

    @objc private func addListButtonTapped() {
        guard let listItem = createListItem() else { return }

        ListViewModel.shared.isInList(listItem) { [weak self] isInList in
            if isInList {
                ListViewModel.shared.removeFromList(listItem)
            } else {
                ListViewModel.shared.addToList(listItem)
            }
            self?.updateAddListButton()
        }
    }

    // MARK: - Helper Methods

    private func createListItem() -> ListItem? {
        if let movie = viewModel.movieDetails {
            return ListItem(
                id: movie.id,
                title: movie.title,
                image: movie.posterPath ?? "",
                backdrop: movie.backdropPath,
                movie: movie,
                tvShow: nil,
                firstAirDate: nil,
                lastAirDate: nil,
                voteAverage: movie.voteAverage,
                releaseDate: movie.releaseDate
            )
        } else if let tvShow = viewModel.tvShowDetails {
            return ListItem(
                id: tvShow.id,
                title: tvShow.name,
                image: tvShow.posterPath ?? "",
                backdrop: tvShow.backdropPath,
                movie: nil,
                tvShow: tvShow,
                firstAirDate: tvShow.firstAirDate,
                lastAirDate: tvShow.lastAirDate,
                voteAverage: tvShow.voteAverage,
                releaseDate: nil
            )
        }
        return nil
    }

    private func showError(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func setupBackButton() {
        backButton.removeTarget(nil, action: nil, for: .allEvents)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension TitlePreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let credits = viewModel.credits {
            return credits.cast.count
        } else if let tvCredits = viewModel.tvCredits {
            return tvCredits.cast.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let credits = viewModel.credits {
            let castMember = credits.cast[indexPath.row]
            cell.configure(with: castMember)
        } else if let tvCredits = viewModel.tvCredits {
            let castMember = tvCredits.cast[indexPath.row]
            cell.configure(with: castMember)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let credits = viewModel.credits {
            let castMember = credits.cast[indexPath.row]
            let viewModel = CastDetailsViewModel(personService: PersonService(), apiKey: Config.shared.apiKey ?? "")
            viewModel.fetchCastDetails(for: castMember.id)
            let castDetailsVC = CastDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(castDetailsVC, animated: true)
        } else if let tvCredits = viewModel.tvCredits {
            let castMember = tvCredits.cast[indexPath.row]
            let viewModel = CastDetailsViewModel(personService: PersonService(), apiKey: Config.shared.apiKey ?? "")
            viewModel.fetchCastDetails(for: castMember.id)
            let castDetailsVC = CastDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(castDetailsVC, animated: true)
        }
    }
}
