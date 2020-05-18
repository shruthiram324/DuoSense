//
//  DrawingView.swift
//  RachanaReddy-Lab3
//
//  Created by Rachana Reddy on 10/12/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import UIKit

class DrawingView : UIView {
    
    var currentStroke:Stroke? {
        didSet {
            setNeedsDisplay() //notifies system that view's contents need to be redrawn
        }
    }
    
    var strokesInView:[Stroke] = [] { //creates an array to store Strokes
        didSet {
            setNeedsDisplay() //notifies system that view's contents need to be redrawn
        }
    } 
    
    
    //inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    //main drawing function
    override func draw(_ rect: CGRect) {
        for stroke in strokesInView { //iterates through all strokes in drawing view
            let path = createQuadPath(points: stroke.points)
            stroke.color.setStroke() //UIColor function to set stroke color
            path.lineCapStyle = .round //make line cap round
            path.lineWidth = stroke.width //set line width
            path.stroke(with: CGBlendMode.normal, alpha: stroke.alpha) //sets alpha val
        }
    }
    
    //midpoint helper function
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let x = (first.x + second.x)/2 //find average of x coordinates
        let y = (first.y + second.y)/2 //find average of y coordinates
        return CGPoint(x: x, y: y) //returns a new point
    }
    
    //a function which takes in an array of CGPoints, and returns a smooth UIBezierPath
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath() //Create the path object
        if(points.count < 2){ //There are no points to add to this path
            return path
        }
        path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
            let firstMidpoint = midpoint(first: path.currentPoint, second:
                points[i]) //Get midpoint between the path's last point and the next one in the array
            let secondMidpoint = midpoint(first: points[i], second:
                points[i+1]) //Get midpoint between the next point in the array and the one after it
            path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint,
                          controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
        }
        return path
    }
    
}
