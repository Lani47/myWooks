//
//  ContentViewModel.swift
//  High_and_Low0147
//
//  Created by cmStudent on 2021/11/08.
//

import Foundation

class ContentViewModel: ObservableObject {
    // 左側のカード画像
    // BKは背面
    @Published var leftCard = "BK"
    // 右側のカード画像
    @Published var rightCard = "BK"
    
    // お知らせ画像
    @Published var messageImage = "黄緑Buttonのリスト"
    
    @Published var messageTork = "はじめる！"
    
    
    // 連勝記録
    @Published var winCount = 0
//    //選択
//    @Published var selection: Bool = false
    
    
    let copipe: Int = 0
    
    // ゲーム開始フラグ
    var isPlaying = false
    //お知らせフラグ
    var message = false
    
    // 左側のカード番号
    private var leftCardNumber = 0
    // 右側のカード番号
    private var rightCardNumber = 0
    
    private let gameManager = GameManager()
    
    // スタートボタン押下時等、ゲーム開始時に使う
    func setup() {
        // 左側のカードをめくる
        
        
        if winCount == 0{
            // カードの画像と、カードの番号を作成する
            var oldLeftCard = gameManager.card()//カードの番号とカテゴリがあるはず
            // 左側のカードの画像を変更して表示する
            leftCard = oldLeftCard
            // 左側のカードの番号を保持しておく
            let removeLeft = oldLeftCard.index(oldLeftCard.startIndex, offsetBy: 0)
            
            oldLeftCard.remove(at: removeLeft)
            leftCardNumber = Int(oldLeftCard)!
        } 
        
        
        
        // 右側のカードはなにもしない（初期状態に戻す）
        rightCardNumber = 0
        rightCard = "BK"
        
//        messageImage = ""
        
        // ゲーム開始状態にする（Hight Lowボタン表示用）
        isPlaying = true
    }
    
    // カードを選択した時に呼ばれる。引数は適宜変更してOK
    func selected(selection: Bool) {
        // 右側のカードをめくる
        var oldRightCard = gameManager.card()
        // カードの画像と、カードの番号を作成する
        rightCard = oldRightCard
        // 左側のカードの画像を変更して表示する
        // 右側のカードの画像を変更して表示する
        
        // 右側のカードの大小を比較する
        let remobeRight = oldRightCard.index(oldRightCard.startIndex,offsetBy: 0)
        
        oldRightCard.remove(at: remobeRight)
        rightCardNumber = Int(oldRightCard)!
        
        
        
        
        // 下は取得の例。
//        gameManager.compare(left: leftCardNumber, right: rightCardNumber)
        
        switch  gameManager.compare(left: leftCardNumber, right: rightCardNumber) {
        case 1:
            print("leftの勝ち")
            if gameManager.isWin(selected: selection, isHigh: true){
                message = true
                messageImage = "水色Button-1"
                messageTork = "もう一度！"
                print("負け")
                winCount = 0
                
                isPlaying = false
            } else {
                message = true
                messageTork = "もう一度！"
                
                messageImage = "winlogotype"
                print("勝ち")
                winCount = winCount + 1
                isPlaying = false
            }
            
            break
        case 2:
            print("rightの勝ち")
            
            if gameManager.isWin(selected: selection, isHigh: false){
                message = true
                messageImage = "水色Button-1"
                messageTork = "もう一度！"
                print("負け")
                winCount = 0
                
                isPlaying = false
            } else {
                message = true
                messageImage = "winlogotype"
                messageTork = "もう一度！"
                print("勝ち")
                winCount = winCount + 1
                
                isPlaying = false
            }
            break
        default:
            message = true
            messageImage = "winlogotype"
            messageTork = "もう一度！"
            print("引き分け")
            winCount = winCount + 1
            
            isPlaying = false
            break
        }
    }
    
    // 全て最初の状態にする
    func reset() {
        rightCardNumber = 0
        rightCard = "BK"
        leftCardNumber = 0
        leftCard = "BK"
        winCount = 0
        isPlaying = false
        message = false
//        messageImage = ""
        messageTork = "はじめる！"
        
    }
    // 全て最初の状態にする
    func nextGame() {
       
        leftCardNumber = rightCardNumber
        leftCard = rightCard
        rightCardNumber = 0
        rightCard = "BK"
        isPlaying = false
        message = false
//        messageImage = ""
        messageTork = "はじめる！"
        
    }
    
}
// Model
struct GameManager {
    // カードを取得する処理
    // タプルを使えば便利なのだけれど、まだやっていないからね…
    func card() -> String {
        // カードの種類
        // 1: ♥
        // 2: ♦
        // 3: ♠
        // 4: ♣
        // カードの番号
        // 1〜13
        // ジョーカーは現状考慮していないが追加してもOK
        // 戻り値はカードの種類、スペース、カードの番号
        let number:Int
        let kategori:Int
        let qit:String
        
        number = Int.random(in: 1...13)
        kategori = Int.random(in: 1...4)
        
//        if kategori == 1{
//            qit = "C"
//        } else if kategori == 2 {
//            qit = "D"
//        } else if kategori == 3 {
//            qit = "H"
//        } else {
//            qit = "S"
//        }
        switch kategori {
        case 1:
            qit = "C"
        case 2:
            qit = "D"
        case 3:
            qit = "H"
        case 4:
            qit = "S"
        default:
            qit = "C"
            
        }
        
        
        //テンプレじゃない
//        return "\(kategori) \(number)"
        return "\(qit)\(number)"
        
        
//        return "1 10"
    }
    
    /// 第一引数が大きいならば1
    /// 第二引数が多いいならば2
    /// 等しい場合は3
    /// ただし、1は他の数字よりも大きい
    func compare(left: Int, right: Int) -> Int {
        if(left > right){
            return 1
        } else if(right > left){
            return 2
        } else {
            return 3
            
            
        }
        
    }
    
    // 勝敗を決める
    // Highならばtrue、Lowならfalseとかにしておくと良い
    // 勝ちならばtrue、負けならばfalse
    func isWin(selected: Bool, isHigh: Bool) -> Bool {
        
        if selected == true && isHigh == true {
            return true
        } else if selected == false && isHigh == false {
            return true
        } else {
            return false
        }
        
        
        
    }
}


