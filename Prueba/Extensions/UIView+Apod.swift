//
//  UIView+Apod.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/10/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addCornerRadius(corners: UIRectCorner = [.bottomLeft , .bottomRight]) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        self.layer.mask = rectShape
    }
}
