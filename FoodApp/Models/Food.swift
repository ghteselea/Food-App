//
//  Food.swift
//  FoodApp
//
//  Created by Alexandra Radu on 12.05.2021.
//

import Foundation

struct Food: Codable {
    var extra: [String]
    var id: Int
    var url: String
    var ingrediens: [String]
    var name: String
    var price: Double
    var type: String
    
//    init(dictionary: [String: Any]) {
//        self.extra = dictionary["extra"] as? [String] ?? []
//        self.id = dictionary["id"] as? Int ?? -1
//        self.url = dictionary["url"] as? String ?? ""
//        self.ingrediens = dictionary["ingrediens"] as? [String] ?? []
//        self.name = dictionary["name"] as? String ?? ""
//        self.price = dictionary["price"] as? Double ?? 0.0
//        self.type = dictionary["type"] as? String ?? ""
//    }
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Food.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    init(foodEntity: FoodEntity) {
        self.id = Int(foodEntity.id)
        self.extra = foodEntity.extra ?? []
        self.ingrediens = foodEntity.ingredients ?? []
        self.name = foodEntity.name ?? ""
        self.price = foodEntity.price
        self.type = foodEntity.type ?? ""
        self.url = foodEntity.url ?? ""
    }
}
