//
//  UserDetailView.swift
//  Network_Image
//
//  Created by hangeonhui on 2023/01/10.
//

import Foundation
import SwiftUI

struct UserDetailView: View {
    
    var user: User
    
    var body: some View {
        VStack(){
            URLImage(urlString: user.avater)
                .frame(width: UIScreen.main.bounds.size.width, height: 250)
            //가로 화면에 꽉 채우기
            Text(user.name)
                .font(.largeTitle)
            Text(user.createdAt)
            Spacer()
        }
    }
}
