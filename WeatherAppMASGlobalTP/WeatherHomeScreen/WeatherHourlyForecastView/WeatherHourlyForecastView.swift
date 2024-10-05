//
//  WeatherHourlyForecastView.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct WeatherHourlyForecastView: View {

    @Environment(\.city) var city
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
        .frame(height: 100)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    .white.opacity(0.2)
                        .shadow(.drop(
                            color: .black.opacity(0.3),
                            radius: 10
                        ))
                )
        )
        .task {
            await viewModel.getHourlyWeatherData(city: city)
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
