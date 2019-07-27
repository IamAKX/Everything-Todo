//
//  TodoModel.swift
//  Everything Todo
//
//  Created by Akash Giri on 27/07/19.
//  Copyright © 2019 Akash Giri. All rights reserved.
//

import Foundation

class TodoModel: NSObject, Codable {
//    func encode(with aDecoder: NSCoder) {
//        self.data = aDecoder.decodeObject(forKey: "data") as? String
//        self.isChecked = aDecoder.decodeObject(forKey: "isChecked") as? Bool
//    }
//
//    required init?(coder aCoder: NSCoder) {
//        aCoder.encode(data, forKey: "data")
//        aCoder.encode(isChecked, forKey: "isChecked")
//    }
//
    var data : String?
    var isChecked : Bool?
    
    init(data: String?, isChecked: Bool?) {
        self.data = data
        self.isChecked = isChecked
    }
}
