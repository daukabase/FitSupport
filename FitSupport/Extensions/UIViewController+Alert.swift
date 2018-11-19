//
//  UIViewController+Alert.swift
//  FitSupport
//
//  Created by Daulet on 19/11/2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

enum AlertType {
    case confirmation
    case simple
}

extension UIViewController {
    func showAlert(with type: AlertType, title: String, message: String?, onPress: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            onPress?()
        }))
        switch type {
        case .confirmation:
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
