//
//  ViewController.swift
//  Booking.com
//
//  Created by FAYAZ on 06/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inner_view: UIView!
    @IBOutlet weak var com_view: UIView!
    @IBOutlet weak var num_view: UIView!
    @IBOutlet weak var pass_view: UIView!
    @IBOutlet weak var google: UIView!
    @IBOutlet weak var facebook: UIView!
    @IBOutlet weak var login_btn: UIButton!
    
    @IBOutlet weak var mobile_no: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    var array = NSArray()
    var dict = NSDictionary()
  
    
    
    
    

    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        login_btn.tintColor = .systemOrange
        num_view.layer.borderWidth = 1
        num_view.layer.borderColor = UIColor.lightGray.cgColor
        num_view.layer.cornerRadius = 5
        
        pass_view.layer.borderWidth = 1
        pass_view.layer.borderColor = UIColor.lightGray.cgColor
        pass_view.layer.cornerRadius = 5
        
        com_view.layer.cornerRadius = com_view.frame.height/2
       
        
        google.layer.cornerRadius = google.frame.height/2
        google.layer.borderWidth = 1
        google.layer.borderColor = UIColor.lightGray.cgColor
       
        
        facebook.layer.cornerRadius = facebook.frame.height/2
        facebook.layer.borderWidth = 1
        facebook.layer.borderColor = UIColor.lightGray.cgColor
       
        
        
     
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func Login(_ sender: Any) {
        
        
        
        let url = URL(string: "https://hotel.b4production.com/getandpostlog")
        var urlreq = URLRequest(url: url!)
        urlreq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        urlreq.httpMethod = "post"
        let poststring = "phone=\(mobile_no.text!)&password=\(password.text!)"
        
        urlreq.httpBody = poststring.data(using: .utf8)
        
        
        
        let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
        let mydata = data
            do{
                do{
                    self.dict = try JSONSerialization.jsonObject(with: mydata!,options: []) as! NSDictionary
//                  print("jsondata--->",self.dict)
                    DispatchQueue.main.async {
                       
                        
                        if self.dict["phone"] as? String == self.mobile_no.text && self.dict["password"] as? String == self.password.text{
                            let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hometab") as! HomeTab
                            next.modalPresentationStyle = .overFullScreen
                            self.present(next, animated: true)
                            
                            self.mobile_no.text = ""
                            self.password.text = ""
                        }
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
 
    }
    


    @IBAction func create(_ sender: Any) {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create") as! CreateAccount
        self.navigationController?.pushViewController(next, animated: true)

    }
    
    

    
    
}

