//
//  UIApplication+firstResponder.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/10/21.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
