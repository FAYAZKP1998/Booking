//
//  Home.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit
import  iOSDropDown
class Home: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homecollection", for: indexPath) as! HomePageCollectionView
        cell.img_view.layer.cornerRadius = 10
        cell.fav_btn.tintColor = .white
        cell.offer_view.layer.cornerRadius = cell.offer_view.frame.height/2
        
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hoteldetails") as! HotelDetailsVC
        next.dict = array[indexPath.row] as! NSDictionary

        
        next.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        hello_user.text = "Hello, \(UserDefaults.standard.string(forKey: "username")!)!👋"
        //print(UserDefaults.standard.string(forKey: "username")!)
        //print(UserDefaults.standard.string(forKey: "phone")!)
    }
    
    
    @IBOutlet weak var com_view: UIView!
    @IBOutlet weak var location_view: UIView!
    @IBOutlet weak var searchdetail_view: UIView!
    @IBOutlet weak var home_collectioview: UICollectionView!
    @IBOutlet weak var search_dropdown: DropDown!
    @IBOutlet weak var hello_user: UILabel!
    
    var array = NSArray()
    var dict = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getvalue()
        
        self.navigationController?.isNavigationBarHidden = true
        hello_user.text = "Hello, User! 👋"
        
        
        com_view.layer.cornerRadius = com_view.frame.height/2
        
        search_dropdown.optionArray = ["Kochi","Angamaly","Thrissur","Kannur"]
        search_dropdown.selectedRowColor = .lightGray
        search_dropdown.arrowSize = 10
        search_dropdown.arrowColor = .black
        
        
        location_view.backgroundColor = UIColor.systemGray5
        location_view.layer.cornerRadius = location_view.frame.height/2
        searchdetail_view.layer.cornerRadius = searchdetail_view.frame.height/2
        searchdetail_view.layer.borderWidth = 1
        searchdetail_view.layer.borderColor = UIColor.systemGray5.cgColor
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tap))
        searchdetail_view.addGestureRecognizer(tapped)
        
        
    }
    @objc func tap(sender:UITapGestureRecognizer){
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bookhome") as! RoomBookingHomeVC
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
                            
                            
                            self.home_collectioview.reloadData()
                            
                        
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
