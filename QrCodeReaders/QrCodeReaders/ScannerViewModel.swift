//
//  ScannerViewModel.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import Foundation
import UIKit


//お菓子の情報をIdentifiableでまとめる構造体の一種
struct qrInformation: Identifiable {
    //idを生成 お菓子を区別するため？に番号を
    var id = UUID()
    var name: String
    var link: URL
//    init(name:String,link:URL) {
//        self.name = name
//        self.link = link
//    }
}

//


class ScannerViewModel: ObservableObject {
       
    
    
    //お菓子のリスト Identifiableプロトコル プロパティを監視して自動通知

    @Published var viewModel: [qrInformation] = []
 
    /// QRコードを読み取る時間間隔
    let scanInterval: Double = 1.0
    @Published var lastQrCode: String = "QRコード"
    @Published var isShowing: Bool = false
    
    

    /// QRコード読み取り時に実行される。
    func onFoundQrCode(_ code: String) {
        //時刻を取得
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        let second = Calendar.current.component(.second, from: Date())
        
        //URLを取得
        self.lastQrCode = code
        //URLをStringに変換
        guard let url = URL(string: lastQrCode) else { return print("QR変換失敗") }
        
        //時刻を組み立てる
        let calc = "\(hour)時\(minute)分\(second)秒"
        //データを一個にまとめて作る
        let roundUp = qrInformation(name: calc, link: url)
//        userDefaults?

        //ここでokashiListに追加したはず...
        self.viewModel.append(roundUp)
        
        print(viewModel)

        isShowing = false
        
    }
    
    
}
