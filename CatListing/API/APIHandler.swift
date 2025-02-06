//
//  APIHandler.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import Foundation

enum APIResult {
    case success(Response)
    case failure(APIError)
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingError
}

enum Constants: String {
    case key = "live_dsYU1S4uJL3u3qDOepBiapMdL0fVTv8FJnniJtXsQ4zZ5rz0R0b9xo4ezHBPmMve"
    case baseURL = "https://api.thecatapi.com/v1/images/search?limit=10&&has_breeds=1"
}

class APIHandler {
    
    private var key: String
    private var baseURL: String
    
    init(apiKey: String, baseURL: String) {
        self.key = apiKey
        self.baseURL = baseURL
    }
    
    func changeURL(key: String = Constants.key.rawValue, baseURL: String = Constants.baseURL.rawValue) {
        self.key = key
        self.baseURL = baseURL
    }
    
    func fetchCats(page: Int, completion: @escaping (APIResult) -> Void) {
        
        let urlString =  self.baseURL + "&api_key=\(key)&page=\(page)"
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching cats: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(.failure(.noData))
                return
            }

            do {
                let decodedCats = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedCats))
                }
            } catch {
                print("❌ Failed to decode JSON: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
