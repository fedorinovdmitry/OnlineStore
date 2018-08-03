import XCTest

class d_fedorinovUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    //запускать поочередно
    func testRegistration() {

        app/*@START_MENU_TOKEN@*/.buttons["Registration"]/*[[".scrollViews.buttons[\"Registration\"]",".buttons[\"Registration\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let textFieldLogin = elementsQuery.children(matching: .textField).element(boundBy: 0)
        let textFieldRegister = elementsQuery.children(matching: .textField).element(boundBy: 1)
        
        textFieldLogin.tap()
        textFieldLogin.typeText("admin")
        
        textFieldRegister.tap()
        textFieldRegister.typeText("admin")

        scrollViewsQuery.otherElements.containing(.button, identifier:"<-login").element.swipeUp()
        elementsQuery.buttons["Registration"].tap()
        
        let textFieldLoginMain = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
        let textFieldRegisterMain = scrollViewsQuery.children(matching: .textField).element(boundBy: 1)
        
        textFieldLoginMain.tap()
        textFieldLoginMain.typeText("admin")
        
        textFieldRegisterMain.tap()
        textFieldRegisterMain.typeText("admin")
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.staticText, identifier:"OnlineStore").element/*[[".scrollViews.containing(.button, identifier:\"Registration\").element",".scrollViews.containing(.button, identifier:\"GO\").element",".scrollViews.containing(.staticText, identifier:\"Password\").element",".scrollViews.containing(.staticText, identifier:\"Login\").element",".scrollViews.containing(.staticText, identifier:\"OnlineStore\").element"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["GO"]/*[[".scrollViews.buttons[\"GO\"]",".buttons[\"GO\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
      
    }
    
    func testAddGood() {
        
        let app = XCUIApplication()
        app.buttons["List of goods"].tap()
        
        let tablesQuery = app.tables
        let button = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"tovar101")/*[[".cells.containing(.staticText, identifier:\"57\")",".cells.containing(.staticText, identifier:\"tovar101\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element
        button.tap()
        
        let okButton = app.alerts["Added"].buttons["OK"]
        okButton.tap()
        button.tap()
        okButton.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"tovar104")/*[[".cells.containing(.staticText, identifier:\"43\")",".cells.containing(.staticText, identifier:\"tovar104\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        okButton.tap()
        app.navigationBars["d_fedorinov.ListOfGoodsTableView"].buttons["Back"].tap()
        app.buttons["Basket"].tap()
        

    }
    
    func testDeleteGoodAndPayOrder() {
        
        let app = XCUIApplication()
        app.buttons["Basket"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"tovar101")/*[[".cells.containing(.staticText, identifier:\"4\")",".cells.containing(.staticText, identifier:\"tovar101\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["1001"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Pay Order"]/*[[".cells.buttons[\"Pay Order\"]",".buttons[\"Pay Order\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Payed"].buttons["OK"].tap()
        
        
        
    }
    
}
