import UIKit

///хранит теги юайных элементов
struct TagUIelement {
    static let activityIndicator = 1001
}
class SupportingUIElementsFactory {
    
    func makeActivityIndicator(controller: UIViewController) -> UIActivityIndicatorView {
        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = TagUIelement.activityIndicator
        activityIndicator.center = controller.view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
    
}
