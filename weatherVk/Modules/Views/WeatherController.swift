//
//  WeatherController.swift
//  weatherVk
//
//  Created by test on 21.07.2024.
//

import UIKit

protocol WeatherView: AnyObject {
    func displayWeatherData(_ weatherData: [WeatherModel])
    func updateConditionImage(with image: UIImage?)
    func selectItem(at indexPath: IndexPath)
    func scrollToItem(at indexPath: IndexPath)
}

final class WeatherController: UIViewController {
    private let flowLayout: UICollectionViewFlowLayout
    private let backgroundView: ConditionImageView
    private let weatherCollectionView: UICollectionView
    
    var presenter: WeatherPresenterProtocol?
    
    init(weatherData: [WeatherModel]) {
        self.flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: Constants.section,
                                               left: Constants.section,
                                               bottom: Constants.section,
                                               right: Constants.section)
        flowLayout.itemSize = CGSize(width: Constants.sectionWidth,
                                     height: Constants.sectionHeight)
        
        self.backgroundView = ConditionImageView()
        self.weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = WeatherPresenter(view: self, weatherData: weatherData)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func loadView() {
        super.loadView()
        backgroundView.frame = view.bounds
        view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        weatherCollectionView.backgroundColor = .clear
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherConditionCell.self, forCellWithReuseIdentifier: WeatherConditionCell.reuseID)
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: Constants.heightAnchorCollection)
        ])
    }
}

extension WeatherController: WeatherView {
    func displayWeatherData(_ weatherData: [WeatherModel]) {
        weatherCollectionView.reloadData()
    }
    
    func updateConditionImage(with image: UIImage?) {
        backgroundView.setImage(with: image)
    }
    
    func selectItem(at indexPath: IndexPath) {
        weatherCollectionView.selectItem(at: indexPath,
                                         animated: true,
                                         scrollPosition: .centeredHorizontally)
    }
    
    func scrollToItem(at indexPath: IndexPath) {
        weatherCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.weatherData.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherConditionCell.reuseID,
                                                            for: indexPath) as? WeatherConditionCell else {
            return UICollectionViewCell()
        }
        
        let condition = presenter?.weatherData[indexPath.row]
        cell.configure(image: UIImage(systemName: condition?.iconName ?? ""),
                       title: NSLocalizedString(condition?.name ?? "", comment: ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WeatherConditionCell else { return }
        cell.runAnimation()
        presenter?.didSelectItem(at: indexPath)
    }
}

//MARK: - Constants

fileprivate extension WeatherController {
    enum Constants {
        static let section = 8.0
        static let sectionWidth = 140
        static let sectionHeight = 90
        static let heightAnchorCollection = 100.0
        static let fatalError = "init(coder:) has not been implemented"
    }
}
