//
//  CitySearchScreen.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct CitySearchScreen: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            if viewModel.searchIsActive {
                SearchResultListView(searchString: $viewModel.searchText)
            } else {
                Rectangle()
                    .foregroundStyle(.red)
                    .ignoresSafeArea()
            }
        }
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive)
        .navigationTitle("Cities")
    }
}

#Preview {
    CitySearchScreen()
}
