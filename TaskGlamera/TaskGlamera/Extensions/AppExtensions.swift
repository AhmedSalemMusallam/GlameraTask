//
//  AppExtensions.swift
//  Frooter
//
//  Created by Ahmed Salem on 03/12/2023.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func encodeUrl() -> String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
    
    func decodeUrl() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    func strikethrough(_ text:String) -> NSAttributedString{
        let range = (self as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont(name: "DIN-REGULAR", size: 13) ?? UIFont.systemFont(ofSize: 13)], range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: range)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: range)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: range)
        return attributedString
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
//    var htmlToAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return nil
//        }
//    }
    
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
    
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
   
}

extension UIView {
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
}

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var topCornerRightRadius: Bool = false {
        didSet {
            topCornerRightRadius = true
            updateCorners()
        }
    }
    @IBInspectable var topCornerLeftRadius: Bool = false {
        didSet {
            topCornerLeftRadius = true
            updateCorners()
        }
    }
    @IBInspectable var bottomCornerRightRadius: Bool = false {
        didSet {
            bottomCornerRightRadius = true
            updateCorners()
        }
    }
    @IBInspectable var bottomCornerLeftRadius: Bool = false {
        didSet {
            bottomCornerLeftRadius = true
            updateCorners()
        }
    }
    func updateCorners() {
        var corners = CACornerMask()
        if topCornerLeftRadius { corners.formUnion(.layerMinXMinYCorner) }
        if topCornerRightRadius { corners.formUnion(.layerMaxXMinYCorner) }
        if bottomCornerLeftRadius { corners.formUnion(.layerMinXMaxYCorner) }
        if bottomCornerRightRadius{ corners.formUnion(.layerMaxXMaxYCorner) }
        layer.maskedCorners = corners
        layer.cornerRadius = cornerRadius
    }
}

extension UITextField {
    @IBInspectable
    var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedString.Key.foregroundColor : newValue]
            
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
    public func base64(format: ImageFormats) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = self.pngData()
        case .jpeg(let compression): imageData = self.jpegData(compressionQuality: compression)
        }
        return imageData?.base64EncodedString()
    }
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> UIImage? {
        return UIImage(data: self.jpegData(compressionQuality: quality.rawValue)!)
        
    }
    func jpegData(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)
        
    }
}
public enum ImageFormats {
    case png
    case jpeg(CGFloat)
}
extension UITextView{
    func validateEmpty() -> Bool {
        guard let text = self.text else {return false}
        print("the value of TV is -> \(text)")
        guard text.count < 32 else {
            return true
        }
        return false
    }
    func validateEmptyValue(value:String?) -> Bool {
        if value == self.text
        {
            print("tets tets")
            return false
        }
       
        
        guard let text = self.text else {return false}
        print("the value of TV is -> \(text)")
        guard text.isEmpty else {
            return true
        }
        
        return false
    }
}
extension UITextField {
    
    func validateEmpty() -> Bool {
        guard let text = self.text else {return false}
        guard text.isEmpty else {
            return true
        }
        return false
    }
    
    func validateNumberCount() -> Bool {
        guard let text = self.text else {return false}
        guard text.count != 10 else {
            return true
        }
        return false
    }
    
    func validateEmail() -> Bool {
        guard validateEmpty() else {return false}
        guard let text = self.text else {return false}
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard !emailTest.evaluate(with: text) else{return true}
        return false
    }
    
    func validatePassword(with password: UITextField) -> Bool {
        guard validateEmpty() else {return false}
        guard password.validateEmpty() else {return false}
        guard self.text == password.text else{return false}
        return true
    }
}
extension String {
        func removingWhitespaces() -> String {
            return components(separatedBy: .whitespaces).joined()
        }
    
}

class DiagonalStrikethroughLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let color = textColor.cgColor
        let strokeWidth: CGFloat = 2.0
        
        context.setStrokeColor(color)
        context.setLineWidth(strokeWidth)
        print("rect.minX -> \(rect.minX)")
        print("rect.minY -> \(rect.minY)")
        print("rect.maxX -> \(rect.maxX)")
        print("rect.maxY -> \(rect.maxY)")
        context.move(to: CGPoint(x: rect.minX, y: rect.minY+25))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-20))
        
        context.strokePath()
    }
}
