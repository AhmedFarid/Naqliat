//
//  homeCell.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class homeCell: UITableViewCell {

    @IBOutlet weak var imageBtn: UIImageView!
    @IBOutlet weak var nameCat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBtn.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
}
