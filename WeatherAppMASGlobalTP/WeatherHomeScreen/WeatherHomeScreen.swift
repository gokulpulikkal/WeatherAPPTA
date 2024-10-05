//
//  WeatherHomeScreen.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import SwiftUI

struct WeatherHomeScreen: View {

    /// Access the current device's vertical size class (compact or regular)
    @Environment(\.verticalSizeClass) var verticalSizeClass

    /// State property to manage the view model for this screen
    @State private var viewModel: ViewModel

    /// StateObject to observe the location manager for location services
    @StateObject private var locationManager = LocationManager()

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
        // Update the view model's city based on changes in location
        .onChange(of: locationManager.locationCity) {
            viewModel.updateLastUpdatedLocationCity(city: locationManager.locationCity)
        }
        // Toggle location services based on the view model's CoreLocation update flag
        .onChange(of: viewModel.shouldUpdateWithCoreLocation) {
            locationManager.locationServiceIsActive = viewModel.shouldUpdateWithCoreLocation
        }
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
                viewModel.shouldUpdateWithCoreLocation = true
                locationManager.checkLocationAuthorization()
            }, label: {
                Image(systemName: "location")
                    .font(.system(size: 20))
            })

            Button(action: {
                viewModel.loadSearchScreen()
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 30))
            })
        }
        .tint(.primary)
    }
}

#Preview {
    WeatherHomeScreen(viewModel: WeatherHomeScreen.ViewModel(city: City(name: "Buffalo", state: "NY", country: "US")))
}
