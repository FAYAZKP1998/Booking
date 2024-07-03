//
//  BookedTableViewCell.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class BookedTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelimg: UIImageView!
    @IBOutlet weak var hotelname: UILabel!
    @IBOutlet weak var hotellocation: UILabel!
    @IBOutlet weak var hotelprice: UILabel!
    @IBOutlet weak var checkin_view: UIView!
    @IBOutlet weak var star_img: UIImageView!
    @IBOutlet weak var detail_view: UIView!
    @IBOutlet weak var checkin_date: UILabel!
    @IBOutlet weak var checkout_date: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var ratings1: UILabel!
    
    func loadImage(from url: URL) {
         URLSession.shared.dataTask(with: url){(data,response,error) in
             if let error = error {
                 print("Error loading image: \(error)")
                 return
             }

             guard let data = data, let image = UIImage(data: data) else {
                 print("Failed to load image data")
                 return
             }

             DispatchQueue.main.async {
                 self.hotelimg.image = image
             }
         }.resume()
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hotelimg.layer.cornerRadius = 10
        checkin_view.layer.cornerRadius = 10
        checkin_view.layer.borderWidth = 1
        checkin_view.layer.borderColor = UIColor.lightGray.cgColor
        detail_view.layer.borderWidth = 1
        detail_view.layer.borderColor = UIColor.lightGray.cgColor
        detail_view.layer.cornerRadius = 10
        star_img.tintColor = .black
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
