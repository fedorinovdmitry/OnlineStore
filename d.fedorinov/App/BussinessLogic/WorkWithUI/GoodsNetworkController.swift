import Foundation
import UIKit

protocol GoodsNetworkControllerDelegate {
    var delegateGoodsNetworkC: GoodsNetworkControllerRequestsFactory { get set }
}

protocol GoodsNetworkControllerRequestsFactory {
    func takeCatalog(completionHandler: @escaping ([Good]) -> Void)
}

typealias GoodsNetworkUIViewControllerDelegate = UITableViewController & GoodsNetworkControllerDelegate

///Выполняет логику работы с сетью по запросам работы товаров для View контроллеров
class GoodsNetworController: GoodsNetworkControllerRequestsFactory {
    
    
    //MARK: - Constants
    
    private let controller: GoodsNetworkUIViewControllerDelegate
    private let requestFactoryToWorkWithGoods = RequestFactory.instance.makeRequestToWorkWithGoods()
    
    
    //MARK: - Init
    
    init(controller: GoodsNetworkUIViewControllerDelegate) {
        self.controller = controller
        
    }

    
    //MARK: - Public methods
    
    func takeCatalog(completionHandler: @escaping ([Good]) -> Void) {
        
        requestFactoryToWorkWithGoods.takeCatalogDataOfGoods() { response in
            switch response.result {
            case .success(let login):
                DispatchQueue.main.async {
                    completionHandler(login)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
