//
//  ViewController.swift
//  DigitalflakeProject
//
//  Created by Codebetter on 08/04/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mobileNumField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameField!.text = ""
        mobileNumField!.text = ""
        emailField!.text = ""
    }
    
    @IBAction func saveAcDetail(_ sender: Any) {
    
        var accountData:[String:Any] = [:]
        accountData["name"] = nameField!.text!
        accountData["email"] = emailField!.text!
       
        do{
        var jsonData:Data = try JSONSerialization.data(withJSONObject: accountData, options: JSONSerialization.WritingOptions.prettyPrinted)
        var str:String = "https://demo0413095.mockable.io/digitalflake/api/create_account"
        var myUrl = URL(string: str)
        var addReq = URLRequest(url: myUrl!)
        addReq.httpBody = jsonData
        addReq.httpMethod = "POST"
        addReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        addReq.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
        
            var dataTask = URLSession.shared.dataTask(with: addReq) {
              (urlResponse:Data?, response:URLResponse?, err:Error?)
                in
            do{
            var json:[String:Any] = try JSONSerialization.jsonObject(with: urlResponse!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
           
             //  print(json["user_id"]!)
             //  print(json["message"]!)
                DispatchQueue.main.async {
                    var obj:LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login_con") as! LoginViewController
                    self.present(obj, animated: true)
                }
                }catch{
                print("Response Error:")
            }
          }
             dataTask.resume()
        }catch{
            print("JSON Converstion Error:")
        }
        
    }
    
}

