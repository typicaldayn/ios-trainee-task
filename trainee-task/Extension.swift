//
//  Extension.swift
//  trainee-task
//
//  Created by Stas Bezhan on 08.07.2022.
//

import Foundation
import UIKit

extension UITextView {

    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }

}
