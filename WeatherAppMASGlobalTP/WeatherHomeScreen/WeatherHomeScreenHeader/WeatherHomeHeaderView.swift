//
//  WeatherHomeHeaderView.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct WeatherHomeHeaderView: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                ProgressView()
            case let .success(weatherResponse):
                mainWeatherHeader(weatherResponse)
            case .failure:
                errorView
            }
        }
        .task {
            await viewModel.getCurrentWeatherData()
        }
    }

    @ViewBuilder
    private func mainWeatherHeader(_ weatherResponse: WeatherResponse) -> some View {
        HStack {
            AsyncImage(url: weatherResponse.weather.first?.iconURL) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(weatherResponse.name)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    Text(
                        Measurement<UnitTemperature>(value: weatherResponse.main.temp.rounded(), unit: .celsius)
                            .formatted(.measurement(
                                width: .narrow,
                                usage: .weather
                            ))
                    )
                    .font(.system(size: 70))
                    .fontWeight(.semibold)
                }
                Text(weatherResponse.weather.first?.description ?? "")
                    .font(.system(size: 20))
                    .opacity(0.7)
                HStack {
                    HStack(spacing: 0) {
                        Text("H:")
                        Text(
                            Measurement<UnitTemperature>(
                                value: weatherResponse.main.temp.rounded(),
                                unit: .celsius
                            )
                            .formatted(.measurement(
                                width: .narrow,
                                usage: .weather
                            ))
                        )
                    }
                    HStack(spacing: 0) {
                        Text("L:")
                        Text(
                            Measurement<UnitTemperature>(
                                value: weatherResponse.main.temp.rounded(),
                                unit: .celsius
                            )
                            .formatted(.measurement(
                                width: .narrow,
                                usage: .weather
                            ))
                        )
                    }
                }
                .fontWeight(.semibold)
            }
        }
    }

    var errorView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 80))
            Text("Error connecting to backend")
        }
    }
}

#Preview {
    WeatherHomeHeaderView()
}
