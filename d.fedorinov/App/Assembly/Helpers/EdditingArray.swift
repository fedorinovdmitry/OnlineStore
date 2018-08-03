import Foundation

///helper для работы с массивами
class EdditingArray {
    
    static func deleteElementFromArray<T: Equatable>(element:T, arrOfElement:[T]) -> [T] {
        var arrOfElement = arrOfElement
        if let index = arrOfElement.index(of: element){
            arrOfElement.remove(at: index)
        }
        return arrOfElement
    }
    
    static func chageElementsInArray<T: Equatable>(elementDeleting:T,elementAdding:T, arrOfElement:[T]) -> [T] {
        var arrOfElement = arrOfElement
        if let index = arrOfElement.index(of: elementDeleting){
            arrOfElement.remove(at: index)
            arrOfElement.insert(elementAdding, at: index)
        }
        return arrOfElement
    }
    
}
