//
//  ProfileTableView.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class ProfileTableView: UITableViewCell {
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var profilename: UILabel!
    @IBOutlet weak var profile_no: UILabel!
    @IBOutlet weak var details_view: UIView!
    @IBOutlet weak var lbl_details: UILabel!
    @IBOutlet weak var img_details: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
