//
//  SearchResultListView.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import SwiftUI

struct SearchResultListView: View {

    @Binding var searchString: String
    @State var viewModel = ViewModel()
    @State private var searchTask: Task<Void, Never>?

    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                ProgressView()
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
                    })
                }
                .padding(.vertical)
            case .failure:
                errorView
            }
        }
        .onChange(of: searchString) { _, newValue in
            searchTask?.cancel()
            searchTask = Task {
                await viewModel.performCitySearch(searchString: newValue)
            }
        }
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
    SearchResultListView(searchString: .constant(""))
}
