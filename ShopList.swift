//
//  ShopList.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct ShoppingList: View {
    @Environment(\.modelContext) private var context
    @State private var newItemName = ""
    @State private var newItemQuantity = ""
    @State private var isPresentingAlert = false
    @State private var selectedFoodName = ""
    @State private var isAddingNewFood = false
    @State private var completed = false
    @Query var shoppingList: [ShopData]
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("name", text: $newItemName)
                    TextField("quantity", text: $newItemQuantity)
                        .keyboardType(.numberPad)
                    Button(action: {
                        addtoList()
                    }) {
                        Text("Add")
                    }
                    .disabled(newItemName.isEmpty || newItemQuantity.isEmpty)
                }
            }
            
            Section {
                ForEach(shoppingList) { item in
                    HStack {
                        Button(action: { completed = true }) {
                            Image(systemName: completed ? "checkmark.square.fill" : "square")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .strikethrough(completed)
                            Text("Quantity: \(item.quantity)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if item.completed {
                            Button(action: {
                                selectedFoodName = item.name
                                isAddingNewFood = true
                            }) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .onDelete{ item in
                    for index in item{
                        deleteItem(shoppingList[index])
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Shopping List")
        .sheet(isPresented: $isAddingNewFood, onDismiss: {
            newItemName = ""
            newItemQuantity = ""
            selectedFoodName = ""
        }, content: {
            NewItem()
        })
        
    }
    func addtoList() {
        let item = ShopData(name: newItemName, quantity: newItemQuantity, completed: false)
        context.insert(item)
        try? context.save()
        newItemName = ""
        newItemQuantity = ""
        completed = false
    }
    func deleteItem(_ item: ShopData){
        context.delete(item)
    }
}
