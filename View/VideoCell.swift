//
//  VideoCell.swift
//  YoutubeApp1
//
//  Created by 大内晴貴 on 2021/01/26.
//

import UIKit
import SDWebImage

class VideoCell: UITableViewCell {

    @IBOutlet weak var thumnaillimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
