//
//  KeyStyleLabel.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/5/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import UIKit

class KeyStyleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.init(red: 26/255, green: 135/255, blue: 195/255, alpha: 1)
        self.font = UIFont.boldSystemFontOfSize(16)
    
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
