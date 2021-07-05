//
//  ContentView.swift
//  SwiftProject
//
//  Created by 陈扬 on 2021/7/5.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctNumber = Int.random(in: 0...2)
    @State private var messageShow: Bool = false
    @State private var messageTitle: String = ""
    @State private var grade: Int = 0
    
    func handleTagClick(_ number: Int) {
        if number == correctNumber {
            messageTitle = "答对了！"
            grade += 3
        } else {
            messageTitle = "答错了！"
            grade -= 1
        }
        if (grade < 0) {
            grade = 0
        }
        messageShow = true
    }
    func handleCancelMessage() {
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
                        .foregroundColor(.white).font(.largeTitle)
                        .fontWeight(.black)
                    Text(countries[correctNumber])
                        .foregroundColor(.white)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.handleTagClick(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                    }
                }
                Spacer()
                Text("当前分数：\(grade)").foregroundColor(.white)
            }
        }
        .alert(isPresented: $messageShow) {
            Alert(title: Text(messageTitle), message: Text("当前分数\(grade)"), dismissButton: .default(Text("继续")) {
                self.handleCancelMessage()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
