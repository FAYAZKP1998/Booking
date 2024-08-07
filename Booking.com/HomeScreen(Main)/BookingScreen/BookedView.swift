//
//  BookedView.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class BookedView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var array = NSArray()
    var dict = NSDictionary()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookedcell", for: indexPath) as! BookedTableViewCell
        if self.array != [String("default")]{
            self.dict = self.array[indexPath.row] as! NSDictionary
            
            let image_url = String(describing: self.dict["hostel_image"]!)
            if let url = URL(string: image_url) {
                cell.loadImage(from: url)
           }
            
            cell.hotelname.text = String(describing: self.dict["hname"]!)
            cell.hotelprice.text = String(describing: self.dict["hostel_price"]!)
            cell.hotellocation.text = String(describing: self.dict["hostel_loc"]!)
            cell.checkin_date.text = String(describing: self.dict["checkin"]!)
            cell.checkout_date.text = String(describing: self.dict["checkout"]!)
            return cell
        }else{
            cell.hotelname.text = "No bookings found"
            cell.hotelimg.isHidden = true
            cell.checkin_view.isHidden = true
            cell.hotellocation.isHidden = true
            cell.checkin_view.layer.isHidden = true
            cell.detail_view.layer.borderWidth = 0
            cell.hotelprice.isHidden = true
            cell.star_img.isHidden = true
            cell.ratings.isHidden = true
            cell.ratings1.isHidden = true
            return cell
        }
            

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    
    @IBOutlet weak var booked_table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       getvalue()
        booked_table.separatorStyle = .none
        booked_table.allowsSelection = false
        
       
    
        
        
    }
    
    func getvalue(){
        let url = URL(string: "https://hotel.b4production.com/getandpostbookings")
        let urlreq = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
            if let mydata = data{
                do{
                    
                    self.array = try JSONSerialization.jsonObject(with: mydata) as? NSArray ?? [String("default")]
                    do{
                        
                        DispatchQueue.main.async(){
                                self.booked_table.reloadData()
                            
                            
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
