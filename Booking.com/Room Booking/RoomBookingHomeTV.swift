//
//  RoomBookingHomeTV.swift
//  Booking.com
//
//  Created by FAYAZ on 14/06/24.
//

import UIKit

class RoomBookingHomeTV: UITableViewCell {
    @IBOutlet weak var img_view: UIView!
    @IBOutlet weak var hotel_img: UIImageView!
    @IBOutlet weak var details_view: UIView!
    @IBOutlet weak var star_img: UIImageView!
    @IBOutlet weak var hotel_name: UILabel!
    @IBOutlet weak var hotel_location: UILabel!
    @IBOutlet weak var hotel_price: UILabel!
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
                 self.hotel_img.image = image
             }
         }.resume()
     }
    override func awakeFromNib() {
        super.awakeFromNib()
        hotel_img.layer.cornerRadius = 8
        details_view.layer.cornerRadius = 8
        details_view.layer.borderWidth = 1
        details_view.layer.borderColor = UIColor.systemGray5.cgColor
        star_img.tintColor = .black
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
