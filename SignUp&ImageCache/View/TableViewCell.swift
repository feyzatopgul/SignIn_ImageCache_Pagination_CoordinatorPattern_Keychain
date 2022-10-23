//
//  TableViewCell.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/16/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var loadedImage: UIImageView!
    
    var imageId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
