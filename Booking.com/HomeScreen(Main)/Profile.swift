//
//  Profile.swift
//  Booking.com
//
//  Created by FAYAZ on 08/06/24.
//

import UIKit

class Profile: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var Profile_user: UITableView!
    @IBOutlet weak var Profile_details: UITableView!
    
    
    
    
    
    
    let details = ["Feedback","Privacy and policy","Terms and conditions","Change language","Contact us","Help","About","Logout"]
    let detail_img = [UIImage(named: "arrow"),UIImage(named: "exit")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Profile_user{
            return 1
        }else if tableView == Profile_details{
            return details.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileTableView
        if tableView == Profile_details{
            cell.lbl_details.text = details[indexPath.row]
            if cell.lbl_details.text != "Logout"{
                cell.img_details.image = detail_img[0]
            }else{
                cell.img_details.image = detail_img[1]
            }
        }else if tableView == Profile_user{
            cell.profilename.text = UserDefaults.standard.string(forKey: "username")!
            cell.profile_no.text = UserDefaults.standard.string(forKey: "phone")!
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == Profile_user{
            return 100
        }else if tableView == Profile_details{
            return 50
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if details[indexPath.row] == "Logout"{
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: {_ in
                let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homepage") as! ViewController
                next.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(next, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .destructive))
            self.present(alert,animated: true)
      }
    }
    
    
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Profile_user.layer.borderWidth = 1
        Profile_user.layer.borderColor = UIColor.systemGray4.cgColor
        Profile_user.isScrollEnabled = false
        Profile_user.separatorStyle = .none
        Profile_details.isScrollEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        
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
