//
//  ContentView.swift
//  GridViewGallery
//
//  Created by hangeonhui on 2023/01/07.
//

import SwiftUI

enum GridType: CaseIterable {
    case single
    case double
    case triple
    case adaptive
    
    //타입에 맞게 의존성부여
    var colums: [GridItem] {
        switch self {
        case .single:
            return [GridItem(.flexible())]
        case .double:
            return [GridItem(.flexible()),
                    GridItem(.flexible())]
        case .triple :
            return [GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())]
        case .adaptive :
            return [GridItem(.adaptive(minimum: 50))]
        }
    }
}

struct ContentView: View {
    
    @State private var selectedGridType:GridType = .single
    
    var items = Item.dumyData
    
    var body: some View {
        
        VStack{
            GridTypePicker(gridType: $selectedGridType)
            ScrollView{
                LazyVGrid(columns: selectedGridType.colums , content: {
                    ForEach(items) { item in
                        
                        //single 일때 layout 다르게
                        switch selectedGridType {
                        case .single:
                            SingleRew(item: item)
                        default:
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fit)
                        }
                    }
                })
                .animation(Animation.default, value: true)
            }
        }
    }
}

//picker
struct GridTypePicker: View {
    
    @Binding var gridType: GridType
    
    var body: some View {
        
        Picker("Grid Type", selection: $gridType) {
            ForEach(GridType.allCases, id: \.self){ type in
                switch type{
                case.single:
                    Image(systemName: "rectangle.grid.1x2")
                case.double:
                    Image(systemName: "square.grid.2x2")
                case.triple:
                    Image(systemName: "square.grid.3x2")
                case.adaptive:
                    Image(systemName: "square.grid.4x3.fill")
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
