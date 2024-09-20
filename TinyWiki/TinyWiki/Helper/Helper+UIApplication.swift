//
//  Helper+UIApplication.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/21/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
