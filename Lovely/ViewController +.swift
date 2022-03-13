//
//  ViewController +.swift
//  Lovely
//
//  Created by Roman Fedotov on 13.03.2022.
//

import UIKit

extension UIViewController {
    static var indentifier: String {
        return String(describing: self)
    }
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: indentifier) as! Self
    }
}
