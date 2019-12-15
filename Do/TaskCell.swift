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
    
    @IBAction func setReminder(_ sender: Any) {
       func alertWithTF() {
           //Step : 1
           let alert = UIAlertController(title: "Reminder", message: "Please input something", preferredStyle: UIAlertController.Style.alert )
           //Step : 2
           let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
               let textField = alert.textFields![0] as UITextField
               let textField2 = alert.textFields![1] as UITextField
               if textField.text != "" {
                   //Read TextFields text data
                   print(textField.text!)
                   print("TF 1 : \(textField.text!)")
               } else {
                   print("TF 1 is Empty...")
               }

               if textField2.text != "" {
                   print(textField2.text!)
                   print("TF 2 : \(textField2.text!)")
               } else {
                   print("TF 2 is Empty...")
               }
           }

           //Step : 3
           //For first TF
           alert.addTextField { (textField) in
               textField.placeholder = "Enter your first name"
               textField.textColor = .red
           }
           //For second TF
           alert.addTextField { (textField) in
               textField.placeholder = "Enter your last name"
               textField.textColor = .blue
           }

           //Step : 4
           alert.addAction(save)
           //Cancel action
           let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
           alert.addAction(cancel)
           //OR single line action
           //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })

           self.ce(alert, animated:true, completion: nil)
       }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)


    }
    
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
