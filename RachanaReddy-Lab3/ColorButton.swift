//
//  ColorButton.swift
//  RachanaReddy-Lab3
//
//  Created by Rachana Reddy on 10/12/19.
//  Copyright © 2019 Rachana Reddy. All rights reserved.
//

import Foundation
import UIKit

class ColorButton : UIButton {
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        //round the corners
        if (self.layer.frame.width <= self.layer.frame.height){
            self.layer.cornerRadius = self.layer.frame.width/2
        } else {
            self.layer.cornerRadius = self.layer.frame.height/2
        }
    }
}
