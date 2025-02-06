//
//  ContentView.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import SwiftUI

struct ContentView: View {
    let model = CatViewModel()
    var body: some View {
        CatListView(viewModel: model)
    }
}

#Preview {
    ContentView()
}





//4. Your code must be Unit/UI tested
//9. Include a README that details information about your project, dependencies, setup, and requirements.
