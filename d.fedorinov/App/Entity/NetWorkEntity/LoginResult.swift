import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
}
