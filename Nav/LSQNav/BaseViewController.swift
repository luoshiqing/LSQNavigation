//
//  BaseViewController.swift
//  Nav
//
//  Created by lsq on 2017/10/13.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

/*使用模拟器滑动返回，有时导致导航栏标题位置不对，使用真机没毛病！*/

class BaseViewController: UIViewController {
    
    /*设置透明导航栏是否隐藏 UINavigationBar,默认是不隐藏的*/
    public var isHiddenBar = false
    /*设置导航栏颜色为 LSQNavConfiguration.navColor */
    fileprivate let navBarColor = LSQNavConfiguration.navColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.setNavigationBackItem()
    }

    fileprivate struct AssociatedKeys {
        static var DescriptiveName = "CustomViewController"
    }
    
    public var barView:UIView?{
        get{
            let obj = objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName)
            return obj as? UIView
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    //TODO:将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isClearVC(){
            self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)
            self.navigationController?.setNavigationBarHidden(isHiddenBar, animated: animated)
            return
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        if barView == nil{
            barView = UIView(frame: CGRect(x: 0,y: 0,width: ScreenWidth,height: 64))
            barView!.backgroundColor = self.navBarColor
            self.view.addSubview(barView!)
        }
        
    }
    
 
    //TODO:已经显示
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isClearVC(){
            self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)

            return
        }
        self.navigationController?.navigationBar.setCustomBackgroundColor(self.navBarColor)
        
        if barView != nil{
            barView!.removeFromSuperview()
            barView = nil
        }
    }
    
    //TODO:将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isClearVC(){
            self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)
            return
        }
        
        if barView == nil{
            barView = UIView(frame: CGRect(x: 0,y: 0,width: ScreenWidth,height: 64))
            barView!.backgroundColor = self.navBarColor
            self.view.addSubview(barView!)
        }
    }

    //TODO:已经消失
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.isClearVC(){
            self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)
            return
        }
        if barView != nil{
            barView!.removeFromSuperview()
            barView = nil
        }
    }
 
    //TODO:判断是否需要使用透明控制器
    fileprivate func isClearVC()->Bool{
        var isClearVC = false
        let anyClass = LSQNavConfiguration.clearnVC
        
        for cls in anyClass{
            if self.isKind(of: cls){
                isClearVC = true
                break
            }
        }
        return isClearVC
    }

    
}

extension BaseViewController{
    //TODO:自定义返回按钮
    public func setNavigationBackItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_arrow_icon"), style: .plain, target: self, action: #selector(self.backClick(_:)))
    }
    
    public func backClick(_ send: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
}

