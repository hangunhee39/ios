//
//  item.swift
//  GridViewGallery
//
//  Created by hangeonhui on 2023/01/07.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    let mainTitle: String
    let subTitle: String
    let imageName: String
    
    //메모라애 따로 만드는 더미
    static var dumyData: [Item]{
        (0...30).map{ index in
            Item( mainTitle: "Main Title Index\(index)",
                 subTitle: "sub title\(index)",
                 imageName: "freeBG\(index % 2 + 1)")
            
        }
    }
}
