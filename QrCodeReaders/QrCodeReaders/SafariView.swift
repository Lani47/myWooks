//
//  SafariView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import SwiftUI
import SafariServices


struct SafariView: UIViewControllerRepresentable {//view関連の関数は自動生成してほしい...
    var url: URL
    
    
    //Viewが更新した時
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        //あるだけでいいから。
    }
    //VIEWが起動した時
    func makeUIViewController(context: Context) -> SFSafariViewController {
        print("SafariView:\(url)")
        //URLをしまってサファリを起動
        return SFSafariViewController(url: url)
    }
    
   
}
