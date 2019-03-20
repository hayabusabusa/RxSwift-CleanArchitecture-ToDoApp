
import UIKit

class AlertManager {
    
    static func alertWithOk(_ viewController: UIViewController, title: String, message: String, okTitle: String, hanler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: hanler)
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func alertWithCancelOk(_ viewController: UIViewController, title: String, message: String, okTitle: String, cancelTitle: String, hanler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: hanler)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func alertWithCancelOk(_ viewController: UIViewController, title: String, message: String, okTitle: String, cancelTitle: String,
                                  okHanler: ((UIAlertAction) -> Void)? = nil, cancelHanler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: okHanler)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: cancelHanler)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // swiftlint:disable:next function_parameter_count
    static func alertWithTextField(_ viewController: UIViewController, title: String, message: String, okTitle: String, cancelTitle: String,
                                   placeholder: String, completion: @escaping (String) -> Void ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: { _ in
            if let textField = alertController.textFields?.first {
                if let text = textField.text {
                    completion(text)
                }
            }
        })
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = placeholder
        })
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func actionSheetWithCancelOk(_ viewController: UIViewController, title: String, message: String, okTitle: String, cancelTitle: String, hanler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: hanler)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // swiftlint:disable:next function_parameter_count
    static func actionSheetWithDestructive(_ viewController: UIViewController, title: String, message: String,
                                           okTitle: String, destTitle: String, cancelTitle: String, okHanler: ((UIAlertAction) -> Void)? = nil, deleteHanler: ((UIAlertAction) -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: okHanler)
        let deleteAction = UIAlertAction.init(title: destTitle, style: .destructive, handler: deleteHanler)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
