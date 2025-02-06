//
//  CatDetailModel.swift
//  CatListing
//
//  Created by LUIS FELIPE B PEREIRA on 04/02/25.
//

import Foundation
import SwiftUI

struct Cat: Identifiable {
    let id = UUID()
    let name: String?
    let temperament: String?
    let imageURL: String?
    let weight: String?
    let origin: String?
    let wikiURL: String?
}
