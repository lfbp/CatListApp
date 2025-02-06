//
//  CatDetailView.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    
    let defaultName = "Unknown Breed"
    let defaultTemperament = "Unknown temperament"
    let defaultWeight = "Unknown weight"
    let defaultOrigin = "Unknown origin"
    let defaultWikiURL = "https://en.wikipedia.org/wiki/Cat" // Generic fallback link
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let imageURL = cat.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 250, height: 250)
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 5)
                            
                        case .failure:
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                                .foregroundColor(.gray)
                                .opacity(0.6)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(cat.name ?? defaultName)
                        .font(.title)
                        .bold()
                    
                    DetailRow(label: "Temperament", value: cat.temperament ?? defaultTemperament)
                    DetailRow(label: "Weight", value: (cat.weight ?? defaultWeight) + " in kg")
                    DetailRow(label: "Origin", value: cat.origin ?? defaultOrigin)
                    
                    if let wikiURL = cat.wikiURL, let url = URL(string: wikiURL) {
                        Link("Learn more on Wikipedia", destination: url)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Cat Details")
        }
        .padding()
    }
}

// Reusable row for displaying details
struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    CatDetailView(cat: .init(name: nil, temperament: nil, imageURL: nil, weight: nil, origin: nil, wikiURL: nil))
}


