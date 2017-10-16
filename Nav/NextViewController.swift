//
//  NextViewController.swift
//  Nav
//
//  Created by lsq on 2017/10/13.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class NextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NEXT"
        self.view.backgroundColor = LSQNavConfiguration.navColor
        
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        btn.center = self.view.center
        btn.setTitle("下一个", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(self.btnAct(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func btnAct(_ send: UIButton){
        let next = ThiredViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }

    
}
