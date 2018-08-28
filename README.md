# CountDownImageView




![效果图](https://upload-images.jianshu.io/upload_images/1940927-b687069fecb5279c.gif?imageMogr2/auto-orient/strip)


<br>

## 作者的脑洞：

> 1、 效果图氛围上下两个部分，这里使用绘图实现，既然是上下两张图片，所以采用`ImageView`作为视图，在里面添加一张图片就好了。

> 2、然后上面的一张图片会呈现递减的动画效果，这里采用`maskLayer`实现

> 3、还有一个`label`


公开属性
> - 为了增强扩展性，两个进度的颜色应该有外界指定（`foregroundProgressColor`,`backgroundProgressColor`）
> - 倒计时时间应该有外界决定 (`maxCountDown`)
> - 还有字体以及字体颜色、时间间隔（`timeFont`,`timeColor`,`timeInterval`）


公开方法
> 提供更新时间、颜色的接口
> ```
>public func update(foregroundProgressColor: UIColor, >backgroundProgressColor: UIColor, maxCountDown: CGFloat) 
>```
> 提供控制倒计时相关的方法
>```
>public func startCountDown()
>public func pauseCountDown()
>public func stopCountDown()
>```

***

脑洞结束


<br>

#### 为图片添加`extension`

```
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

```

<br>

#### 为`CGFloat`类型添加`extension`

```
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
```

<br>

# [代码地址]()
