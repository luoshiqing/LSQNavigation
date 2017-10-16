//
//  ThiredViewController.swift
//  Nav
//
//  Created by lsq on 2017/10/16.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class ThiredViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "Thired"
        self.view.backgroundColor = UIColor.red
        //隐藏navBar
        self.isHiddenBar = true
        
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 100, height: 40))
        btn.center.x = self.view.center.x
        btn.setTitle("下一个", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(self.btnAct(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }

    func btnAct(_ send: UIButton){
        print("点击l ")
        let noPan = NoPanViewController()
        self.navigationController?.pushViewController(noPan, animated: true)
    }


    
}
