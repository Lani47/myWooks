//
//  ContentView.swift
//  High_and_Low0147
//
//  Created by cmStudent on 2021/11/08.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    @State var choice = false
    
    var body: some View {
        
        ZStack {
            
            Image("kusa")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                if viewModel.winCount == 0 {
                    Text("High_and_Low0147")
                        .font(.largeTitle)
                } else {
                    Text("\(viewModel.winCount)連勝")
                        .font(.largeTitle)
                }
                
                
                Button(action: {
                    viewModel.reset()
                }) {
                    Text("リセット")
                }
                
                HStack{
                    Image(viewModel.leftCard)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                    
                    
                    Image(viewModel.rightCard)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                    
                }
                
                
                ZStack{
                    if viewModel.message{
                        Image(viewModel.messageImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 60)
                    } else {
                        Spacer()
                                .frame(height: 60)
                    }
                
                }
                
                
                
                if !viewModel.isPlaying {
                    Button(action: {
                        viewModel.nextGame()
                        viewModel.setup()
                    }) {
                        Text(viewModel.messageTork)
                            .foregroundColor(Color.white)
                            .frame(width: 140, height: 60)
                            .background(Color("stopColor"))
                    }
                    
                } else {
                    HStack{
                        Button(action: {
                            viewModel.selected(selection: true)
                                
                            
                            
                        }) {
                            Text("High")
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 60)
                                .background(Color("stopColor"))
                        }
                        
                        Button(action: {
                            viewModel.selected(selection: false)
                            
                        }) {
                            Text("Low")
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 60)
                                .background(Color("stopColor"))
                        }
                    }
                }
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
