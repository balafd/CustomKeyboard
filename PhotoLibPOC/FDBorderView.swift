//
//  FDBorderView.swift
//  PhotoLibPOC
//
//  Created by Bala on 22/02/17.
//  Copyright © 2017 Freshdesk Inc. All rights reserved.
//

import UIKit

@IBDesignable class FDBorderView: NSObject {
    
    @IBOutlet weak var targetView: UIView?
}

extension FDBorderView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return (targetView?.layer.cornerRadius)!
        }
        set {
            targetView?.layer.cornerRadius = newValue
            targetView?.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return (targetView?.layer.borderWidth)!
        }
        set {
            targetView?.layer.borderWidth = newValue
            targetView?.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: (targetView?.layer.borderColor!)!)
        }
        set {
            targetView?.layer.borderColor = newValue.cgColor
        }
    }
}
