//
//  LocationRow.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/25.
//

import SwiftUI
import SwiftData

struct LocationRow: View {
    @Environment(\.modelContext) private var context
    @State var room: RoomData
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(room.RoomName)
            }
            Spacer()
            Text("\(room.itemCount)")
        }
    }
}
