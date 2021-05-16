import UIKit
import Foundation

class AlertManager {
    private init() {}
    static var shared = AlertManager()
    
    func showAlertManager (vc: UIViewController, title titleStr: String = "Alert", message messageStr: String, handler completionHandler: @escaping () -> ()) {
        
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert) in completionHandler() }))
        vc.present(alert, animated: true, completion: nil)
    }
}
