//
//  PostsCell.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import UIKit

class PostsCell: UITableViewCell {
    
    var button: (() -> ())?
    
    @IBOutlet weak var textHeight: NSLayoutConstraint!
    @IBOutlet weak var but: UIButton!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postPreview: UILabel!
    @IBOutlet weak var postName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postName.numberOfLines = 2
        postPreview.numberOfLines = 2
        but.titleLabel?.text = "Expand"
        but.backgroundColor = .lightGray
        but.layer.cornerRadius = 15
        but.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if postPreview.text!.count >= 100{
            but.isHidden = false
        }else if postPreview.text!.count < 100{
            but.isHidden = true
        }
    }
    
    @IBAction func expandPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.button?()
//            if self.postPreview.numberOfLines == 2{
//                self.but.titleLabel?.text = "Collapse"
//                self.textHeight.constant = 200
//                self.postPreview.numberOfLines = 0
//            }else{
//                self.but.titleLabel?.text = "Expand"
//                print(self.but.titleLabel?.text)
//                self.textHeight.constant = 60
//                self.postPreview.numberOfLines = 2
//            }
        }
    }
}


