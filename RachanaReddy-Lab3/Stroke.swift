//
//  Stroke.swift
//  RachanaReddy-Lab3
//
//  Created by Rachana Reddy on 10/12/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import Foundation
import UIKit

struct Stroke {
    var points: [CGPoint]
    var width: CGFloat
    var color: UIColor
    var alpha: CGFloat
    
    //constructor for accessing Stroke parameters
    init (points: [CGPoint], width: CGFloat, color: UIColor, alpha: CGFloat) {
        self.points = points
        self.width = width
        self.color = color
        self.alpha = alpha
       
    }
}

struct Count: Comparable {
    static func < (lhs: Count, rhs: Count) -> Bool {
        return lhs.count < rhs.count
    }
    
    var color: UIColor
    var count: Int
    
    init (color: UIColor, count: Int) {
        self.color = color
        self.count = count
       
    }

}
