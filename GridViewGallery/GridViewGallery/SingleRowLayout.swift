//
//  SingleRowLayout.swift
//  GridViewGallery
//
//  Created by hangeonhui on 2023/01/09.
//

import Foundation
import SwiftUI

struct SingleRew: View{
    
    let item: Item
    
    var body: some View{
        ZStack{
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text(item.mainTitle)
                            .font(.headline)
                            .lineLimit(1)
                        Text(item.subTitle)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.white.opacity(0.5))
            }
        }
    }
}

struct SingleRew_Previews: PreviewProvider {
    static var previews: some View {
        SingleRew(item: Item(mainTitle: "main", subTitle: "sub", imageName: "freeBG1"))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: 200.0))
            
    }
}
