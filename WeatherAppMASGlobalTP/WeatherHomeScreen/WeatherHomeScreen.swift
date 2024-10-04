//
//  WeatherHomeScreen.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import SwiftUI

struct WeatherHomeScreen: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                ProgressView()
            case let .success(weatherResponse):
                Text("Success fetching workout log.")
            case .failure:
                errorView
            }
        }
        .task {
            await viewModel.getCurrentWeatherData()
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
    WeatherHomeScreen()
}
