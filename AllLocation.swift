//
//  AllLocation.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/28.
//

import SwiftUI
import SwiftData

struct AllLocation: View {
    @Environment(\.modelContext) private var context
    @State var roomName: String = ""
    @State var roomDetail: String = ""
    @Query var item:[Item]
    @Query var room:[RoomData]
    var body: some View{
        NavigationStack{
            List{
                ForEach(room){ rooms in
                    NavigationLink(destination: LocationDetail(room: rooms)){
                        HStack{
                            Text(rooms.RoomName)
                        }
                    }
                }
            }
        }
    }
}
