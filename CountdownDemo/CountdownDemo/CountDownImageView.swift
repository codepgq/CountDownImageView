//
//  CountDownView.swift
//  CountdownDemo
//
//  Created by 盘国权 on 2018/8/28.
//  Copyright © 2018年 pgq. All rights reserved.
//

import UIKit

// MARK: - UIImage extension
extension UIImage {
    class func drawRect(_ size: CGSize, color: UIColor, radius: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.setFill()
        UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// MARK: - UIImage CGFloat
extension CGFloat {
    func getTotalTime() -> String{
        let hour: Int, minute: Int, second: Int
        minute = Int(self) / 60
        second = Int(self) % 60
        if self > 3600 {
            hour = Int(self) / 3600
            return String(format: "%02d:%02d:%02d", arguments: [hour,minute,second])
        }else{
            return String(format: "%02d:%02d", arguments: [minute,second])
        }
    }
}

class CountDownImageView: UIImageView {
    
    // MARK: - public property
    /// 倒计时的字体
    var timeFont: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            timeLabel.font = timeFont
        }
    }
    /// 倒计时的颜色
    var timeColor: UIColor = .white {
        didSet {
            timeLabel.textColor = timeColor
        }
    }
    /// 倒计时时间间隔
    var timeInterval: TimeInterval = 1
    /// 倒计时时间
    internal(set) var maxCountDown: CGFloat = 500
    /// 前景颜色
    internal(set) var foregroundProgressColor: UIColor = .red
    /// 背景颜色
    internal(set) var backgroundProgressColor: UIColor = .orange
    
    // MARK: - public convenience init method
    convenience init(frame: CGRect, foregroundProgressColor: UIColor, backgroundProgressColor: UIColor, maxCountDown: CGFloat) {
        self.init(frame: frame)
        self.foregroundProgressColor = foregroundProgressColor
        self.backgroundProgressColor = backgroundProgressColor
        self.maxCountDown = maxCountDown
    }
    
    // MARK: - public method
    public func update(foregroundProgressColor: UIColor, backgroundProgressColor: UIColor, maxCountDown: CGFloat) {
        self.foregroundProgressColor = foregroundProgressColor
        self.backgroundProgressColor = backgroundProgressColor
        self.maxCountDown = maxCountDown
        
        self.foregroundImageView.frame = .zero
        layoutSubviews()
    }
    
    /// 开启/恢复倒计时
    public func startCountDown() {
        if let timer = countDownTimer {
               timer.fireDate = Date.distantPast
        } else {
            stopCountDown()
            countDownTimer = createTimer()
        }
        
    }
    /// 暂停倒计时
    public func pauseCountDown() {
        countDownTimer?.fireDate = Date.distantFuture
    }
    /// 停止倒计时
    public func stopCountDown() {
        countDownTimer?.invalidate()
        countDownTimer = nil
    }
    
    // MARK: - private property
    private var countDownTimer: Timer?
    private var precent: CGFloat = 0
    private lazy var foregroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        self.addSubview(imageView)
        return imageView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.text = maxCountDown.getTotalTime()
        self.insertSubview(label, aboveSubview: self.foregroundImageView)
        return label
    }()
    
    private lazy var foregroundMaskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.foregroundImageView.layer.mask = layer
        return layer
    }()
    
    // MARK: - system method
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if foregroundImageView.frame == .zero {
            // 0、设置前景图片的frame
            foregroundImageView.frame = bounds
            timeLabel.frame = bounds
            
            // 1、画灰色图片
            let backgroundImage = UIImage.drawRect(frame.size, color: backgroundProgressColor, radius: frame.size.height * 0.5)
            image = backgroundImage
            
            // 2、画红色图片
            let foregroundImage = UIImage.drawRect(frame.size, color: foregroundProgressColor, radius: frame.size.height * 0.5)
            foregroundImageView.image = foregroundImage
        }
    }
}

// MARK: - timer
extension CountDownImageView {
    private func createTimer() -> Timer?{
        let countDownTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.countDownEvent), userInfo: nil, repeats: true)
        RunLoop.current.add(countDownTimer, forMode: .commonModes)
        return countDownTimer
    }
    
    @objc private func countDownEvent() {
        
        if precent > maxCountDown {
            stopCountDown()
            return
        }
        
        timeLabel.text = (maxCountDown - precent).getTotalTime()
        precent += 1
        let progress = 1 - (precent / maxCountDown)
        
        foregroundMaskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.size.width * progress, height: self.frame.size.height), cornerRadius: self.frame.size.height * 0.5).cgPath
    }
}
