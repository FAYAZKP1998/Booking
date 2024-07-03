//
//  Bookings.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class Bookings: UIViewController {

    
    @IBOutlet weak var segment_controller: UISegmentedControl!
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var bookedview: UIView!
    @IBOutlet weak var historyview: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyview.isHidden = true
        segment_controller.layer.cornerRadius = 0
        segment_controller.layer.masksToBounds = false
        segment_controller.addUnderlineForSelectedSegment()
    }

    
    
    @IBAction func segment_changed(_ sender: UISegmentedControl) {
        
        sender.changeUnderlinePosition()
    
        
        
        switch sender.selectedSegmentIndex {
        case 0:
            bookedview.isHidden = false
            historyview.isHidden = true
            
        
        case 1:
            bookedview.isHidden = true
            historyview.isHidden = false
            
        default:
            break
        }
  

    }


}
