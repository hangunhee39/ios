//
//  ContentView.swift
//  Calculator
//
//  Created by hangeonhui on 2023/01/16.
//

import SwiftUI

struct CalcButton: View{
    
    var buttonName = ""
    
    var body: some View{
        Circle()
            .foregroundColor(.orange)
            .overlay(   //zstack 대신
            Text(buttonName)
                .font(.largeTitle)
            )
    }
}

struct ContentView: View {
    
    @State private var geoCircleHeight: CGFloat = 50
    
    @State private var display: String = "0"
    
    @State private var isInTheTypingOfDigit = false
    
    var core = CalcLogin()
    
    let data = [
        ["AC", "+-", "%", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    var body: some View {
        VStack{
            Spacer(minLength: 50)
            
            Text(display)
                .font(.largeTitle)
                .padding(.trailing, 10)
                .frame(width: UIScreen.main.bounds.size.width , alignment: .trailing)
            
            ForEach(0..<4){ i in
                HStack(spacing: 10){
                    ForEach(0..<4){ j in
                        
                        Button(action: {
                            calcAction(symbol: data[i][j])
                        }, label: {
                            CalcButton(buttonName: data[i][j])
                                .aspectRatio(1, contentMode: .fit)
                        })
                    }
                }
                .padding(.horizontal, 10)
            }
            //마지막 줄
            HStack(spacing: 10){
                //높이를 가지고 넓이 비율 맞추기
                GeometryReader { geometry in
                    
                    Capsule()
                        .foregroundColor(.orange)
                        .aspectRatio(CGSize(width: geometry.size.height * 2 + 10, height: geometry.size.height), contentMode: .fit)
                        .overlay{
                            Text(data[4][0])
                                .font(.largeTitle)
                        }
                        .onAppear{
                            self.geoCircleHeight = geometry.size.height
                        }
                        .onTapGesture(count: 1, perform: {
                            calcAction(symbol: data[4][0])
                        })
                    
                }
                
                CalcButton(buttonName: data[4][1])
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture(count: 1, perform: {
                        calcAction(symbol: data[4][1])
                    })
                CalcButton(buttonName: data[4][2])
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture(count: 1, perform: {
                        calcAction(symbol: data[4][2])
                    })
                    
            }
            .aspectRatio(CGSize(width: geoCircleHeight * 4 + 30 , height: geoCircleHeight), contentMode: .fit)
            .padding(.horizontal, 10)
        }
        .padding(.bottom, 10)
    }
    
    //계산로직
    func calcAction(symbol: String){
        
        if Int(symbol) != nil || symbol == "." {
            
            if isInTheTypingOfDigit {
                display = display + symbol
            } else {
                
                isInTheTypingOfDigit = true
                display = symbol
            }
            if core.rememverSymbol == nil{
                core.digit1 = Double(display)
            }else{
                core.digit2 = Double(display)
            }
        }else {
            if symbol != "=" {
                core.rememverSymbol = symbol
            }
            isInTheTypingOfDigit = false
            
            if symbol == "AC" {
                core.digit1 = nil
                core.digit2 = nil
                core.calculatResult = nil
                core.rememverSymbol = nil
                display = "0"
            }
            if symbol == "%" {
                display = "\(String(describing: core.logic()!))"
                core.digit1 = Double(display)
            }
            
            if symbol == "=" {
                display = "\(String(describing: core.logic()!))"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
