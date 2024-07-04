//
//  CreateAccount.swift
//  Booking.com
//
//  Created by FAYAZ on 06/06/24.
//

import UIKit

class CreateAccount: UIViewController {

    @IBOutlet weak var name_view: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var num_view: UIView!
    @IBOutlet weak var checkbtn: UIButton!
    @IBOutlet weak var email_view: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var createbtn: UIButton!
    @IBOutlet weak var img_view: UIView!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var addimgbtn: UIButton!
    @IBOutlet weak var mobile_no: UITextField!
    @IBOutlet weak var pwd_view: UIView!
    @IBOutlet weak var pwd: UITextField!
    
    var dict = NSDictionary()
    
    
    var unchecked = false
    var ticked = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addimgbtn.tintColor = .orange

        
        name_view.layer.borderColor = UIColor.lightGray.cgColor
        name_view.layer.cornerRadius = 5
        name_view.layer.borderWidth = 1
        
        
        num_view.layer.borderColor = UIColor.lightGray.cgColor
        num_view.layer.cornerRadius = 5
        num_view.layer.borderWidth = 1
        
        email_view.layer.borderColor = UIColor.lightGray.cgColor
        email_view.layer.cornerRadius = 5
        email_view.layer.borderWidth = 1
        
        pwd_view.layer.borderColor = UIColor.lightGray.cgColor
        pwd_view.layer.cornerRadius = 5
        pwd_view.layer.borderWidth = 1
        
        
        createbtn.tintColor = .lightGray
        
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
    }
    

    
    
    
    
    
    @IBAction func Add_image(_ sender: Any) {
    }
    
   
    
    @IBAction func checkbox(_ sender: UIButton) {
        
        if !unchecked{
            sender.setImage(UIImage(named: "checkbox2"), for: .normal)
            unchecked = true
            ticked = 1
        }else{
            sender.setImage(UIImage(named: "checkbox1"), for: .normal)
            unchecked = false
            ticked = 0
        }
        if ticked == 1{
            createbtn.tintColor = UIColor.orange
        }else{
            createbtn.tintColor = UIColor.lightGray
        }
    }
    
    @IBAction func Create_account(_ sender: UIButton) {
        if self.name.text != "" && self.email.text != "" && self.pwd.text != "" && self.mobile_no.text != ""{
        if !unchecked {
            let alert = UIAlertController(title: "Alert", message: "Please check the box to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            self.present(alert, animated: true)
        }else{
            let url = URL(string: "https://hotel.b4production.com/getandpostreg")
            var urlreq = URLRequest(url: url!)
            urlreq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
            urlreq.httpMethod = "post"
            
            let poststring = "phone=\(mobile_no.text!)&password=\(pwd.text!)&username=\(name.text!)&email=\(email.text!)&image=\("")"
            
            urlreq.httpBody = poststring.data(using: .utf8)
            
            
            let task = URLSession.shared.dataTask(with: urlreq){(data,response,error)in
                let mydata = data
                do{
                   
                    do{
                        self.dict = try JSONSerialization.jsonObject(with: mydata!) as! NSDictionary
                        
                 
                        
                        
                        DispatchQueue.main.async(){
                            
                             let alert = UIAlertController(title: "Success", message: "Please Login to continue", preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "OK", style: .default,handler: {_ in
                             let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homepage") as! ViewController
                                 
                             self.navigationController?.pushViewController(next, animated: true)
                             }))
                             self.present(alert, animated: true)
                             
                            self.mobile_no.text = ""
                            self.name.text = ""
                            self.pwd.text = ""
                            self.email.text = ""
                            
                        }
                    }
                    
                }catch{
                    print(error)
                }
            }
            task.resume()
        }
        }else{
            let alert = UIAlertController(title: "Error", message: "Please fill all the required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            self.present(alert, animated: true)
        }
    }
}
