//
//  Storage.swift
//  RachanaReddy-Lab3
//
//  Created by Giorgio Guttilla on 11/25/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public struct UserDrawing {
    var image: UIImage
    var title: String
}

public func SaveImage(image: UIImage, title: String) -> Bool {
    
    let imagePNG = image.pngData()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let context = appDelegate.persistentContainer.viewContext

    let entity = NSEntityDescription.entity(forEntityName: "Drawing", in: context)
    let newDrawing = NSManagedObject(entity: entity!, insertInto: context)

    newDrawing.setValue(imagePNG, forKey: "image")
    newDrawing.setValue(title, forKey: "title")

    do {
        try context.save()
        print("Success")
        return true
    } catch {
        print("Failed saving")
        return false
    }

}



public func DeleteDrawing(title: String) -> Bool {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Drawing")
    
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            
            let thisTitle = data.value(forKey: "title") as! String
            
            if(thisTitle == title){
                
                context.delete(data)
                return true
                
            }
            
        }
        
    } catch {
        
        print("Failed")
    }
    
    return false
}



public func FindDrawing(title: String) -> UserDrawing? {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Drawing")
    
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            
            let thisTitle = data.value(forKey: "title") as! String
            
            if(thisTitle == title){
                
                guard let image = UIImage(data: data.value(forKey: "image") as! Data) else { continue }
                
                return UserDrawing(image: image, title: thisTitle)
                
            }
            
        }
        
    } catch {
        
        print("Failed")
    }
    
    return nil
}
public func LoadAllDrawings() -> [UserDrawing] {
    
    var DrawingList: [UserDrawing] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Drawing")
    do {
        let fetchedResults = try context.fetch(fetchRequest)
        for item in fetchedResults {
            guard let image = UIImage(data: (item as AnyObject).value(forKey: "image") as! Data) else { return DrawingList }
            
            let title: String = (item as AnyObject).value(forKey: "title" ) as! String
            
            DrawingList.append(UserDrawing(image: image, title: title))
            
        }
        
        return DrawingList
        
    } catch let error as NSError {
        // something went wrong, print the error.
        print(error.description)
        
        return DrawingList
    }
    
}
