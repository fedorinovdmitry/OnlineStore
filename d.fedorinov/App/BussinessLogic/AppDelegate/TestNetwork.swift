import Foundation

// вынесенная временная фигня для тестов бека
extension AppDelegate {
    
    func registration() {
        print("регистрируемся")
        requestFactoryToPersonalAccount.registration(user: user) { response in
            switch response.result {
            case .success(let registration):
                print(registration)
            case .failure(let error):
                print(error.localizedDescription)
            }
//            self.changeUserData()
        }
    }
    
    func changeUserData() {
        print("изменение данных")
        requestFactoryToPersonalAccount.changeUserData(user: user2) { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.authorithation()
        }
    }
    
    func authorithation() {
        print("авторизовываемся")
        requestFactoryToPersonalAccount.login(username: user2.username, password: user2.password) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.deautharization()
        }
    }
    
    func deautharization() {
        print("деавторизовываемся")
        requestFactoryToPersonalAccount.logOut(id: user.id) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.takeGood()
        }
        
    }
    
    func takeGood() {
        print("получаем товар")
        requestFactoryToWorkWithGoods.takeGood(id: 102) { response in
            switch response.result {
            case .success(let good):
                print(good)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.takeCatalogOfGoods()
        }
    }
    func takeCatalogOfGoods() {
        print("получаем каталог товаров")
        requestFactoryToWorkWithGoods.takeCatalogDataOfGoods() { response in
            switch response.result {
            case .success(let catalog):
                print(catalog)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.addReview()
        }
        
    }
    func addReview() {
        print("добавляем новый отзыв")
        requestFactoryToWorkWithProductReviews.addReview(review: review) { response in
            switch response.result {
            case .success(let addReviewResult):
                print(addReviewResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.takeListOfGoodsReview()
        }
    }
    func takeListOfGoodsReview() {
        print("получаем отзывы о товаре")
        requestFactoryToWorkWithProductReviews.takeGoodsReview(idGood: review.idGood) { response in
            switch response.result {
            case .success(let listOfGoodsReview):
                print(listOfGoodsReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.deleteReview()
        }
    }
    func deleteReview() {
        print("удаляем отзыв")
        requestFactoryToWorkWithProductReviews.deleteReview(review: review) { response in
            switch response.result {
            case .success(let deleteReviewResult):
                print(deleteReviewResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.addGoodToBasket()
        }
    }
    func addGoodToBasket() {
        print("добавляем товар в корзину")
        requestFactoryToWorkWithBasket.addGoodToBasket(idUser: 123,
                                                       idGood: 110,
                                                       quantity: 2) { response in
            switch response.result {
            case .success(let addGoodToBasketResult):
                print(addGoodToBasketResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.addGoodToBasket2()
        }
        
    }
    func addGoodToBasket2() {
        print("добавляем товар2 в корзину")
        requestFactoryToWorkWithBasket.addGoodToBasket(idUser: 123,
                                                       idGood: 106,
                                                       quantity: 2) { response in
            switch response.result {
            case .success(let addGoodToBasketResult):
                print(addGoodToBasketResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.deleteGoodFromBasket()
        }
    }
    func deleteGoodFromBasket() {
        print("удаляем товар из корзины")
        requestFactoryToWorkWithBasket.deleteGoodFromBasket(idUser: 123,
                                                            idGood: 106,
                                                            quantity: 2){ response in
            switch response.result {
            case .success(let deleteGoodFromBasketResult):
                print(deleteGoodFromBasketResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.payOrder()
        }
    }
    func payOrder() {
        print("оплачиваем заказ")
        requestFactoryToWorkWithBasket.payOrder(idUser: 123) { response in
            switch response.result {
            case .success(let payOrderResult):
                print(payOrderResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
