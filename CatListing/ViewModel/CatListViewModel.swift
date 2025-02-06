//
//  CatListViewModel.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import Foundation

enum ViewModelState {
    case none
    case waiting
    case success
    case failure(APIError)
}
class GenericClassViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var status: ViewModelState = .none
    func fetchCats() {}
}

class CatViewModel: GenericClassViewModel {
    
    private var apiHandler = APIHandler(apiKey: Constants.key.rawValue, baseURL: Constants.baseURL.rawValue)
    var pageNumber = 0
    
    override init() {
        super.init()
        status = .waiting
        fetchCats()
    }
    
    override func fetchCats() {
        apiHandler.fetchCats(page: pageNumber, completion: { result in
            switch result {
            case .success(let response):
                let cats = response.map { element in
                    let breed = element.breeds?.first
                    let name = breed?.name
                    let temperament = breed?.temperament
                    let weight = breed?.weight?.metric
                    let wikipediaURL = breed?.wikipediaURL
                    let origin = breed?.origin
                    let url = element.url
                    return Cat(name: name, temperament: temperament, imageURL: url, weight: weight, origin: origin, wikiURL: wikipediaURL)
                }
                self.cats += cats
                self.pageNumber+=1
                self.status = .success
            case .failure(let error):
                self.status = .failure(error)
            }
            
        })
    }
}
