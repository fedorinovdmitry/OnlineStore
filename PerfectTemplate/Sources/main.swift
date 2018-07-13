//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer



let server = HTTPServer()
let workWithPersonalAccountController = WorkWithPersonalAccountController()
let workWithGoodsController = WorkWithGoodsController()
var routes = Routes()

routes.add(method: .post, uri: "/register", handler: workWithPersonalAccountController.register)
routes.add(method: .post, uri: "/login", handler: workWithPersonalAccountController.login)
routes.add(method: .get, uri: "/logout", handler: workWithPersonalAccountController.logout)
routes.add(method: .post, uri: "/changeUserData", handler: workWithPersonalAccountController.changeUserData)

routes.add(method: .get, uri: "/getGoodById", handler: workWithGoodsController.giveGood)
routes.add(method: .get, uri: "/catalogData", handler: workWithGoodsController.giveCatalogOfGoods)

server.addRoutes(routes)
server.serverPort = 8080


func addRoutesworkWithPersonalAccountController(){
    
    
}
func addRoutesworkWithGoodsController(){
    
}



do {
	// Launch the servers based on the configuration data.
	try server.start()
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

