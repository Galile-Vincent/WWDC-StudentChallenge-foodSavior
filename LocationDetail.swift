//
//  LocationDetail.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct LocationDetail: View {
    @Environment(\.modelContext) private var context
    @State var room: RoomData
    @State var additem: Bool = false
    @State private var search = ""
    @Query private var items: [Item] // Rename the variable to "items" to match the relationship name
    // Filter items based on their association with the selected room
    var filteritem: [Item] {
        if search.isEmpty {
            return items.filter { item in
                item.room == room // Only include items where the "room" property matches the selected room
            }
        } else {
            return items.filter { item in
                item.room == room && item.ItemName.localizedCaseInsensitiveContains(search) // Filter by both room and search text
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteritem) { item in
                    NavigationLink(destination: ItemDetail(item: item)){
                        ItemRow(item: item)
                    }
                }
            }
            .navigationTitle(room.RoomName)
            .navigationBarTitleDisplayMode(.automatic)
            .searchable(text: $search, prompt: "Search Item")
        }
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    self.additem = true
                }){
                    HStack{
                        Text("Add Item")
                            .bold()
                    }
                }
                .sheet(isPresented: self.$additem){
                    NewItem(selectedRoom: room)
                }
            }
        }
        
        
        .overlay{
            if room.itemCount == 0{
                ContentUnavailableView {
                    Label("The Location is Empty", systemImage: "doc.richtext.fill")
                } description: {
                    Text("Try to search for another title.")
                }
            }
            if filteritem.isEmpty && room.itemCount != 0{
                ContentUnavailableView.search(text: search)
            }
        }
    }
}
