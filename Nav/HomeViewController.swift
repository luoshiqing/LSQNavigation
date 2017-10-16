//
//  HomeViewController.swift
//  Nav
//
//  Created by lsq on 2017/10/16.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        //是否隐藏navbar
        self.isHiddenBar = true
        
        let topBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 100, height: 35))
        topBtn.center.x = self.view.center.x
        topBtn.setTitle("测试点击", for: .normal)
        topBtn.setTitleColor(UIColor.white, for: .normal)
        topBtn.backgroundColor = UIColor.green
        topBtn.tag = 0
        topBtn.addTarget(self, action: #selector(self.btnAct(_:)), for: .touchUpInside)
        self.view.addSubview(topBtn)
        
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        btn.center = self.view.center
        btn.setTitle("下一个", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.green
        btn.tag = 1
        btn.addTarget(self, action: #selector(self.btnAct(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    func btnAct(_ send: UIButton){
        
        switch send.tag {
        case 0:
            print("测试点击")
            
            let alertCtr = UIAlertController(title: "测试一下效果", message: "呵呵", preferredStyle: .alert)
            alertCtr.addAction(UIAlertAction(title: "确定", style: .default, handler: { (act) in
                print("还有这种操作")
            }))
            alertCtr.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.present(alertCtr, animated: true, completion: nil)
            
        case 1:
            let next = NextViewController()
            self.navigationController?.pushViewController(next, animated: true)
        default:
            break
        }
        
        
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)
//    }

}
