import Foundation

/** Логика стандартного ответа с сервера содержаший статус ответа и комментарии */
struct StaticAPIResult: Codable {
    let result: Int
    let userMessage: String
}
