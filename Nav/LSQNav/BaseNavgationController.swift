//
//  BaseNavgationController.swift
//  Nav
//
//  Created by lsq on 2017/10/13.
//  Copyright © 2017年 罗石清. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController, UIGestureRecognizerDelegate,  UINavigationControllerDelegate{
    
    fileprivate var pan: UIPanGestureRecognizer!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationBar.tintColor = UIColor.white
        
        let target = self.interactivePopGestureRecognizer?.delegate
        let handelTransition = NSSelectorFromString("handleNavigationTransition:")
        
        self.pan = UIPanGestureRecognizer(target: target, action: handelTransition)
        self.pan.delegate = self
        
        self.view.addGestureRecognizer(self.pan)
        
        self.interactivePopGestureRecognizer?.isEnabled = false
    }

   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        self.interactivePopGestureRecognizer?.isEnabled = true
    }

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //如果是跟视图，则不能滑动返回
        if self.childViewControllers.count == 1 {
            return false
        }
        
        return self.isCanPan()
    }
    
    /*是否可以滑动的控制器*/
    //true可以滑动，false不能滑动
    fileprivate func isCanPan()->Bool{
        
        guard let lastCls = self.childViewControllers.last else {
            return false
        }
        //获取所有不能滑动返回的控制器类别
        let cantVCs = LSQNavConfiguration.canPanVC
        var isCan = true
        for cls in cantVCs{
            let can = lastCls.isKind(of: cls)
            isCan = !can
            break
        }
        return isCan
    }
    
}

//TODO:延展UINavigationBar
extension UINavigationBar {
    
    fileprivate struct AssociatedKeys {
        static var DescriptiveName = "CustomNavigationBar"
    }
    
    var overlayer:UIView? {
        get {
            let anyObj = objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName)
            return anyObj as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setCustomBackgroundColor(_ color:UIColor){
        if(self.overlayer == nil){
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = UIImage()
            //获取状态栏高度
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            self.overlayer = UIView(frame: CGRect(x: 0,y: 0,width: ScreenWidth,height: self.frame.height + statusBarHeight))
            self.overlayer?.isUserInteractionEnabled = false
            self.overlayer?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            self.subviews.first?.insertSubview(self.overlayer!, at: 0)
        }
        
        self.overlayer!.backgroundColor = color
    }
}


