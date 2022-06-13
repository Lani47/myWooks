//
//  ReadmeView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import SwiftUI

struct ReadmeView: View {
    @State var flag = true
    
    var body: some View {
        VStack{
            Text("使い方")
            if(flag){
                Image("Redeme1")
                    .resizable()
                        .scaledToFit()      // 縦横比を維持しながらフレームに収める
    //                    .frame(width: 800, height: 400)
            } else {
                Image("Redeme2")
                    .resizable()
                        .scaledToFit()      // 縦横比を維持しながらフレームに収める
    //                    .frame(width: 800, height: 400)
                
            }
            
            Button(action: {
                flag.toggle()
            }, label: {
                
                    
            Image("水色Buttonの次へ")
                
            })
            
        
    }
}

struct ReadmeView_Previews: PreviewProvider {
    static var previews: some View {
        ReadmeView()
    }
}

}
