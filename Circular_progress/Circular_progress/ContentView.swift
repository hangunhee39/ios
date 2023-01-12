//
//  ContentView.swift
//  Circular_progress
//
//  Created by hangeonhui on 2023/01/12.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack{
            Slider(value: $progress)
            
            CirularProgressBar(progress: $progress)
        }
    }
}

struct CirularProgressBar : View {
    
    @Binding var progress: CGFloat
    
    var body: some View {
        
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .fill(progress == 1 ? Color.green :Color.red)
                .rotationEffect(.degrees(-90)) //시작점 옮기기
                .animation(.easeInOut) //부드럽게 애니메이션
            
            Text("\(String(format: "%.1f", (progress * 100))) %")
                .font(.largeTitle)
                .foregroundColor(progress == 1 ? Color.green : Color.red)
            
        }
        .padding(30)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
