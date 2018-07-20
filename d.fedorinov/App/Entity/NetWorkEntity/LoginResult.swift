import Foundation

/** Логика ответа с сервера по запросу авторизации, содержаший статус ответа данные пользователя и токен */
struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
}
