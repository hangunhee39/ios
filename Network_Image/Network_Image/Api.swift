//
//  Api.swift
//  Network_Image
//
//  Created by hangeonhui on 2023/01/10.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    var id : String
    var name : String
    var avater : String
    var createdAt: String
}

//User Api 받기
class Api {
    func loadUsers(completion: @escaping ([User]) ->Void){
        
        guard let url = URL(string: "https://63bd3bdefa38d30d85dd5d27.mockapi.io/user") else{
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, response, Err) in
            
            guard let hasData = data else{
                return
            }
            do{
                let users = try JSONDecoder().decode([User].self, from: hasData )
                completion(users)
            }catch{
                print(Err ?? "err")
            }
            
        }.resume()
    }
}

//Url 에서 이미지 불러오기
class ImageLoader: ObservableObject {
    @Published var image : UIImage?
    
    var urlString : String
    
    init(urlString: String){
        self.urlString = urlString
        self.loadImageFromURL()
    }
    
    
    func loadImageFromURL(){
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let hasData = data else {
                return
            }
            
            guard let loadedImage = UIImage(data: hasData) else {
                return
            }
        
            //ui 바꾸는 것은 main Thread 에서 해야한다
            DispatchQueue.main.async {
                self.image = loadedImage
            }
            
        }.resume()
    }
}

//Url 이미지
struct URLImage: View {
    @ObservedObject var loader: ImageLoader
    
    init(urlString: String){
        self.loader = ImageLoader(urlString: urlString)
    }
    
    var body :some View{
        Image(uiImage: loader.image ?? UIImage(named: "placeholderImage")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
