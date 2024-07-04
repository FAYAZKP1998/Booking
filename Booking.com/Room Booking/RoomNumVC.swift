//
//  RoomNumVC.swift
//  Booking.com
//
//  Created by FAYAZ on 27/06/24.
//

import UIKit

class RoomNumVC: UIViewController {
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var room_num: UILabel!
    var count = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_plus.tintColor = .black
        btn_minus.tintColor = .black
        if count == 1{
            UserDefaults.standard.setValue(count, forKey: "roomnum")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Add_room(_ sender: Any) {
        
    }
    

    @IBAction func Add(_ sender: Any) {
            count += 1
            room_num.text = String(count)
            UserDefaults.standard.setValue(count, forKey: "roomnum")
    }
    @IBAction func Sub(_ sender: Any) {
        if count > 1 {
            count -= 1
            room_num.text = String(count)
            UserDefaults.standard.setValue(count, forKey: "roomnum")
        }else{
            room_num.text = "1"
        }
    }
}
