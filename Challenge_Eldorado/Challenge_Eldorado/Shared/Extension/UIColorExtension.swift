//
//  UIColorExtension.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

extension UIColor{
    convenience init(red: CGFloat, gree: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: gree/255, blue: blue/255, alpha: 1)
    }
}
