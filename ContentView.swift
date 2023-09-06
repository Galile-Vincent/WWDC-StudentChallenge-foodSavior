//
//  ContentView.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query var item: [Item]
    @Query var rooms: [RoomData]
    @Query var shops: [ShopData]
    @State var newitems: Bool = false
    @State var newrooms: Bool = false
    @State var shoplist: Bool = false
    @State private var search = ""
    
    var filteredItems: [Item] {
        if search.isEmpty {
            return item
        } else {
            return item.filter { $0.ItemName.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var filteredRooms: [RoomData] {
        if search.isEmpty {
            return rooms
        } else {
            return rooms.filter { $0.RoomName.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var filteredShop: [ShopData] {
        if search.isEmpty {
            return shops
        } else {
            return shops.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                
                if !filteredRooms.isEmpty{
                    Section {
                        ForEach(filteredRooms) { room in
                            NavigationLink(destination: LocationDetail(room: room)) {
                                LocationRow(room: room)
                            }
                        }.onDelete { room in
                            for index in room {
                                deleteRoom(rooms[index])
                            }
                        }
                    }header: {
                        Text("Location")
                    }
                }
                
                if !search.isEmpty && !filteredItems.isEmpty{
                    Section {
                        ForEach(filteredItems) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }.onDelete { items in
                            for index in items {
                                deleteItem(item[index])
                            }
                        }
                    }header: {
                        Text("Item")
                    }
                }
                
                if !search.isEmpty && !filteredShop.isEmpty{
                    Section {
                        ForEach(filteredShop) { shop in
                            NavigationLink(destination: ShoppingList()) {
                                HStack{
                                    Text(shop.name)
                                    Spacer()
                                    Text(shop.quantity)
                                }
                            }
                        }.onDelete { shop in
                            for index in shop {
                                deleteShop(shops[index])
                            }
                        }
                    }header: {
                        Text("ShopList")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    
                    NavigationLink(destination: ShoppingList()){
                        Text("ShopList")
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink(destination: AllItem()){
                        Text("All Item")
                    }
                }
                
                ToolbarItem(placement: .bottomBar){
                    Button(action: {
                        self.newitems = true
                    }){
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("New Item")
                        }
                    }
                    .sheet(isPresented: self.$newitems){
                        NewItem()
                    }
                }
                
                ToolbarItem(placement: .bottomBar){
                    Button(action: {
                        self.newrooms = true
                    }){
                        HStack{
                            Text("New Location")
                        }
                    }.sheet(isPresented: self.$newrooms){
                        NewRoom()
                    }
                }
            }
            .searchable(text: $search,placement: .navigationBarDrawer(displayMode: .automatic) ,prompt: "Search")
            .overlay{
                if filteredItems.isEmpty && filteredRooms.isEmpty && search.isEmpty{
                    ContentUnavailableView {
                        Label("Empty", systemImage: "archivebox")
                    } description: {
                        Text("Add location by clicking the button below")
                    }
                }
                else if filteredItems.isEmpty && filteredRooms.isEmpty && !search.isEmpty{
                    ContentUnavailableView.search(text: search)
                }
            }
        }
    }
    func deleteRoom(_ room: RoomData){
        if let items = room.items {
            for item in items {
                deleteItem(item) // Delete the associated items first
            }
        }
        context.delete(room) // Then delete the room
    }

    func deleteItem(_ item: Item){
        context.delete(item)
    }
    
    func deleteShop(_ shop: ShopData){
        context.delete(shop)
    }
}



