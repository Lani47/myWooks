//
//  ListContentView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import SwiftUI


var daihyaku = "https://dic.nicovideo.jp/a/%E3%83%88%E3%83%AB%E3%82%AB%E3%83%BC%E3%82%BF%E3%83%BC%E3%82%BF%E3%83%83%E3%82%BD"

struct ListContentView: View {
    
    
    //StructのURLをStringに変えとく　大規模改修にならなければいいけど...
    //ただのSwiftファイルの中とデータを参照できる？
    @Binding var dataList: [qrInformation]
    
    
    @State var textElia = false
    
    @State var showSafari = false
    
    @State var inputText = ""
    
    @State var renameText = false
    
    @State var messages: [qrInformation] = []
    //Stateを作ってListをタップで正しくロードさせた。　10/28
    @State var link: URL = URL(string: "https://jec.ac.jp")!
    
    
    var body: some View {
        VStack{
            
            
            
            List(dataList){okashi in
                //ここで取り込んだお菓子のデータを全て取り出す？
                Button(action: {
                    showSafari.toggle()
//                    print(dataList.count)
                    print("Content:\(okashi.link)")
                    link = okashi.link
                    
                    
                    
                }){
                    VStack {
                        Text(okashi.name)
                                                
                    }
                }
                
                .sheet(isPresented: self.$showSafari, content: {
                    
                    //ここで作ったviewを表示する
                    ///別のURLにならない
                    SafariView(url: link)
                    
                        //下をいっぱいにして指定
                        .edgesIgnoringSafeArea(.bottom)
                  
                })
            }
            //Listここまで
            Button(action: {
                dataList.removeAll()
            }, label: {
                Text("リスト削除")
            })
        }
    }
}

//struct ListContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListContentView()
//    }
//}

