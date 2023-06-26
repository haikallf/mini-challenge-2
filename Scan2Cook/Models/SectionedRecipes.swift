//
//  SectionedRecipes.swift
//  Scan2Cook
//
//  Created by Haikal Lazuardi on 26/06/23.
//

import SwiftUI

struct SectionedRecipes: Equatable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let recipes: [Recipe]
}

extension SectionedRecipes {
    static let all = [
        SectionedRecipes(id: "1", name: "Resep Hari Ini", description: nil, recipes: Recipe.all),
        SectionedRecipes(id: "2", name: "Resep Terbaru", description: nil, recipes: Recipe.all),
    ]
}
