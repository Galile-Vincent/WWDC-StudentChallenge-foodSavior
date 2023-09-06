//
//  NewItem.swift
//  FoodSaviour
//
//  Created by Vincent Chiang on 2023/7/12.
//

import SwiftUI
import SwiftData

struct NewItem: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss)var dismiss
    @Environment(\.modelContext) private var context
    @State var itemName: String = ""
    @State var itemDetail: String = ""
    @State var selectedRoom: RoomData?
    @State var ExpiredDate: Date = .now
    @Query var item:[Item]
    @Query var rooms:[RoomData]
    var body: some View{
        NavigationStack{
            List {
                Section {
                    TextField("Food Name", text: $itemName)
                    TextField("Food Detail", text: $itemDetail)
                } header :{
                    Text("Details")
                }
                
                //price
                
                
                
                //quantity
                
                Section {
                        Picker("Location", selection: $selectedRoom) {
                            ForEach(rooms) {room in
                                Text(room.RoomName)
                                    .tag(room as RoomData?)
                            }
                        }
                } header: {
                    Text("Location")
                }
                
                Section {
                    DatePicker("", selection: $ExpiredDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header: {
                    Text("Expiration Date")
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save") {
                        SaveItem()
                        presentationMode.wrappedValue.dismiss()
                        dismiss()
                    }.disabled(itemName.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
    func SaveItem(){
        let item = Item(ItemName: itemName, ItemDetail: itemDetail, buydate: .now, ExpireDate: ExpiredDate, isComplete: false)
        context.insert(item)
        item.room = selectedRoom
        selectedRoom?.items?.append(item)
        try? context.save()
    }
}

#Preview {
    NewItem()
}

