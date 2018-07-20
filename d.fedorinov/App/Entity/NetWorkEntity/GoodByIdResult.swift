import Foundation

/** Логика ответа с сервера по запросу получения конкретного товара по ид, содержаший статус ответа и сам товар */
struct GoodByIdResponse: Codable {
    let result: Int
    let good: Good?
}
