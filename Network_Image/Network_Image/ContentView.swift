//
//  ContentView.swift
//  Network_Image
//
//  Created by hangeonhui on 2023/01/09.
//

import SwiftUI

//https://63bd3bdefa38d30d85dd5d27.mockapi.io/user
//https://jsonplaceholder.typicode.com json 데이터 받는 사이트

struct ContentView: View {
    
//    @State var todos = [Todo]()
//
//    var body: some View {
//
//        List(todos){ todo in
//            VStack(alignment: .leading){
//                Text(todo.title!)
//                Text(todo.completed!.description)
//                    .foregroundColor( todo.completed == true ? .red : .blue)
//            }
//
//        }
//        .onAppear{
//            WebService().getTodos{ todos in
//                self.todos = todos
//            }
//        }
//    }
    
    @State var users = [User]()
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible())],content: {
                    ForEach(users) { user in
                        
                        NavigationLink(destination: {
                            UserDetailView(user: user)
                        }, label: {
                            HStack{
                                URLImage(urlString: user.avater)
                                    .frame(width: 100, height: 100)
                                Text("\(user.name)")
                                Spacer()
                                
                            }
                        })
                    }
                })
            }
            .navigationBarTitle("User List")
        }
        .onAppear{
            Api().loadUsers{ (users) in
                self.users = users
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
