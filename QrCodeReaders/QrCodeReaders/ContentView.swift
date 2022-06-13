//
//  ContentView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    ///realm対用させる　じゃないと卒業できない
    
    var body: some View {
        NavigationView{
            VStack {
                //ここでどこに移動するか決める
                Text("QR Code Readers")
                    .font(.title)
                
                Image("smartphone_qr_code_man")
                    .resizable()
                        .scaledToFit()      // 縦横比を維持しながらフレームに収める
                        .frame(width: 300, height: 150)
//
//                    .padding()
                
                // 読み取ったQRコード表示位置
                //                Text("URL = [ " + viewModel.lastQrCode + " ]")
                
                
                Button(action: {
                    viewModel.isShowing = true
                }){
                    
                    Image("オレンジButtonのカメラ起動")
                    
                    
                    
                }
//                Button("リストのテスト"){
//
//                    self.viewModel.onFoundQrCode("https://news.yahoo.co.jp/")
//
//                }
//                Button("リストのテスト2"){
//
//                    self.viewModel.onFoundQrCode("https://www.google.com/?hl=ja")
//
//                }
                //ここでどこに移動するか決める
                NavigationLink(
                    destination: ListContentView(dataList: $viewModel.viewModel)){
                    Image("黄緑Buttonのリスト")
                }//ページのタイトル
                //                .navigationTitle("最初のページ")
                .fullScreenCover(isPresented: $viewModel.isShowing) {
                    
                    
                    NextView(viewModel: viewModel)
                    
                    
                }
                
                NavigationLink(destination: ReadmeView()) {
                    
                    Image("水色Buttonの使い方")
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
