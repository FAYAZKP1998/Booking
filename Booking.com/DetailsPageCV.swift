//
//  DetailsPageCV.swift
//  Booking.com
//
//  Created by FAYAZ on 18/06/24.
//

import UIKit

class DetailsPageCV: UICollectionViewCell {
    @IBOutlet weak var collect_view: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var offer_view: UIView!
    @IBOutlet weak var fav_btn: UIButton!
    @IBOutlet weak var img_view: UIView!
    @IBOutlet weak var hotel_name: UILabel!
    @IBOutlet weak var hotel_location: UILabel!
    @IBOutlet weak var hotel_price: UILabel!
    
    func loadImage(from url:URL){
        URLSession.shared.dataTask(with: url){(data,response,error)in
            if let error = error{
                print("Error loading image: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else{
                print("Failed to load image data")
                return
            }
            DispatchQueue.main.async(){
                self.img.image = image
            }
        }
        .resume()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       img.layer.cornerRadius = 10
        fav_btn.tintColor = .white
    }
    
}
