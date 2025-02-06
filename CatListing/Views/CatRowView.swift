//
//  CatRowView.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import SwiftUI

struct CatRowView: View {
    let cat: Cat
    
    private let defaultName = "Unknown Cat"
    
    var body: some View {
        HStack(spacing: 8) {
            if let imageURL = cat.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .padding()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 3)
                            .padding()
                        
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                            .opacity(0.6)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
                
            } else {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                    .opacity(0.6)
                    .padding()
            }
            
            
            Text("Race: \(cat.name ?? defaultName)")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()

            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}


#Preview {
    CatRowView(cat: .init(name: nil, temperament: nil, imageURL: nil, weight: nil, origin: nil, wikiURL: nil))
}

