//
//  Recipe.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/31.
//

import SwiftUI
import SwiftData

struct Recipe: View {
    @Environment(\.modelContext) private var context
    @Query var recipes: [RecipeData]
    var body: some View {
        NavigationStack{
            ForEach(recipes){ recipe in
                Text(recipe.DishName)
            }
        }
    }
}
