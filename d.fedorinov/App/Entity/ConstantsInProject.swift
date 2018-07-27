import Foundation

/** Хранит урлы к по запросам к API */
struct APPURL {
    static let baseUrlToAPI = "http://127.0.0.1:8080/"
    
    static let wayToLoginAPI = "login"
    static let wayToLogOutAPI = "logout"
    static let wayToRegisterAPI = "register"
    static let wayToChangeUserDataAPI = "changeUserData"
    static let wayToTakeUserID = "giveUserID"
    
    static let wayToGetCatalogOfGoods = "catalogData"
    static let wayToGetGoodById = "getGoodById"
    
    static let wayToAddReview = "addReview"
    static let wayToDeleteReview = "deleteReview"
    static let wayToGetListOfGoodsReview = "listOfGoodsReview"
    
    static let wayToAddGoodInBasket = "addGoodToBasket"
    static let wayToDeleteGoodFromBasket = "deleteGoodFromBasket"
    static let wayToPayOrder = "payOrder"
    
}
