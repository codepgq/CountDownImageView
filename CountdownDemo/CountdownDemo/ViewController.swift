//
//  ViewController.swift
//  CountdownDemo
//
//  Created by 盘国权 on 2018/8/28.
//  Copyright © 2018年 pgq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countDownImageView: CountDownImageView!
    
    @IBAction func startCountDown(_ sender: UIButton) {
        countDownImageView.startCountDown()
        orangeGrayCountDownImageView.startCountDown()
    }
    
    @IBAction func pauseCountDown(_ sender: UIButton) {
        countDownImageView.pauseCountDown()
        orangeGrayCountDownImageView.pauseCountDown()
    }
    
    @IBAction func stopCountDown(_ sender: UIButton) {
        countDownImageView.stopCountDown()
        orangeGrayCountDownImageView.stopCountDown()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownImageView.update(foregroundProgressColor: .green, backgroundProgressColor: .darkText, maxCountDown: 100)
        countDownImageView.timeInterval = 1
        
        view.addSubview(orangeGrayCountDownImageView)
    }
    var orangeGrayCountDownImageView = CountDownImageView(frame: CGRect(x: 10, y: 300, width: 200, height: 30), foregroundProgressColor: .orange, backgroundProgressColor: .gray, maxCountDown: 90)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

