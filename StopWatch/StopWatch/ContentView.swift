//
//  ContentView.swift
//  StopWatch
//
//  Created by hangeonhui on 2023/01/14.
//

import SwiftUI

struct ContentView: View {
    
    @State private var time: Double = 0
    
    var ReadbleTime: String {
        let sec = Int(time) % 60
        let min = Int(time) / 60
        
        //소수를 나눌때 truncating 사용해야 한다
        let milsec = time.truncatingRemainder(dividingBy: 1)
        let milString = String(format: "%.1f" , milsec).split(separator: ".").last ?? "0"
        
        return "\(String(format: "%02d", min)) " + ":" + " \(String(format: "%02d", sec)) " + ":" + " \(milString)"
    }
    
    var timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect() //autoconnect 사용하는 객체가 없어지면 사라지게
    
    @State private var isStart = false
    var body: some View {
        
        VStack{
            ZStack{
                ClockTick()
                ClockNumber()
                SecondHand(sec: time)
                MinuteHand(sec: time)
                CenterCircle()
                
                MilliClockTick()
                    .offset(y: 65)
                MilliSecondHand(sec: time)
                    .offset(y: 65)
            }
            .padding(.bottom, 150)
            
            StartStopButton(isStart: $isStart, time: $time)
            
            Text(ReadbleTime)
                .font(.largeTitle)
        }
        
        .onReceive(timer, perform: { _ in
            //ui 부드럽게 바꾸게
            withAnimation{
                if isStart{
                    self.time += 0.1
                }
            }
        })
        
    }
}


struct StartStopButton: View {
    
    @Binding var isStart: Bool
    @Binding var time : Double
    
    var body: some View{
        VStack(spacing: 0){
            HStack(spacing:0){
                //글자 이상의 네모 부분의 버튼 설정
                Button(action: {
                    isStart = true
                }, label: {
                    Text("START")
                        .frame(width: UIScreen.main.bounds.size.width / 2, height: 50)
                        .background(isStart ? Color.orange.opacity(0.5) : Color.orange)
                })
                Button(action: {
                    isStart = false
                }, label: {
                    Text("PAUSE")
                        .frame(width: UIScreen.main.bounds.size.width / 2, height: 50)
                        .background(isStart ? Color.orange : Color.orange.opacity(0.5))
                })
            }
            Button(action: {
                isStart = false
                time = 0
            }, label:{
                Text("STOP")
                    .frame(width: UIScreen.main.bounds.size.width , height: 50)
                    .background(Color.red.opacity(0.5))
            })
        }
    }
}

struct CenterCircle: View{
    
    var body: some View{
        Circle()
            .fill(Color.black)
            .frame(width: 10, height: 10)
    }
}

struct ClockTick: View {
    var tickCount = 60
    
    var body: some View {
        
        ZStack{
            ForEach(0..<tickCount) { tick in
                //원 초침 만들기
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 1, height: tick % 5 == 0 ? 20 : 10 )
                    .offset(y: 130)     //기준점 옮기기
                    .rotationEffect(.degrees(Double(tick) / Double(tickCount) * 360))
            }
        }
    }
}

struct MilliClockTick: View {
    var tickCount = 10
    
    var body: some View {
        
        ZStack{
            ForEach(0..<tickCount) { tick in
                //원 초침 만들기
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 1, height: 10 )
                    .offset(y: 40)     //기준점 옮기기
                    .rotationEffect(.degrees(Double(tick) / Double(tickCount) * 360))
            }
        }
    }
}

struct ClockNumber: View {
    var tickCount = 60
    
    var body: some View {
        ZStack{
            ForEach(0..<tickCount){tick in
                if tick % 5 == 0{
                    
                    //숫자 정방향으로 바꿀려면 zstack으로 감싸서 반대로 회전
                    Text("\(tick)")
                        .offset(y: -155)
                        .rotationEffect(.degrees(Double(tick) / Double(tickCount) * 360))
                    
                }
            }
        }
    }
}

struct SecondHand: View {
    
    var sec: Double
    
    private var height: CGFloat = 80
    
    //private 사용할려면 생성자 만들어야한다
    init(sec: Double) {
        self.sec = sec
    }
    
    var body: some View{
        Rectangle()
            .fill(Color.gray)
            .frame(width: 3, height: height)
            .offset(y: -height / 2)
            .rotationEffect(.degrees( sec / 60 * 360))
    }
}

struct MinuteHand: View {
    
    var sec: Double
    
    private var height: CGFloat = 50
    
    //private 사용할려면 생성자 만들어야한다
    init(sec: Double) {
        self.sec = sec
    }
    
    var body: some View{
        Rectangle()
            .fill(Color.black)
            .frame(width: 3, height: height)
            .offset(y: -height / 2)
            .rotationEffect(.degrees( sec / 60 / 60 * 360))
    }
}

struct MilliSecondHand: View {
    
    var sec: Double
    
    private var height: CGFloat = 25
    
    //private 사용할려면 생성자 만들어야한다
    init(sec: Double) {
        self.sec = sec
    }
    
    var body: some View{
        Rectangle()
            .fill(Color.gray)
            .frame(width: 3, height: height)
            .offset(y: -height / 2)
            .rotationEffect(.degrees( sec / 60 * 60 * 360))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
