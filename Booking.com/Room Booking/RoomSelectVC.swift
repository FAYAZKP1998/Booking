//
//  RoomSelectVC.swift
//  Booking.com
//
//  Created by FAYAZ on 09/06/24.
//

import UIKit

class RoomSelectVC: UIViewController {
    @IBOutlet weak var select_sgmnt: UISegmentedControl!
    @IBOutlet weak var booking_view: UIView!
    @IBOutlet weak var checkin_date: UILabel!
    @IBOutlet weak var checkout_date: UILabel!
    @IBOutlet weak var room_no: UILabel!
    @IBOutlet weak var date_view: UIView!
    @IBOutlet weak var date_picker: UIDatePicker!
    @IBOutlet weak var adddate_btn: UIButton!
    @IBOutlet weak var datetxt: UILabel!
    
    @IBOutlet weak var addroom_btn: UIButton!
    @IBOutlet weak var room_view: UIView!
    @IBOutlet weak var Apply_btn: UIButton!
    
    
    var selected_hotel = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        select_sgmnt.selectedSegmentIndex = 0
        select_sgmnt.addUnderlineForSelectedSegment()
        select_sgmnt.layer.masksToBounds = false
        
        booking_view.layer.cornerRadius = 10
        booking_view.layer.borderWidth = 1
        booking_view.layer.borderColor = UIColor.black.cgColor
        
        checkin_date.text = ""
        checkout_date.text = ""
        room_no.text = "0 Room"
        adddate_btn.tintColor = .black
        room_view.isHidden = true
        date_picker.tintColor = .systemOrange
        
        Apply_btn.tintColor = .black
        Apply_btn.isHidden = true
        adddate_btn.isHidden = false
        addroom_btn.isHidden = true
        addroom_btn.layer.borderWidth = 1
        addroom_btn.layer.borderColor = UIColor.black.cgColor
        addroom_btn.layer.cornerRadius = addroom_btn.frame.height/2
        addroom_btn.tintColor = .black
        selected_hotel = UserDefaults.standard.dictionary(forKey: "selected")! as NSDictionary
    
        
        
        
    }
    @IBAction func date_selected(_ sender: Any) {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        if select_sgmnt.selectedSegmentIndex == 0{
            UserDefaults.standard.setValue(date.string(from: date_picker.date), forKey: "checkindate")
        }else if select_sgmnt.selectedSegmentIndex == 1{
            UserDefaults.standard.setValue(date.string(from: date_picker.date), forKey: "checkoutdate")

        }
    }
    @IBAction func SegmentView_select(_ sender: UISegmentedControl) {
        sender.changeUnderlinePosition()
        switch sender.selectedSegmentIndex{
        case 0:adddate_btn.isHidden = false
            date_view.isHidden = false
            room_view.isHidden = true
            Apply_btn.isHidden = true
            adddate_btn.isHidden = false
            addroom_btn.isHidden = true
        case 1:
            adddate_btn.isHidden = false
            date_view.isHidden = false
            room_view.isHidden = true
            Apply_btn.isHidden = true
            adddate_btn.isHidden = false
            addroom_btn.isHidden = true
        case 2:adddate_btn.isHidden = true
            date_view.isHidden = true
            room_view.isHidden = false
            Apply_btn.isHidden = true
            adddate_btn.isHidden = true
            addroom_btn.isHidden = false
        default:break
        }
    }

    @IBAction func Add_date(_ sender: UIButton) {
           
            switch select_sgmnt.selectedSegmentIndex{
                
            case 0:checkin_date.text = UserDefaults.standard.string(forKey: "checkindate")
                select_sgmnt.selectedSegmentIndex = 1
                select_sgmnt.changeUnderlinePosition()
                    adddate_btn.isHidden = false
                    date_view.isHidden = false
                    room_view.isHidden = true
                    Apply_btn.isHidden = true
                    adddate_btn.isHidden = false
            case 1:checkout_date.text = UserDefaults.standard.string(forKey: "checkoutdate")
                select_sgmnt.selectedSegmentIndex = 2
                select_sgmnt.changeUnderlinePosition()
                    adddate_btn.isHidden = true
                    date_view.isHidden = true
                    room_view.isHidden = false
                    Apply_btn.isHidden = true
                    adddate_btn.isHidden = true
                    addroom_btn.isHidden = false
            case 2:print("")
            default:break
            }
        
    }
    
    @IBAction func Add_room(_ sender: Any) {
        room_no.text = "\(UserDefaults.standard.string(forKey: "roomnum") ?? "0") Room"
        Apply_btn.isHidden = false
        
    }
    
    @IBAction func Apply(_ sender: Any) {

            let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bookingfinal") as! BookingFinalVC
            self.navigationController?.pushViewController(next, animated: true)
            next.dict1 = selected_hotel
        
    }
    
    

}
