//
//  SceneDelegate.swift
//  weatherVk
//
//  Created by test on 21.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Создание массива weatherData
        let weatherData: [WeatherModel] = [
            WeatherModel(name: "bliss", iconName: "figure.archery", imageName: "bliss"),
            WeatherModel(name: "cloudy", iconName: "cloud.fill", imageName: "cloudy"),
            WeatherModel(name: "flood", iconName: "water.waves.and.arrow.up", imageName: "flood"),
            WeatherModel(name: "hail", iconName: "cloud.hail", imageName: "hail"),
            WeatherModel(name: "meteor", iconName: "person.slash", imageName: "meteor"),
            WeatherModel(name: "rainy", iconName: "sun.rain.fill", imageName: "rainy"),
            WeatherModel(name: "snowy", iconName: "cloud.snow", imageName: "snowy"),
            WeatherModel(name: "solarEclipse", iconName: "sun.max.circle", imageName: "solarEclipse"),
            WeatherModel(name: "storm", iconName: "tropicalstorm", imageName: "storm"),
            WeatherModel(name: "sunny", iconName: "sun.max.fill", imageName: "sunny"),
            WeatherModel(name: "tornado", iconName: "tornado", imageName: "tornado")
        ]

        let weatherController = WeatherController(weatherData: weatherData)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = weatherController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}


