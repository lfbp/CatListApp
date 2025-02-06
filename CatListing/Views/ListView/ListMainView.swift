//
//  ListMainView.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 05/02/25.
//

import SwiftUI


struct ListMainView: View {
    @StateObject var viewModel: GenericClassViewModel
    var body: some View {
        List(viewModel.cats) { cat in
            NavigationLink(destination: CatDetailView(cat: cat)) {
                CatRowView(cat: cat)
                    .onAppear(perform: {
                        if cat.id == viewModel.cats.last?.id {
                            viewModel.fetchCats()
                        }
                    })
            }
        }
        .navigationTitle("Cats")
    }
}


