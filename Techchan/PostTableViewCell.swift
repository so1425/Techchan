//
//  PostTableViewCell.swift
//  Techchan
//
//  Created by so1425 on 2018/09/24.
//  Copyright © 2018年 so1425. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var post: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
