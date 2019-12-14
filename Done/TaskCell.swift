//
//  TaskCell.swift
//  Done
//
//  Created by Christian Skorobogatow on 14/12/2019.
//  Copyright © 2019 Christian Skorobogatow. All rights reserved.
//

import UIKit

protocol ChangeButton {
    func changeButton(checked: Bool, index: Int)
    
}

class TaskCell: UITableViewCell {

    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    
    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
