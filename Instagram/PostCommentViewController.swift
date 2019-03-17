//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by Nakajima Mizuki on 2019/03/15.
//  Copyright © 2019 Nakajima Mizuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostCommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    var postData: PostData!
    // 選択中のid
    var postDataId: String?
    //テキスト取得用の変数
    var commentText: String?
    
    //コメントしたユーザー名を取得
    var user = Auth.auth().currentUser
    var userName: String?
    var commmentData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("postDataの中身")
        print(postData)
        
        postDataId = postData.id
    }
    
    //投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func postComment(_ sender: Any) {
        print("DEBUG_PRINT: 投稿ボタンが押されました")
        
        //テキストほ取得
        // TextFieldから文字を取得
        commentText = ""
        commentText = commentTextField.text! as String
    
        
        //コメントしたユーザー名を取得
        if (user != nil) {
            userName = user!.displayName
        }
        print("DEBUG_PRINT: コメントした人の名前 \(userName!)")
        print("DEBUG_PRINT: コメント内容 \(commentText!)")
        
        // Firebaseに保存するデータの準備
        let commmentData = ("\(userName!):\(commentText!)\n")
        postData.comment.append(commmentData)
        print(commmentData)
    
        // コメントしたユーザー名とコメントをFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        let comment = ["comment": postData.comment]
        postRef.updateChildValues(comment)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    //キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func cancel(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    

}
