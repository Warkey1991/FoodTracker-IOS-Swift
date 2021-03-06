//
//  Meal.swift
//  FoodTracker
//
//  Created by songyuanjin on 2018/12/7.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
import os.log

open class Meal: NSObject, NSCoding {
  
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int = 0
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    //Mark: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialzation
    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5)  else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
    
   
}
