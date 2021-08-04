//
//  String + StrikeThroughLabel.swift
//  ProductUI
//
//  Created by Bhupender Rawat on 04/08/21.
//

import UIKit

extension String {
    
    public func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
}
