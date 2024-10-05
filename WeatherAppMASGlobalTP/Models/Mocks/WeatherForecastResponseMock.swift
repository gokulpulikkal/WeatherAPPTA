//
//  WeatherForecastResponseMock.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

enum WeatherForecastResponseMock {

    static func mockWeatherForecastResponse(
        cod: String = "200",
        message: Int = 0,
        cnt: Int = 5,
        list: [WeatherForecastEntry] = [mockWeatherForecastEntry()]
    ) -> WeatherForecastResponse {
        WeatherForecastResponse(
            cod: cod,
            message: message,
            cnt: cnt,
            list: list
        )
    }

    static func mockWeatherForecastEntry(
        dt: Int = 1_633_035_600, // Example timestamp
        main: WeatherDetails = WeatherResponseMock.mockWeatherDetails(),
        weather: [WeatherOverall] = [WeatherResponseMock.mockWeatherOverall()],
        dtTxt: String = "2024-10-05 12:00:00"
    ) -> WeatherForecastEntry {
        WeatherForecastEntry(
            dt: dt,
            main: main,
            weather: weather,
            dtTxt: dtTxt
        )
    }
}
