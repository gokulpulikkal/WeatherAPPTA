//
//  CitySearchView.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct CitySearchView: View {

    @State var searchString = ""
    @State var viewModel: ViewModel
    @State private var searchTask: Task<Void, Never>?

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                    Text("Search City name or Zipcode")
                        .font(.subheadline)
                }
                .opacity(0.7)
            case let .success(cityList):
                List {
                    ForEach(cityList, id: \.self, content: { city in
                        HStack {
                            Text("\(city.name),")
                            if let state = city.state {
                                Text("\(state),")
                            }
                            Text("\(city.country)")
                        }
                        .lineLimit(1)
                        .onTapGesture {
                            Task {
                                await viewModel.saveSelectedCity(city: city)
                            }
                        }
                    })
                }
                .padding(.vertical)
            case .failure:
                errorView
            }
        }
        .searchable(text: $searchString)
        .onChange(of: searchString) { _, newValue in
            searchTask?.cancel()
            searchTask = Task {
                await viewModel.performCitySearch(searchString: newValue)
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Search Cities")
    }

    var errorView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 80))
            Text("Not able to find the city")
        }
    }
}

#Preview {
    CitySearchView(viewModel: CitySearchView.ViewModel())
}
