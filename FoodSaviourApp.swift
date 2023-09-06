//
//  FoodSaviourApp.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

@main
struct FoodSaviourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    RoomData.self,
                    Item.self,
                    ShopData.self,
                    RecipeData.self
                ])
        }
    }
}
