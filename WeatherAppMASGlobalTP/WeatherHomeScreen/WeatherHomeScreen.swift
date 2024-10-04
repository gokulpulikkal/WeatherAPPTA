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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            ScrollView {
                WeatherHomeHeaderView()
                WeatherHourlyForecastView()
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
                    .padding(.vertical)
            }
            .padding()
        }
    }
}

#Preview {
    WeatherHomeScreen()
}
