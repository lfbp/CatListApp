//
//  CatListView.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import SwiftUI

struct CatListView: View {
    
    @StateObject var viewModel: GenericClassViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.status {
            case .success:
                ListMainView(viewModel: viewModel)
            case .none:
                Text("None")
            case .waiting:
                ProgressView()
                    .frame(width: 80, height: 80)
            case .failure(let apiError):
                APIErrorView(errorMessage: apiError.localizedDescription, retryAction: {viewModel.fetchCats()})
                    .padding()
            }
                
            
        }
    }
}


#Preview {
    CatListView(viewModel: CatViewModel())
}
