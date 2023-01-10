//
//  ContentView.swift
//  Network_Image
//
//  Created by hangeonhui on 2023/01/09.
//

import SwiftUI



//https://jsonplaceholder.typicode.com json 데이터 받는 사이트
struct ContentView: View {
    
    @State var todos = [Todo]()
    
    var body: some View {
        
        List(todos){ todo in
            VStack(alignment: .leading){
                Text(todo.title!)
                Text(todo.completed!.description)
                    .foregroundColor( todo.completed == true ? .red : .blue)
            }
            
        }
        .onAppear{
            WebService().getTodos{ todos in
                self.todos = todos
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
