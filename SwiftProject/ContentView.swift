//
//  ContentView.swift
//  SwiftProject
//
//  Created by 陈扬 on 2021/7/5.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctNumber = Int.random(in: 0...2)
    @State var grade = 0
    @State var messageShow = false
    @State var messageTitle = ""
    
    func handleClick(_ number: Int) {
        if number == correctNumber {
            messageTitle = "答对了"
            grade += 3
        } else {
            messageTitle = "答错了"
            grade -= 1
        }
        if (grade < 0) {
            grade = 0
        }
        messageShow = true
    }
    func handleClosed() {
        countries = countries.shuffled()
        correctNumber = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("点击")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(countries[correctNumber])
                        .foregroundColor(.white)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        handleClick(number)
                    }) {
                        Image(countries[number]).renderingMode(.original)
                    }
                }
                Spacer()
                Text("分数：\(grade)")
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $messageShow) {
            Alert(title: Text(messageTitle), message: Text("当前分数：\(grade)"), dismissButton: .default(Text("确定")) {
                handleClosed()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
