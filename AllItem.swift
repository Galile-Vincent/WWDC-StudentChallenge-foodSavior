//
//  AllItem.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/30.
//

import SwiftUI
import SwiftData

struct AllItem: View {
    @Environment(\.modelContext) private var context
    @State var roomName: String = ""
    @State var roomDetail: String = ""
    @Query var items:[Item]
    @Query var room:[RoomData]
    var body: some View{
        NavigationStack{
            List{
                ForEach(items){ item in
                    NavigationLink(destination: ItemDetail(item: item)){
                        ItemRow(item: item)
                    }
                }.onDelete { item in
                    for index in item {
                        deleteItem(items[index])
                    }
                }
            }
        }
    }
    func deleteItem(_ item: Item){
        context.delete(item)
    }
}
