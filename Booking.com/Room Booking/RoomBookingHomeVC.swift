//
//  RoomBookingHomeVC.swift
//  Booking.com
//
//  Created by FAYAZ on 09/06/24.
//

import UIKit
import iOSDropDown
class RoomBookingHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var search_view: UIView!
    @IBOutlet weak var search_city: UITextField!
    @IBOutlet weak var booking_view: UIView!
    @IBOutlet weak var sort_dropdown: DropDown!
    @IBOutlet weak var filter_dropdown: DropDown!
    @IBOutlet weak var hotel_details: UITableView!
    var array = NSArray()
    var dict = NSDictionary()
    
    
    
    override func viewDidLoad() {
        getvalue()
        super.viewDidLoad()
        search_view.layer.cornerRadius = search_view.frame.height/2
        search_view.layer.borderWidth = 1
        search_view.layer.borderColor = UIColor.systemGray5.cgColor
        booking_view.layer.cornerRadius = booking_view.frame.height/2
        

        sort_dropdown.layer.borderColor = UIColor.black.cgColor
        sort_dropdown.layer.cornerRadius = sort_dropdown.frame.height/2
        sort_dropdown.layer.borderWidth = 1
        sort_dropdown.optionArray = ["Popularity","Price - Low to High","Price - High to Low"]
        sort_dropdown.arrowSize = 10
        sort_dropdown.arrowColor = .black
        
        filter_dropdown.layer.borderColor = UIColor.black.cgColor
        filter_dropdown.layer.cornerRadius = filter_dropdown.frame.height/2
        filter_dropdown.layer.borderWidth = 1
        filter_dropdown.optionArray = ["Popularity","Price - Low to High","Price - High to Low"]
        filter_dropdown.arrowSize = 10
        filter_dropdown.arrowColor = .black
        
        hotel_details.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.isNavigationBarHidden = false

        
    }
    


 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return array.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "roombookTV", for: indexPath) as! RoomBookingHomeTV
    
    self.dict = self.array[indexPath.row] as! NSDictionary
    
    let image_url = String(describing:self.dict["himage"]!)
    if let url = URL(string: image_url) {
                cell.loadImage(from: url)
            }
    
    
    cell.hotel_name.text = String(describing: self.dict["hname"]!)
    cell.hotel_price.text = String(describing: self.dict["hprice"]!)
    cell.hotel_location.text = String(describing: self.dict["hloc"]!)
    
    
    
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hoteldetails") as! HotelDetailsVC
        next.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    
    
    func getvalue(){
        let url = URL(string: "https://hotel.b4production.com/getandposthostel")
        let urlreq = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
            if let mydata = data{
                do{
                    self.array = try JSONSerialization.jsonObject(with: mydata,options: []) as! NSArray
                    do{
                        DispatchQueue.main.async(){
                            
         
                            self.hotel_details.reloadData()

                        
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
