//
//  webService.swift
//  Network_Image
//
//  Created by hangeonhui on 2023/01/10.
//

import Foundation

struct Todo: Codable , Identifiable {
    
    var userId: Int?
    var id : Int?
    var title: String?
    var completed: Bool?
}

//https://jsonplaceholder.typicode.com/todos
class WebService {
    
    //쿨로져 형태가 일반적
    func getTodos(completion: @escaping ([Todo]) -> Void){
        guard let url = URL(string : "https://jsonplaceholder.typicode.com/todos") else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let hasData = data else {
                return
            }
            
            do{
                let todos = try JSONDecoder().decode([Todo].self, from: hasData)
                completion(todos)
            }catch{
                print(err ?? "0")
            }
            
        }.resume()
    }
}
