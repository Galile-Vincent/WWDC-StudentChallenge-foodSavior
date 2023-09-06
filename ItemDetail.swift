//
//  ItemDetail.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct ItemDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss)var dismiss
    @Environment(\.modelContext) private var context
    @State var item:Item
    var body: some View{
        NavigationStack{
            VStack(alignment: .leading){
                Text("Expire Date: \(item.ExpireDate, format: Date.FormatStyle(date: .numeric))")
                    .bold()
                Text(item.ItemDetail)
            }
        }.navigationTitle(item.ItemName)
            .navigationBarTitleDisplayMode(.large)
    }
}
