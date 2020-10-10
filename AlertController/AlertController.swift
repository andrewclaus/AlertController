//
//  AlertController.swift
//  Andrew Claus
//
//  Created by Andrew Claus on 10/10/20.
//  Copyright © 2020 Andrew Claus. All rights reserved.
//

import UIKit

publich class AlertController: UIAlertController {
    private static var alertWindows = [UIWindow]()
    private var alertWindow: UIWindow!
    private var completion: ((Int, String) -> Void)?
    private var confirmation: ((Bool) -> Void)?
    
    static func alert(_ message: String, title: String = K.Alert.DefaultTitle, buttonTitles: [String] = ["OK"], completion: ((Int, String)->())? = nil) {
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        for title in buttonTitles {
            let action = UIAlertAction(title: title, style: .default, handler: { (_) in
                completion?(buttonTitles.firstIndex(of: title) ?? 0, title)
            })
            alert.addAction(action)
        }
        
        alert.show()
    }
    
    static func alert(_ message: String, title: String = K.Alert.DefaultTitle, actions: [UIAlertAction]) {
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        alert.show()
    }
    
    static func confirm(_ message: String, title: String = K.Alert.DefaultTitle, completion: ((Bool)->())?) {
        
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        let noButton = UIAlertAction(title: "No", style: .default) { (_) in
            completion?(false)
        }
        alert.addAction(noButton)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (_) in
            completion?(true)
        }
        alert.addAction(yesButton)
        
        alert.show()
    }
    
    func show(animated: Bool = true) {
        
        guard let topWindow = UIApplication.shared.windows.last else {
            fatalError("Unable to show alert if there are no active windows in the application!")
        }
        
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = topWindow.windowLevel + 1
        
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(self, animated: animated, completion: nil)
        
        AlertController.alertWindows.last?.alpha = 0.0
        AlertController.alertWindows.append(alertWindow)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //remove our window from the stack
        AlertController.alertWindows.removeAll { $0 == alertWindow }
        
        //now that our window is gone, make the one below appear
        UIView.animate(withDuration: 0.3) {
            AlertController.alertWindows.last?.alpha = 1.0
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        
        alertWindow.isHidden = true
        alertWindow = nil //once the alert has been removed, set it's window to nil to prevent a retain cycle
        super.viewDidDisappear(animated)
    }
}
