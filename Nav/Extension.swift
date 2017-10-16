//
//  Extension.swift
//  ESTDriver
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 湖南润安危物联科技发展有限公司. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width


extension UIResponder
{
    func routeEventWithName(_ eventName:String ,userInfo:NSDictionary){
        self.next?.routeEventWithName(eventName, userInfo: userInfo)
    }
}


extension String{
    //根据宽度跟字体，计算文字的高度
    func textAutoHeight(width: CGFloat, font: UIFont) -> CGFloat{
        let string = self as NSString
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = string.boundingRect(with: CGSize(width: width, height: 0), options: [origin,lead], attributes: [NSFontAttributeName:font], context: nil)
        return rect.height
    }
    //根据高度跟字体，计算文字的宽度
    func textAutoWidth(height: CGFloat, font: UIFont)->CGFloat{
        let string = self as NSString
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = string.boundingRect(with: CGSize(width: 0, height: height), options: [origin,lead], attributes: [NSFontAttributeName:font], context: nil)
        return rect.width
    }
    //解析xml文字
    func attributedString(fontSize: CGFloat)->NSAttributedString?{
        do{
            let opt: [String:Any] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                                     NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]
            let data = self.data(using: String.Encoding.unicode)!
            let att = try NSMutableAttributedString(data: data, options: opt, documentAttributes: nil)
            return att
        }catch{
            print(error)
        }
        return nil
    }
    func attributed()->NSAttributedString?{
        do{
            let opt: [String:Any] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType]
            let data = self.data(using: String.Encoding.unicode)!
            let att = try NSMutableAttributedString(data: data, options: opt, documentAttributes: nil)
            
            return att
        }catch{
            print(error)
        }
        return nil
    }
}

extension NSAttributedString{
    
    func textAutoHeight(width: CGFloat, font: UIFont)->CGFloat{
        let string = self.string as NSString
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = string.boundingRect(with: CGSize(width: width, height: 0), options: [origin,lead], attributes: [NSFontAttributeName:font], context: nil)
        return rect.height

    }
    func textAutoHeightWidtDeleteSpaceEnter(width: CGFloat, font: UIFont)->CGFloat{
        var tmpStr = self.string
        tmpStr = tmpStr.replacingOccurrences(of: "\n", with: "")
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = tmpStr.boundingRect(with: CGSize(width: width, height: 0), options: [origin,lead], attributes: [NSFontAttributeName:font], context: nil)
        return rect.height
    }
}


//MARK:UIColor扩展
extension UIColor {
    //16进制颜色
    class func hexColor(with string:String)->UIColor? {
        var cString = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.characters.count < 6{
            return nil
        }
        if cString.hasPrefix("0X"){
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString .hasPrefix("#"){
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        if cString.characters.count != 6{
            return nil
        }
        
        let rrange = Range(cString.startIndex..<cString.index(cString.startIndex, offsetBy: 2))
        let rString = cString.substring(with: rrange)
        let grange = Range(cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4))
        let gString = cString .substring(with: grange)
        let brange = Range(cString.index(cString.startIndex, offsetBy: 4)..<cString.index(cString.startIndex, offsetBy: 6))
        let bString = cString .substring(with: brange)
        var r:CUnsignedInt = 0 ,g:CUnsignedInt = 0 ,b:CUnsignedInt = 0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0,
                       green: CGFloat(g) / 255.0,
                       blue: CGFloat(b) / 255.0,
                       alpha: 1)
    }
    //RGB颜色
    class func rgbColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    ////UIColor转成颜色图片
    public func conversionToImage(size: CGSize) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
   
}

extension UIImage{
    //图片尺寸的压缩
    func resizeImage() -> UIImage{
        
        let contrastWidth: CGFloat = 1280
        
        let width = self.size.width
        let height = self.size.height
        
        let scale = width / height
        
        var sizeChange = CGSize()
        
        if width <= contrastWidth && height < contrastWidth{
            //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return self
        }else if width > contrastWidth || height > contrastWidth{
            //b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            if scale <= 2 && scale >= 1{
                
                let changeWidth: CGFloat = contrastWidth
                let changeHeight: CGFloat = changeWidth / scale
                
                sizeChange = CGSize(width: changeWidth, height: changeHeight)
                
            }else if scale >= 0.5 && scale <= 1{
                
                let changeHeight = contrastWidth
                let changeWidth = changeHeight * scale
                sizeChange = CGSize(width: changeWidth, height: changeHeight)
            }else if width > contrastWidth && height > contrastWidth {
                //c,宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
                
                if scale > 2{//高的值比较小
                    let changeHeight = contrastWidth
                    let changeWidth = changeHeight * scale
                    sizeChange = CGSize(width: changeWidth, height: changeHeight)
                    
                }else{//宽的值比较小
                    let changeWidth = contrastWidth
                    let changeHeight = changeWidth / scale
                    
                    sizeChange = CGSize(width: changeWidth, height: changeHeight)
                }
                
                
                
            }else{ //d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return self
            }
            
        }
        UIGraphicsBeginImageContext(sizeChange)
        
        self.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
        
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImg!
        
    }
    //图片大小压缩
    func compressData()->Data{
        
        let data = UIImageJPEGRepresentation(self, 1)!
        
        let kb = data.count / 1024
        
        var size: CGFloat = 0.1
        
        if kb > 1500{
            size = 0.3
        }else if kb > 600 {
            size = 0.4
        }else if kb > 400{
            size = 0.5
        }else if kb > 300{
            size = 0.6
        }else if kb > 200{
            size = 0.8
        }else{
            size = 1
        }
        
        let endData = UIImageJPEGRepresentation(self, size)!
        
        return endData
        
    }
    
    //图片圆角
    public func roundImage(radius: CGFloat)->UIImage?{
        let original = self
        let frame = CGRect(x: 0, y: 0, width: original.size.width, height: original.size.height)
        
        UIGraphicsBeginImageContextWithOptions(original.size, false, 1.0)
        
        UIBezierPath(roundedRect: frame, cornerRadius: radius).addClip()
        
        original.draw(in: frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
