//
//  NewRoom.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/12.
//

import SwiftUI
import SwiftData

struct NewRoom: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss)var dismiss
    @Environment(\.modelContext) private var context
    @State var roomName: String = ""
    @State var roomDetail: String = ""
    @Query var item:[Item]
    @Query var room:[RoomData]
    var body: some View{
        NavigationStack{
            List {
                Section {
                    TextField("Name", text: $roomName)
                }header: {
                    Text("Location Name")
                } footer: {
                    Text("The location can be anywhere you store the food, such as in the refrigerator or in the kitchen cabinets, or even in a box on the countertop.")
                }
                Section {
                    TextField("Detail", text: $roomDetail)
                }header: {
                    Text("Location Detail")
                }
                
                Section{
                    ForEach(room){rooms in
                        NavigationLink(destination: LocationDetail(room: rooms)){
                            Text(rooms.RoomName)
                        }
                    }
                }header: {
                    if room.isEmpty{
                        Text("No Exist Location")
                    }else{
                        Text("Exist Location")
                    }
                }footer: {
                    if room.isEmpty == false{
                        Text("Room account: \(room.count)")
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
                        let room = RoomData(RoomName: roomName, RoomDetail: roomDetail)
                        context.insert(room)
                        try? context.save()
                        presentationMode.wrappedValue.dismiss()
                        dismiss()
                    }.disabled(roomName.isEmpty)
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

#Preview {
    NewRoom()
}

