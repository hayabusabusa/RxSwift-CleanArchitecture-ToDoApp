//
//  HomeTableViewCell.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkButton: SYCheckMarkButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ model: ToDoViewModel) {
        titleLabel.text = model.title
        checkMarkButton.setCheckState(model.state ? .checked : .unchecked)
    }
}
