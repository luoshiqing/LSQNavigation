//
//  BaseScrollView.swift
//  ESTLoading
//
//  Created by rainfo on 2017/6/5.
//  Copyright © 2017年 湖南润安危物联科技发展有限公司. All rights reserved.
//

import UIKit
/*如果需要 ScrollView滑动到边缘有滑动返回效果，请继承该BaseScrollView*/
class BaseScrollView: UIScrollView ,UIGestureRecognizerDelegate{

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        if otherGestureRecognizer.state == UIGestureRecognizerState.began && self.contentOffset.x == 0
        {
            return true
        }
        
        
        return false
    }
    
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//
//        print(self.contentOffset.x,gestureRecognizer.state)
//        
//        if NSStringFromClass(touch.view!.classForCoder) == "UITableViewCellContentView"
//        {
//            return false
//        }
//        
//        
//        
//        return true
//    }

    
}
