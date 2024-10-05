//
//  WeatherHomeScreen.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import SwiftUI

struct WeatherHomeScreen: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            if verticalSizeClass == .compact {
                landscapeView
            } else {
                portraitView
            }
        }
        .navigationBarHidden(true)
    }

    var portraitView: some View {
        VStack {
            hamburgerMenuView
            Spacer()
            VStack {
                WeatherHomeHeaderView()
                WeatherHourlyForecastView()
                    .padding(.vertical)
            }
            .environment(\.city, viewModel.city)
            Spacer()
        }
        .padding()
    }

    var landscapeView: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    WeatherHomeHeaderView()
                    Spacer()
                    VStack {
                        hamburgerMenuView
                            .frame(width: 100)
                        Spacer()
                    }
                    .padding(.top, 30)
                }
                WeatherHourlyForecastView()
                    .padding(.vertical)
            }
            .environment(\.city, viewModel.city)
            Spacer()
        }
        .padding()
    }

    var hamburgerMenuView: some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.loadSearchScreen()
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 30))
            })
            .tint(.primary)
        }
    }
}

#Preview {
    WeatherHomeScreen(viewModel: WeatherHomeScreen.ViewModel(city: City(name: "Buffalo", state: "NY", country: "US")))
}
