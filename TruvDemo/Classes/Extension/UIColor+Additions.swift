//
//  UIColor+Additions.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import UIKit

extension UIColor {

    static let main: UIColor = UIColor(red: 244, green: 244, blue: 244)
    static let textGray: UIColor = UIColor(red: 153, green: 153, blue: 153)
    static let accent: UIColor = UIColor(red: 44, green: 100, blue: 227)

    // MARK: - Private

    private convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

}
