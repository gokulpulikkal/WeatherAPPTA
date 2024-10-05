//
//  WeatherResponseMock.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//


enum WeatherResponseMock {

    static func mockWeatherResponse(
        name: String = "Buffalo",
        weather: [WeatherOverall] = [mockWeatherOverall()],
        main: WeatherDetails = mockWeatherDetails()
    ) -> WeatherResponse {
        WeatherResponse(weather: weather, main: main, name: name)
    }

    static func mockWeatherOverall(
        id: Int = 800,
        main: String = "Clear",
        description: String = "clear sky",
        icon: String = "01d"
    ) -> WeatherOverall {
        WeatherOverall(id: id, main: main, description: description, icon: icon)
    }

    static func mockWeatherDetails(
        temp: Double = 25.0,
        feelsLike: Double = 24.5,
        tempMin: Double = 22.0,
        tempMax: Double = 28.0,
        pressure: Int = 1013,
        humidity: Int = 60,
        seaLevel: Int = 1010,
        grndLevel: Int = 1005
    ) -> WeatherDetails {
        WeatherDetails(
            temp: temp,
            feelsLike: feelsLike,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: pressure,
            humidity: humidity,
            seaLevel: seaLevel,
            grndLevel: grndLevel
        )
    }
}