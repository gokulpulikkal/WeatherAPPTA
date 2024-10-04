//
//  WeatherForecastEntry.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//
import Foundation

struct WeatherForecastEntry: Codable, Equatable {
    let dt: Int
    let main: WeatherDetails
    let weather: [WeatherOverall]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case dtTxt = "dt_txt" // Mapping JSON key to property
    }
}

extension WeatherForecastEntry {
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: dtTxt)
    }

    var timeString: String {
        guard let date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }
}
