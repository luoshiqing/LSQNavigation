//
//  NoPanViewController.swift
//  Nav
//
//  Created by lsq on 2017/10/16.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class NoPanViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "不能滑动返回"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //重写返回（同样，可以重写返回按钮）
    override func backClick(_ send: UIBarButtonItem) {
        print("重写返回->，点击了")
        self.navigationController?.popViewController(animated: true)
    }

}
