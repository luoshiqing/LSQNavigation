//
//  LSQNavConfiguration.swift
//  Nav
//
//  Created by lsq on 2017/10/16.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class LSQNavConfiguration: NSObject {
    //1.导航栏颜色
    static let navColor = UIColor.hexColor(with: "#25C189")!
    //2.设置为透明色的控制器
    static let clearnVC: [AnyClass] = [HomeViewController.classForCoder(),
                                       ThiredViewController.classForCoder()]
    //3.不能滑动返回的控制器
    static let canPanVC: [AnyClass] = [NoPanViewController.classForCoder()]

}

