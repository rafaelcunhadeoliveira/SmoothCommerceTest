//
//  FeedTableViewCell.swift
//  SmoothCommerceTest
//
//  Created by Rafael Cunha de Oliveira on 2020-07-17.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var videoUrl = ""
    var url = ""
    var delegate: ClickDelegate?
    
    func setUp(name: String,
               urlSite: String,
               image: UIImage?,
               videoUrlStrig: String,
               delegate: ClickDelegate) {
        userImageView.image = image ?? UIImage()
        nameLabel.text = name
        url = urlSite
        videoUrl = videoUrlStrig
        self.delegate = delegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func urlButtonPressed(_ sender: Any) {
        delegate?.handle(.url, url: url)
    }

    @IBAction func videoButtonPressed(_ sender: Any) {
        delegate?.handle(.video, url: videoUrl)
    }
}
