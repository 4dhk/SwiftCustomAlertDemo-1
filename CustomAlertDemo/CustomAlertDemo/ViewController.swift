//
//  ViewController.swift
//  CustomAlertDemo
//
//  Created by quandemacbook on 2017/1/12.
//  Copyright © 2017年 jackxu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: UIButton) {
        
       let alertController = CustomAlert()
        
        alertController.showAlert("notice", subTitle: "message", buttonTitle: "取消", otherButtonTitle: "确定", cancelColor: UIColor.red, comfirmColor: UIColor.green) { (otherButton) in
            
            if otherButton.tag == 10 {
                print("点击了取消")
            }else{
                print("点击了确定")

            }
        }
        
    }

}

