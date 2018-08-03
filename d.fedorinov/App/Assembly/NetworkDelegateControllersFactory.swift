import UIKit

protocol NetworkDelegateControllersFactory {
    func makePersonalCabNetworkControllerDelegate (controller: PersonalCabNetworkUIViewControllerDelegate)
        -> PersonalCabNetworkRequestsFactory
    func makeGoodsNetworkControllerDelegate (controller: GoodsNetworkUIViewControllerDelegate)
        -> GoodsNetworkControllerRequestsFactory
    func makeReviewsNetworkControllerDelegate (controller: ReviewsNetworkUIViewControllerDelegate)
        -> ReviewsNetworkControllerRequestsFactory
}

///Фабрика делегатов по работе с сетью
class NetworkDelegateControllersBornFactory: NetworkDelegateControllersFactory {
    
    func makePersonalCabNetworkControllerDelegate (controller: PersonalCabNetworkUIViewControllerDelegate)
        -> PersonalCabNetworkRequestsFactory {
        return PersonalCabNetworkController(controller: controller)
    }
    
    func makeGoodsNetworkControllerDelegate (controller: GoodsNetworkUIViewControllerDelegate)
        -> GoodsNetworkControllerRequestsFactory {
            return GoodsNetworController(controller: controller)
    }
    
    func makeReviewsNetworkControllerDelegate (controller: ReviewsNetworkUIViewControllerDelegate)
        -> ReviewsNetworkControllerRequestsFactory {
        return ReviewsNetworkController(controller: controller)
    }
    
    func makeBasketNetworkControllerDelegate<T: BasketDelegate> (viewController: T) -> BasketNetworkControllerRequestsFactory? {
        switch viewController {
        case is BasketNetworkControllerDelegateToCell:
            return BasketNetworkController(cell: viewController as! BasketNetworkControllerDelegateToCell)
        case is BasketNetworkControllerDelegateToTabbleController:
            return BasketNetworkController(tableController: viewController as! BasketNetworkControllerDelegateToTabbleController)
        default:
            return nil
        }
    }
    
}
