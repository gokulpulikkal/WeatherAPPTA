//
//  WeatherHourlyForecastView.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct WeatherHourlyForecastView: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                ProgressView()
            case let .success(weatherForecastResponse):
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(weatherForecastResponse.list, id: \.dt, content: { forecastItem in
                            VStack {
                                Text(forecastItem.timeString)
                                    .font(.subheadline)
                                AsyncImage(url: forecastItem.weather.first?.iconURL) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                                Text(
                                    Measurement<UnitTemperature>(
                                        value: forecastItem.main.temp.rounded(),
                                        unit: .celsius
                                    )
                                    .formatted(.measurement(
                                        width: .narrow,
                                        usage: .weather
                                    ))
                                )
                            }
                        })
                    }
                }
                .scrollIndicators(.hidden)
            case .failure:
                errorView
            }
        }
        .task {
            await viewModel.getHourlyWeatherData()
        }
    }

    var errorView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 30))
            Text("Error Getting Forecast data")
        }
    }
}

#Preview {
    WeatherHourlyForecastView()
}
