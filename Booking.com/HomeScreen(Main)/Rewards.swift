//
//  Rewards.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class Rewards: UIViewController {

    @IBOutlet weak var step1: UIView!
    @IBOutlet weak var step2: UIView!
    @IBOutlet weak var refer_btn: UIButton!
    override func viewDidLoad() {
        step1.layer.cornerRadius = step1.frame.height/2
        step2.layer.cornerRadius = step2.frame.height/2
        refer_btn.tintColor = .black
        
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
