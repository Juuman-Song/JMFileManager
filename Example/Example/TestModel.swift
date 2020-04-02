//
//  TestModel.swift
//  Example
//
//  Created by Juuman on 2020/4/2.
//  Copyright © 2020 Juuman. All rights reserved.
//

import UIKit

class TestModel: NSObject , NSCoding{
    var isLogin : Bool = false
    var testStr : String? = nil
    
    override init() {
        super.init()
    }
    
    //decode
    required init?(coder aDeCoder: NSCoder){
        self.isLogin = aDeCoder.decodeBool(forKey: "isLogin")
        self.testStr = aDeCoder.decodeObject(forKey: "testStr") as? String
    }
    
    //encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isLogin, forKey: "isLogin")
        aCoder.encode(testStr, forKey: "testStr")
    }
}

