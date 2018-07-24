import Foundation

/** Логика ответа с сервера по запросу получения списка отзывов о товаре, содержаший статус ответа и массив отзывов */
struct ResultOfGoodsReviews: Codable {
    let result: Int
    let reviews: [Review]
}
