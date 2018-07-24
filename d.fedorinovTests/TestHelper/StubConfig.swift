import Alamofire
import OHHTTPStubs
@testable import d_fedorinov

/// Хелпер для конфигурации stub-а из библиотеки OHHTTPStubs
/// - parameter method: метод запроса
/// - parameter path: путь запроса
/// - parameter resourceName: имя stub-а
/// - parameter extensionType: тип stub-а
func stubConfig(method: HTTPMethod,
                path:String,
                resourceName:String,
                extensionType:String) {
    
    var condition = isMethodGET()
    switch method {
    case .post:
        condition = isMethodPOST()
    case .patch:
        condition = isMethodPATCH()
    case .delete:
        condition = isMethodDELETE()
    case .put:
        condition = isMethodPUT()
    default:
        break
    }
    
    stub(condition: condition && pathEndsWith(path)) { request in
        let fileUrl = Bundle.main.url(forResource: resourceName,
                                      withExtension: extensionType)!
        return OHHTTPStubsResponse(fileURL: fileUrl,
                                   statusCode: 200,
                                   headers: nil)
    }
}
