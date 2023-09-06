//
//  ItemRow.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct ItemRow: View {
    @Environment(\.modelContext) private var context
    @State var item: Item
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.ItemName)
                Text("\(item.ExpireDate, format: Date.FormatStyle(date: .numeric))")
                    .font(.subheadline)
            }
            Spacer()
           // Text("\(item.ExpireDate, format: Date.FormatStyle(date: .numeric))")
        }
    }
}
