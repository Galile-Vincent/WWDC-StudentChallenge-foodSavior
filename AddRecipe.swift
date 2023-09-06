//
//  AddRecipe.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/31.
//

import SwiftUI
import SwiftData

struct AddRecipe: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss)var dismiss
    @Environment(\.modelContext) private var context
    @State var dishname: String = ""
    @State var dishdetail: String = ""
    @State var ingredients: [String] = []
    @Query var recipes:[RecipeData]
    var body: some View{
        NavigationStack{
            List {
                Section {
                    TextField("Name", text: $dishname)
                }header: {
                    Text("Location Name")
                } footer: {
                    Text("The location can be anywhere you store the food, such as in the refrigerator or in the kitchen cabinets, or even in a box on the countertop.")
                }
                Section {
                    TextField("Detail", text: $dishdetail)
                }header: {
                    Text("Location Detail")
                }
                
                Section{
                    ForEach(recipes){recipe in
                        NavigationLink(destination: EmptyView()){
                            Text(recipe.DishName)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("New Location")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save") {
                        let recipe = RecipeData(DishName: dishname, DishDetail: dishdetail, ingresients: ingredients, lastedited: .now, loved: false)
                        context.insert(recipe)
                        try? context.save()
                        presentationMode.wrappedValue.dismiss()
                        dismiss()
                    }.disabled(dishname.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}
