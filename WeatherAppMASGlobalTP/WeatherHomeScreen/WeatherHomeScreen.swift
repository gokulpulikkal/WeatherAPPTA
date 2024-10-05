//
//  WeatherHomeScreen.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import SwiftUI

struct WeatherHomeScreen: View {

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
            VStack {
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
                .padding(.bottom, 20)
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
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WeatherHomeScreen(viewModel: WeatherHomeScreen.ViewModel())
}
