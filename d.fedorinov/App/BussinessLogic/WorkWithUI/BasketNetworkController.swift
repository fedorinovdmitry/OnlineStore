import UIKit

//общий протокол для обращения к типам которые могут делегировать работу с корзиной
protocol BasketDelegate: class {}

protocol BasketDelegateCell {
    var delegateBasketNetworkController: BasketNetworkinCell? { get set }
}
protocol BasketDelegateTable {
    var delegateBasketNetworkController: BasketNetworkInTable? { get set }
}

protocol BasketNetworkinCell {
    init(cell: BasketNetworkControllerDelegateToCell)
    func addToBasket(idGood: Int,
                     completionHandler: @escaping () -> Void)
    func payOrder(completionHandler: @escaping () -> Void)
}

protocol BasketNetworkInTable {
    init(tableController: BasketNetworkControllerDelegateToTabbleController)
    func takeBasket(completionHandler: @escaping ([Good]) -> Void)
    func deleteGoodFromBasket(idGood:Int, quantity:Int)
    
}

typealias BasketNetworkControllerDelegateToCell
    = BasketDelegateCell & BasketDelegate & UITableViewCell
typealias BasketNetworkControllerDelegateToTabbleController
    = BasketDelegateTable & BasketDelegate & UITableViewController

typealias BasketNetworkControllerRequestsFactory = BasketNetworkinCell & BasketNetworkInTable

///Выполняет логику работы с сетью по запросам к корзине для View контроллеров
class BasketNetworkController: BasketNetworkControllerRequestsFactory {
    
    
    //MARK: - Constants

    private let requestFactoryToWorkWithBasket = RequestFactory.instance.makeRequsetsToWorkWithBasket()
    
    //MARK: - Public Properties
    
    lazy var delegateGoodCell: BasketNetworkControllerDelegateToCell? = nil
    lazy var delegateGoodTable: BasketNetworkControllerDelegateToTabbleController? = nil
    
    
    //MARK: - Private Properties
    
    private var user: User {
        return ActiveUser.instance.getUser()!
    }
    
    //MARK: - Init
    
    required init(cell: BasketNetworkControllerDelegateToCell) {
        self.delegateGoodCell = cell
    }
    
    required init(tableController: BasketNetworkControllerDelegateToTabbleController) {
        self.delegateGoodTable = tableController
    }
    
    //MARK: - Public methods
    
    func addToBasket(idGood: Int,
                     completionHandler: @escaping () -> Void) {
        
        // добавляем 1 товар
        let quantity = 1
        
        requestFactoryToWorkWithBasket.addGoodToBasket(idUser: user.id,
                                                       idGood: idGood,
                                                       quantity: quantity) { response in
            switch response.result {
            case .success(let addToBasketAnswer):
                if addToBasketAnswer.result == 1 {
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func takeBasket(completionHandler: @escaping ([Good]) -> Void) {
        
        requestFactoryToWorkWithBasket.takeBasket(idUser: user.id) { response in
            switch response.result {
            case .success(let TakeBasketAnswer):
                DispatchQueue.main.async {
                    completionHandler(TakeBasketAnswer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteGoodFromBasket(idGood:Int, quantity:Int) {
        
        requestFactoryToWorkWithBasket.deleteGoodFromBasket(idUser: user.id,
                                                            idGood: idGood,
                                                            quantity: quantity) { response in
            switch response.result {
            case .success(let deleteGood):
                print(deleteGood)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func payOrder(completionHandler: @escaping () -> Void) {
        requestFactoryToWorkWithBasket.payOrder(idUser: user.id) { response in
            switch response.result {
            case .success(let payOrder):
                if payOrder.result == 1 {
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
