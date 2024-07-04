//
//  HotelDetailsVC.swift
//  Booking.com
//
//  Created by FAYAZ on 14/06/24.
//

import UIKit

class HotelDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailscollection", for: indexPath) as! DetailsPageCV
        cell.img_view.layer.cornerRadius = 10
        cell.fav_btn.tintColor = .white
        cell.offer_view.layer.cornerRadius = cell.offer_view.frame.height/2
        self.dict = self.array[indexPath.row] as! NSDictionary
        
        let image_url = String(describing: self.dict["himage"]!)
        if let url = URL(string: image_url){
            cell.loadImage(from: url)
        }
        cell.hotel_name.text = String(describing: self.dict["hname"]!)
        cell.hotel_price.text = String(describing: self.dict["hprice"]!)
        cell.hotel_location.text = String(describing: self.dict["hloc"]!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hoteldetails") as! HotelDetailsVC
        self.navigationController?.pushViewController(next, animated: true)
        next.dict = self.array[indexPath.row] as! NSDictionary
    }
    
    @IBOutlet weak var Img_view: UIView!
    @IBOutlet weak var hotel_img: UIImageView!
    @IBOutlet weak var fav_btn: UIButton!
    @IBOutlet weak var share_btn: UIButton!
    @IBOutlet weak var location_view: UIView!
    @IBOutlet weak var about_view: UIView!
    @IBOutlet weak var ratings_view: UIView!
    @IBOutlet weak var starrating_view: UIView!
    @IBOutlet weak var review_view: UIView!
    @IBOutlet weak var map_btn: UIButton!
    @IBOutlet weak var booknow_btn: UIButton!
    @IBOutlet weak var review_img1: UIImageView!
    @IBOutlet weak var review_img2: UIImageView!
    @IBOutlet weak var rating_view1: UIView!
    @IBOutlet weak var rating_view2: UIView!
    @IBOutlet weak var hotel_name: UILabel!
    @IBOutlet weak var hotel_price: UILabel!
    @IBOutlet weak var hotel_location: UILabel!
    @IBOutlet weak var collect_view: UICollectionView!
    
    var array = NSArray()
    var dict = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getvalue()
        UserDefaults.standard.setValue(self.dict, forKey: "selected_hotel")
        location_view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        location_view.layer.borderWidth = 1
        ratings_view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        ratings_view.layer.borderWidth = 1
        map_btn.tintColor = .black
        booknow_btn.tintColor = .black
        fav_btn.tintColor = .white
        share_btn.tintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.isNavigationBarHidden = false
        
        review_img1.layer.cornerRadius = review_img1.frame.height/2
        rating_view1.layer.cornerRadius = rating_view1.frame.height/2
        
        review_img2.layer.cornerRadius = review_img2.frame.height/2
        rating_view2.layer.cornerRadius = rating_view2.frame.height/2
        
        hotel_name.text = String(describing: dict["hname"]!)
        hotel_location.text = String(describing: dict["hloc"]!)
        hotel_price.text = String(describing: dict["hprice"]!)
        
        let image_url = String(describing: dict["himage"]!)
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
    
    
    
    @IBAction func Book_now(_ sender: Any) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectroom") as! RoomSelectVC
        self.navigationController?.pushViewController(next, animated: true)
        
        
        
        
    }
    
    func getvalue(){
        let url = URL(string: "https://hotel.b4production.com/getandposthostel")
        let urlreq = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
            if let mydata = data{
                do{
                    self.array = try JSONSerialization.jsonObject(with: mydata, options: []) as! NSArray
                    do{
                        DispatchQueue.main.async(){
                            self.collect_view.reloadData()
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    

    

}
