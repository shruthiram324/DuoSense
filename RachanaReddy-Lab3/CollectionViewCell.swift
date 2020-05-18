//
//  CollectionViewCell.swift
//
//  Created by Giorgio Guttilla on 10/16/19.
//  Copyright © 2019 Giorgio Guttilla. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    var controller: UINavigationController!
    var collection: CollectionViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        let boxView = UIView(frame: CGRect(x:0, y: imageView.frame.maxY * 0.75, width: imageView.frame.size.width, height: frame.size.height * 0.25))
        boxView.backgroundColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        contentView.addSubview(boxView)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: boxView.frame.origin.y, width: frame.size.width * 0.9, height: frame.size.height * 0.25))
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        contentView.addSubview(textLabel)
        
        
//        let editButton = UIButton()
//        editButton.setTitle("Edit", for: .normal)
//
//        editButton.setTitleColor(UIColor.blue, for: .normal)
//        editButton.titleLabel?.textAlignment = .center
//        editButton.backgroundColor = UIColor.white
//        editButton.frame = CGRect(x: 0, y: 0, width: frame.size.width / 4, height: frame.size.height / 8)
//        editButton.clipsToBounds = true
//
//        editButton.addTarget(self, action: #selector(edit(_:)), for: .touchUpInside)
//        contentView.addSubview(editButton)
        
        
        let deleteButton = UIButton()
        deleteButton.setTitle("X", for: .normal)
        
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.backgroundColor = UIColor.white
        deleteButton.frame = CGRect(x: frame.size.width - (frame.size.width / 4), y: 0, width: frame.size.width / 4, height: frame.size.height / 8)
        deleteButton.clipsToBounds = true
        
        deleteButton.addTarget(self, action: #selector(deleteDrawing(_:)), for: .touchUpInside)
        contentView.addSubview(deleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func deleteDrawing(_ sender: UIButton){
        print("delete")
        
        DeleteDrawing(title: textLabel.text!)
        
        collection.refreshDrawings()
    }
    
//    @objc func edit(_ sender: UIButton){
//        print("edit")
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let drawingView = storyboard.instantiateViewController(withIdentifier: "drawingView") as! ViewController
//
//        print(drawingView)
//
//        drawingView.inTitle = textLabel.text
//        drawingView.inImage = imageView.image
//
//        controller.pushViewController(drawingView, animated: true)
//
//
////        self.backgroundView?.window?.rootViewController?.navigationController?.pushViewController(drawingView, animated: true)
//    }
    
}
