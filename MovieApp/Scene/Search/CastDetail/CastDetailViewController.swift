//
//  CastDetailViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import UIKit
import SDWebImage
import TinyConstraints

class CastDetailsViewController: UIViewController {
    private let viewModel: CastDetailsViewModel
    private var isBiographyExpanded = false

    // MARK: - Initialization

    init(viewModel: CastDetailsViewModel) {
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
        view.backgroundColor = .clear
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = ColorManager.primary
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()


    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.headline1()
        label.numberOfLines = 4
        label.textColor = .white
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.subtitleAndMenu()
        label.textColor = .white
        label.numberOfLines = 5
        return label
    }()

    private lazy var readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(ColorManager.primary, for: .normal)
        button.titleLabel?.font = FontManager.bodyAndForms()
        button.addTarget(self, action: #selector(toggleBiography), for: .touchUpInside)
        return button
    }()

    private lazy var movieCreditsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(KnownForCollectionViewCell.self, forCellWithReuseIdentifier: "KnownForCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark
         
         view.addSubview(scrollView)
         scrollView.edgesToSuperview()

         scrollView.addSubview(contentView)
         contentView.edgesToSuperview()
         contentView.width(to: scrollView)

         view.addSubview(backButton)

         backButton.size(CGSize(width: 40, height: 40))
         backButton.topToSuperview(offset: 75)
         backButton.leadingToSuperview(offset: 20)

         [profileImageView, nameLabel, infoStackView, biographyLabel, readMoreButton, movieCreditsCollectionView].forEach {
             contentView.addSubview($0)
         }

         profileImageView.topToSuperview(offset: 60)
         profileImageView.leadingToSuperview(offset: 20)
         profileImageView.width(120)
         profileImageView.height(180)

         nameLabel.top(to: profileImageView, offset: 20)
         nameLabel.leadingToTrailing(of: profileImageView, offset: 20)
         nameLabel.trailingToSuperview(offset: 20)

         infoStackView.topToBottom(of: profileImageView, offset: 20)
         infoStackView.horizontalToSuperview(insets: .horizontal(20))

         setupInfoStackView()

         biographyLabel.topToBottom(of: infoStackView, offset: 20)
         biographyLabel.horizontalToSuperview(insets: .horizontal(20))

         readMoreButton.topToBottom(of: biographyLabel, offset: 20)
         readMoreButton.leadingToSuperview(offset: 20)

         movieCreditsCollectionView.topToBottom(of: readMoreButton, offset: 20)
         movieCreditsCollectionView.leadingToSuperview(offset: 20)
         movieCreditsCollectionView.trailingToSuperview(offset: 20)
         movieCreditsCollectionView.height(200)
         movieCreditsCollectionView.bottomToSuperview(offset: -20)
    }

    private func setupInfoStackView() {
        let infoItems = [("Birthday", "birthdayValue"), ("Place of Birth", "placeOfBirthValue")]

        for (title, value) in infoItems {
            let itemView = createInfoItemView(title: title, value: value)
            infoStackView.addArrangedSubview(itemView)
            infoStackView.alignment = .leading
        }
    }

    private func createInfoItemView(title: String, value: String) -> UIView {
        let containerView = UIView()

        let titleLabel = UILabel()
        titleLabel.font = FontManager.bodyAndForms()
        titleLabel.textColor = ColorManager.highEmphasis
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.font = FontManager.bodyAndForms()
        valueLabel.textColor = ColorManager.surfaceLight
        valueLabel.text = value

        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)

        titleLabel.leadingToSuperview()
        titleLabel.topToSuperview()
        titleLabel.bottomToSuperview()

        valueLabel.leadingToTrailing(of: titleLabel, offset: 8)
        valueLabel.trailingToSuperview()
        valueLabel.topToSuperview()
        valueLabel.bottomToSuperview()

        return containerView
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

    private func updateUI() {
        if let castDetails = viewModel.castDetails {
            nameLabel.text = castDetails.name

            if let profilePath = castDetails.profilePath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
                profileImageView.sd_setImage(with: url, completed: nil)
            } else {
                profileImageView.image = UIImage(named: "default-profile")
            }

            biographyLabel.text = castDetails.biography ?? "No biography available."

            // Update info items
            if let birthdayLabel = infoStackView.arrangedSubviews[0].subviews.last as? UILabel {
                birthdayLabel.text = castDetails.birthday ?? "N/A"
            }
            if let placeOfBirthLabel = infoStackView.arrangedSubviews[1].subviews.last as? UILabel {
                placeOfBirthLabel.text = castDetails.placeOfBirth ?? "N/A"
                placeOfBirthLabel.numberOfLines = 2
                placeOfBirthLabel.textAlignment = .justified
            }
        }

        movieCreditsCollectionView.reloadData()
    }

    // MARK: - Button Actions

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func toggleBiography() {
        isBiographyExpanded.toggle()
        UIView.animate(withDuration: 0.3) {
            self.biographyLabel.numberOfLines = self.isBiographyExpanded ? 0 : 5
            self.readMoreButton.setTitle(self.isBiographyExpanded ? "Read Less" : "Read More", for: .normal)
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Helper Methods

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension CastDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieCredits?.cast.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KnownForCell", for: indexPath) as? KnownForCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let movie = viewModel.movieCredits?.cast[indexPath.row] {
            cell.configure(with: movie.id) // Movie ID'sini geçiriyoruz
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieCredits = viewModel.movieCredits else { return }

        let selectedCredit = movieCredits.cast[indexPath.row]

        let titlePreviewViewModel = TitlePreviewViewModel(movieService: MovieService(), youtubeService: YoutubeService(), tvShowService: TVShowService())
        
        if selectedCredit.mediaType == .movie {
            titlePreviewViewModel.fetchMovieDetails(for: selectedCredit.id)
        } else {
            titlePreviewViewModel.fetchTVShowDetails(for: selectedCredit.id)
        }

        let titlePreviewVC = TitlePreviewViewController(viewModel: titlePreviewViewModel)
        navigationController?.pushViewController(titlePreviewVC, animated: true)
    }
}
