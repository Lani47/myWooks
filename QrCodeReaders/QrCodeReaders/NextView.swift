//
//  NextView.swift
//  QrCodeReaders
//
//  Created by cmStudent on 2021/10/28.
//

import Foundation
import SwiftUI



struct NextView: View {
    @ObservedObject var viewModel : ScannerViewModel
    
    
    

    var body: some View {
        Text("NextView")

        ZStack {
            // QRコード読み取りView
            QrCodeScannerView()
                .found(r: self.viewModel.onFoundQrCode)
                .interval(delay: self.viewModel.scanInterval)

            VStack {
                VStack {
                    Text("QRコードをかざしてください。")
                        .font(.subheadline)

                    Text("前回のQRコード読み取り結果 = [ " + self.viewModel.lastQrCode + " ]")
                        .bold()
                        .lineLimit(5)
                        .padding()
                    //QRコードをリストに入れたい

                    Button("閉じる") {
                        self.viewModel.isShowing = false
                    }
                    
                }
                .padding(.vertical, 20)
                Spacer()
            }.padding()
        }
    }
}

//struct NextView_Previews: PreviewProvider {
//    static var previews: some View {
//        NextView(viewModel: )
//    }
//}

