//
//  ViewController.swift
//  SlideshowApp
//
//  Created by PC-SYSKAI553 on 2021/03/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SuperView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerbutton: UIButton!
    
    let imageSource: [String] = ["square", "rogotype", "taikiS", "doto", "company", "runhappy"]
    
    var index: Int = 0
    var timer: Timer!
    var playflg: Bool?
    
    //画像アスペクト比に合わせたimageViewを作成する
    func settingview() {
        let viewwidth = SuperView.frame.size.width
        let viewheight = SuperView.frame.size.height
        let imagewidth = UIImage(named: imageSource[index])!.size.width
        let imageheight = UIImage(named: imageSource[index])!.size.height
        let scaleH = viewheight / imageheight
        let scaleW = viewwidth / imagewidth
        //imagewidth * scaleH < viewwidthだとimageViewが親Viewに収まらない
        if imagewidth < imageheight && imagewidth * scaleH < viewwidth {
            imageView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: imagewidth * scaleH,
                                     height: imageheight * scaleH)
        } else {
            imageView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: imagewidth * scaleW,
                                     height: imageheight * scaleW)
        }
        imageView.center = CGPoint(x: (viewwidth / 2),
                                   y: (viewheight / 2))
    }
    
    override func viewDidLayoutSubviews() {
        //viewDidLoadでは.frameが決定していないのでここに記載
        settingview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            let DVC: detailViewController = segue.destination as! detailViewController
            
            if timer != nil {
                timer.invalidate()  //タイマーを止める
                timer = nil         //再度起動できるようnilを設定
                timerbutton.setTitle("再生", for: UIControl.State.normal)
                timerbutton.backgroundColor = UIColor(red: 97/255, green: 186/255, blue: 219/255, alpha: 1.0)
                playflg = true
            } else {
                playflg = false
            }
    
            //データ受け渡し
            DVC.imageSource = self.imageSource
            DVC.index = self.index
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: imageSource[index])
        imageView.isUserInteractionEnabled = true
        timerbutton.layer.cornerRadius = 10.0
    }
    //「進む」を押した時に呼ばれる
    @IBAction func next(_ sender: Any) {
        if timer == nil {
            //最後の要素になったら添字を０に
            if index + 1 == imageSource.count {
                index = 0
                settingview()
                imageView.image = UIImage(named: imageSource[index])
            } else {
                index += 1
                settingview()
                imageView.image = UIImage(named: imageSource[index])
            }
        }
    }
    //「戻る」を押した時に呼ばれる
    @IBAction func back(_ sender: Any) {
        //止まってる時だけ
        if timer == nil {
            //最初の要素なら添字を配列の個数-1に
            if index == 0 {
                index = imageSource.count - 1
                settingview()
                imageView.image = UIImage(named: imageSource[index])
            } else {
                index -= 1
                settingview()
                imageView.image = UIImage(named: imageSource[index])
            }
        }
    }
    //「再生/停止」を押すと呼ばれる
    @IBAction func Timer(_ sender: Any) {
        //タイマーが起動してない時の処理
        if timer == nil {
            timer = Foundation.Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerbutton.setTitle("停止", for: UIControl.State.normal)
            timerbutton.backgroundColor = UIColor(red: 224/255, green: 98/255, blue: 119/255, alpha: 1.0)
        } else {                //起動してる時の処理
            timer.invalidate()  //タイマーを止める
            timer = nil         //再度起動できるようnilを設定
            timerbutton.setTitle("再生", for: UIControl.State.normal)
            timerbutton.backgroundColor = UIColor(red: 97/255, green: 186/255, blue: 219/255, alpha: 1.0)
        }
    }
    
    @objc func updateTimer() {
        if index + 1 == imageSource.count { //最後の要素の時
            index = 0
            settingview()
            imageView.image = UIImage(named: imageSource[index])
        } else {
            index += 1
            settingview()
            imageView.image = UIImage(named: imageSource[index])
        }
    }
    

    /*@IBAction func todetail(_ sender: Any) {
        timer.invalidate()  //タイマーを止める
        timer = nil         //再度起動できるようnilを設定
        timerbutton.setTitle("再生", for: UIControl.State.normal)
        timerbutton.backgroundColor = UIColor(red: 97/255, green: 186/255, blue: 219/255, alpha: 1.0)
    }*/
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        if playflg == true {
            timer = Foundation.Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerbutton.setTitle("停止", for: UIControl.State.normal)
            timerbutton.backgroundColor = UIColor(red: 224/255, green: 98/255, blue: 119/255, alpha: 1.0)
        }
    }
    
}

