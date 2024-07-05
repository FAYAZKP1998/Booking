//
//  BookingFinalVC.swift
//  Booking.com
//
//  Created by FAYAZ on 27/06/24.
//

import UIKit
import iOSDropDown

class BookingFinalVC: UIViewController {
    @IBOutlet weak var search_view: UIView!
    @IBOutlet weak var booking_view: UIView!
    @IBOutlet weak var checkin_date: UILabel!
    @IBOutlet weak var checkout_date: UILabel!
    @IBOutlet weak var room_num: UILabel!
    @IBOutlet weak var details_view: UIView!
    @IBOutlet weak var img_view: UIView!
    @IBOutlet weak var hotel_img: UIImageView!
    @IBOutlet weak var star_img: UIImageView!
    @IBOutlet weak var pay_btn: UIButton!
    @IBOutlet weak var hotel_name: UILabel!
    @IBOutlet weak var hotel_location: UILabel!
    @IBOutlet weak var hotel_price: UILabel!
    
    var array = NSArray()
    var dict1 = NSDictionary()
    var dict2 = NSDictionary()
    var bookingsuccess = false
    var urlimg = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search_view.layer.cornerRadius = search_view.frame.height/2
        search_view.layer.borderWidth = 1
        search_view.layer.borderColor = UIColor.systemGray5.cgColor
        
        booking_view.layer.cornerRadius = booking_view.frame.height/2
        checkin_date.text = UserDefaults.standard.string(forKey: "checkin")
        checkout_date.text = UserDefaults.standard.string(forKey: "checkout")
        room_num.text = "\(UserDefaults.standard.string(forKey: "roomnum") ?? "0") Room"
        hotel_name.text = String(describing: dict1["hname"]!)
        hotel_location.text = String(describing: dict1["hloc"]!)
        hotel_price.text = String(describing: dict1["hprice"]!)
        
        hotel_img.layer.cornerRadius = 8
        details_view.layer.cornerRadius = 8
        details_view.layer.borderWidth = 1
        details_view.layer.borderColor = UIColor.systemGray5.cgColor
        star_img.tintColor = .black
        pay_btn.tintColor = .black
        
        let image_url = String(describing: dict1["himage"]!)
        urlimg = image_url
        if let url = URL(string: image_url) {
            loadImage(from: url)
        }
    }
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
    

    @IBAction func PayNow(_ sender: Any) {
        
        let url = URL(string: "https://hotel.b4production.com/getandpostbookings")
        var urlreq = URLRequest(url: url!)
        urlreq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        urlreq.httpMethod = "post"
        
        let poststring = "hname=\(hotel_name.text!)&hostel_loc=\(hotel_location.text!)&hostel_price=\(hotel_price.text!)&checkin=\(checkin_date.text!)&checkout=\(checkout_date.text!)&hostel_image=\(self.urlimg)"
        
        
        urlreq.httpBody = poststring.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
            let mydata = data
            do{
                do{
                    self.dict2 = try JSONSerialization.jsonObject(with: mydata!,options: []) as! NSDictionary
                    
                    DispatchQueue.main.async(){
    
                        let alert = UIAlertController(title: "Success", message: "Successfully booked your room", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: {_ in 
                            let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hometab") as! HomeTab
                            next.modalPresentationStyle = .overFullScreen
                            self.present(next, animated: true)
                        }))
                        self.present(alert, animated: true)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }


}
