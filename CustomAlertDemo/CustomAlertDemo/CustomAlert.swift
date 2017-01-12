//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by quandemacbook on 2016/12/27.
//  Copyright © 2016年 daquan xu. All rights reserved.
//

import UIKit
let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
let MAIN_COLOR = UIColor(red: 52/255.0, green: 197/255.0, blue:
    170/255.0, alpha: 1.0)
class CustomAlert: UIViewController {
    
    let kBakcgroundTansperancy: CGFloat = 0.7
    let kHeightMargin: CGFloat = 10.0 //默认上间距的高度
    let KTopMargin: CGFloat = 20.0
    let kWidthMargin: CGFloat = 10.0
    let kAnimatedViewHeight: CGFloat = 70.0
    let kMaxHeight: CGFloat = 300.0
    var kContentWidth: CGFloat = 300.0
    let kButtonHeight: CGFloat = 35.0 //button 的高度
    var textViewHeight: CGFloat = 90.0
    let kTitleHeight:CGFloat = 30.0
    var contentView = UIView()
    var titleLabel: UILabel = UILabel()
    var subTitleTextView = UITextView()
    var buttons: [UIButton] = []
    var strongSelf:CustomAlert?
    var userAction:((_ button: UIButton) -> Void)? = nil
    //    var cancelButtonTitleColor: UIColor
    //    var comfirmButtonTitleColor: UIColor
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
        self.view.addSubview(contentView)
        
        //强引用 不然按钮点击不能执行
        strongSelf = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -初始化
    fileprivate func setupContentView() {
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleTextView)
        contentView.backgroundColor = UIColor.colorFromRGB(0xFFFFFF)
        contentView.layer.borderColor = UIColor.colorFromRGB(0xCCCCCC).cgColor
        view.addSubview(contentView)
        
    }
    
    
    fileprivate func setupTitleLabel() {
        titleLabel.text = ""
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica", size:25)
        titleLabel.textColor = UIColor.colorFromRGB(0x575757)
    }
    
    fileprivate func setupSubtitleTextView() {
        subTitleTextView.text = ""
        subTitleTextView.textAlignment = .center
        subTitleTextView.font = UIFont(name: "Helvetica", size:16)
        subTitleTextView.textColor = UIColor.colorFromRGB(0x797979)
        subTitleTextView.isEditable = false
    }
    
    //MARK: -布局
    fileprivate func resizeAndRelayout() {
        let mainScreenBounds = UIScreen.main.bounds
        self.view.frame.size = mainScreenBounds.size
        let x: CGFloat = kWidthMargin
        var y: CGFloat = KTopMargin
        let width: CGFloat = kContentWidth - (kWidthMargin*2)
        
        // Title
        if self.titleLabel.text != ""||self.titleLabel.text?.isEmpty == false {
            let titleString = titleLabel.text! as NSString
            let rect = titleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:subTitleTextView.font!], context: nil)
            var  titleLabelHeight : CGFloat
            titleLabelHeight = ceil(rect.size.height) + 10.0
            titleLabel.frame = CGRect(x: x, y: y, width: width, height: titleLabelHeight)
            contentView.addSubview(titleLabel)
            y += titleLabelHeight + kHeightMargin
        }
        if self.subTitleTextView.text.isEmpty == false {
            let subtitleString = subTitleTextView.text! as NSString
            let rect = subtitleString.boundingRect(with: CGSize(width: width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:subTitleTextView.font!], context: nil)
            textViewHeight = ceil(rect.size.height) + 10.0
            subTitleTextView.frame = CGRect(x: x, y: y, width: width, height: textViewHeight)
            contentView.addSubview(subTitleTextView)
            y += textViewHeight + kHeightMargin
        }
        
//        var buttonRect:[CGRect] = []
//        for button in buttons {
//            //            let string = button.title(for: UIControlState())! as NSString
//            //            buttonRect.append(string.boundingRect(with: CGSize(width: width, height:0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:[NSFontAttributeName:button.titleLabel!.font], context:nil))
//        }
        
        var totalWidth: CGFloat = 0.0
        if buttons.count == 2 {
            totalWidth = 300
        }
        else{
            totalWidth = 300
        }
        y += kHeightMargin
        var buttonX = (kContentWidth - totalWidth ) / 2.0
        for i in 0 ..< buttons.count {
            if buttons.count==1 {
                buttons[i].frame = CGRect(x: i * 150, y: Int(y), width:300, height:40)
            }else{
                buttons[i].frame = CGRect(x: i * 150, y: Int(y), width:150, height:40)
            }
            
            buttonX = buttons[i].frame.origin.x + kWidthMargin + 100 + 20.0
            //  buttons[i].layer.cornerRadius = 5.0
            buttons[i].layer.borderWidth = 1
            buttons[i].layer.borderColor = UIColor(red:221/255.0, green:221/255.0, blue:221/255.0, alpha:1).cgColor
            
            self.contentView.addSubview(buttons[i])
            
        }
        y += kHeightMargin + 30
        if y > kMaxHeight {
            let diff = y - kMaxHeight
            let sFrame = subTitleTextView.frame
            subTitleTextView.frame = CGRect(x: sFrame.origin.x, y: sFrame.origin.y, width: sFrame.width, height: sFrame.height - diff)
            
            for button in buttons {
                let bFrame = button.frame
                button.frame = CGRect(x: bFrame.origin.x, y: bFrame.origin.y - diff, width: bFrame.width, height: bFrame.height)
            }
            
            y = kMaxHeight
        }
        
        contentView.frame = CGRect(x: (mainScreenBounds.size.width - kContentWidth) / 2.0, y: (mainScreenBounds.size.height - y) / 2.0, width: kContentWidth, height: y)
        contentView.clipsToBounds = true
        
        //进入时的动画
        contentView.transform = CGAffineTransform(translationX: 0, y:0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.contentView.transform = CGAffineTransform.identity
            }, completion: nil)
    }
}

extension CustomAlert{
    
    //MARK: -alert 方法主体
    func showAlert(_ title: String, subTitle: String?,buttonTitle: String ,otherButtonTitle:String?,cancelColor:UIColor, comfirmColor:UIColor,action:@escaping ((_ OtherButton: UIButton) -> Void)) {
        userAction = action
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        self.setupContentView()
        self.setupTitleLabel()
        self.setupSubtitleTextView()
        
        self.titleLabel.text = title
        if subTitle != nil {
            self.subTitleTextView.text = subTitle
        }
        buttons = []
        if buttonTitle.isEmpty == false {
            let button: UIButton = UIButton()
            button.setTitle(buttonTitle, for: UIControlState())
            button.backgroundColor = UIColor.white
            button.setTitleColor(cancelColor, for: .normal)
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(CustomAlert.doCancel(_:)), for: UIControlEvents.touchUpInside)
            button.tag = 10
            buttons.append(button)
        }
        
        if otherButtonTitle != nil && otherButtonTitle!.isEmpty == false {
            let button: UIButton = UIButton(type: UIButtonType.custom)
            button.setTitle(otherButtonTitle, for: UIControlState())
            button.backgroundColor = UIColor.white
            button.setTitleColor(comfirmColor, for: .normal)
            button.addTarget(self, action: #selector(CustomAlert.pressed(_:)), for: UIControlEvents.touchUpInside)
            
            button.tag = 11
            buttons.append(button)
        }
        resizeAndRelayout()
    }
    
    //MARK: -取消
    func doCancel(_ sender:UIButton){
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }) { (Bool) -> Void in
            
            if self.userAction !=  nil {
                self.userAction!(sender)
            }
            self.view.removeFromSuperview()
            self.cleanUpAlert()
            self.strongSelf = nil
        }
    }
    
    fileprivate func cleanUpAlert() {
        self.contentView.removeFromSuperview()
        self.contentView = UIView()
    }
    func pressed(_ sender: UIButton!) {
        self.view.removeFromSuperview()
        if userAction !=  nil {
            userAction!(sender)
        }
    }
    
    
}


extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
