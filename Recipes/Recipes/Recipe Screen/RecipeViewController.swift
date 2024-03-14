// RecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран рецептов
final class RecipeViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Recipes"
        static let cellSpacing: CGFloat = 15
        static let tabBarImage = "muffin"
        static let tabBarImageFill = "muffin.fill"
    }

    // MARK: - Visual Components

    private lazy var collectionView = UICollectionView()

    // MARK: - Public Properties

    var presenter: RecipePresenterProtocol?
    var officiant: Invoker? = Invoker.shared
    
    var networkService = NetworkService()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        collectionView.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        //TODO: временно тут, для тестирования запроса
        networkService.getRecipeDetail(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_37b6f298818e8827d6eb0880ec8ea627") { result in
            switch result {
            case let .success(recipe):
                
                print("Received recipes: \(recipe.name)")
            case let .failure(error):
                print("Error fetching recipes: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        order(command: OpenCategoryScreenCommand())
    }

    // MARK: - Public Methods

    func setupUI() {
        view.backgroundColor = .white

        tabBarItem = UITabBarItem(
            title: Constants.titleText,
            image: UIImage(named: Constants.tabBarImage),
            selectedImage: UIImage(named: Constants.tabBarImageFill)
        )
    }

    // MARK: - Private Methods

    private func order(command: Command) {
        guard let officiant = officiant else {
            print("error")
            return
        }
        officiant.addCommand(OpenCategoryScreenCommand())
        officiant.executeCommands()
    }

    
    private func setupNavigation() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.verdanaBold28()
        titleLabel.text = Constants.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - RecipeViewController + RecipeViewControllerProtocol

extension RecipeViewController: RecipeViewControllerProtocol {}

// MARK: - RecipeViewController + UICollectionViewDelegate

extension RecipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToCategoryListScreen(for: presenter?.categories[indexPath.row].title ?? "")
    }
}

// MARK: - RecipeViewController + UICollectionViewDataSource

extension RecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.categories.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        ) as? CategoryCollectionViewCell {
            cell.clipsToBounds = true
            cell.setCellData(
                title: presenter?.categories[indexPath.item].title ?? "",
                image: presenter?.categories[indexPath.item].image ?? ""
            )

            let cornerRadius = min(cell.bounds.width, cell.bounds.height) / 10
            cell.updateCornerRaduis(with: cornerRadius)

            cell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.layer.shadowOffset = CGSizeMake(1, 4.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 0.5
            cell.layer.masksToBounds = false

            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - RecipeViewController + UICollectionViewDelegateFlowLayout

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat
        let height: CGFloat
        let screenWidth = UIScreen.main.bounds.width

        switch indexPath.item {
        case 0, 1, 7, 8:
            width = (screenWidth / 2) - (1.5 * Constants.cellSpacing)
            height = width
        case 2, 6:
            width = screenWidth - (2 * Constants.cellSpacing)
            height = screenWidth * 0.65
        case 3, 4, 5:
            width = (screenWidth - (4 * Constants.cellSpacing)) / 3
            height = width
        default:
            return .zero
        }
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.cellSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Constants.cellSpacing,
            left: Constants.cellSpacing,
            bottom: Constants.cellSpacing,
            right: Constants.cellSpacing
        )
    }
}
