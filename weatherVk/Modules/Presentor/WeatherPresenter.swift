//
//  WeatherPresenter.swift
//  weatherVk
//
//  Created by test on 22.07.2024.
//

import UIKit

protocol WeatherPresenterProtocol: AnyObject {
    var weatherData: [WeatherModel] { get }
    
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

final class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherView?
    let weatherData: [WeatherModel]
    
    init(view: WeatherView, weatherData: [WeatherModel]) {
        self.view = view
        self.weatherData = weatherData
    }
    
    func viewDidLoad() {
        view?.displayWeatherData(weatherData)
        selectRandomCondition()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let image = retrieveImage(for: indexPath)
        view?.updateConditionImage(with: image)
        view?.selectItem(at: indexPath)
        view?.scrollToItem(at: indexPath)
    }
    
    private func selectRandomCondition() {
        guard let randomCondition = weatherData.randomElement(),
              let index = weatherData.firstIndex(of: randomCondition) else { return }
        
        let indexPath = IndexPath(item: index, section: .zero)
        let image = retrieveImage(for: indexPath)
        
        view?.updateConditionImage(with: image)
        view?.selectItem(at: indexPath)
        view?.scrollToItem(at: indexPath)
    }
    
    private func retrieveImage(for indexPath: IndexPath) -> UIImage? {
        let item = weatherData[indexPath.item]
        return UIImage(named: item.imageName)
    }
}
