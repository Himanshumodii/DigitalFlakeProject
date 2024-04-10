import UIKit
import Foundation


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        var dataArray:[String:Any] = [:]
        
        dataArray["email"] = emailField!.text!
        dataArray["password"] = passwordField.text!
        do {
            var jsonData:Data = try JSONSerialization.data(withJSONObject: dataArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var str = "https://demo0413095.mockable.io/digitalflake/api/login"
            var myUrl = URL(string: str)
            var urlReq = URLRequest(url: myUrl!)
            urlReq.httpMethod = "POST"
            urlReq.httpBody = jsonData
            urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlReq.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
            
            var session = URLSession.shared
            
            var dataTask:URLSessionDataTask = session.dataTask(with: urlReq) {
                (urlData:Data?, response:URLResponse?, err:Error?)
                in
            //print(response)
            //print(err)
                do {
                    var json:[String:Any] = try JSONSerialization.jsonObject(with: urlData!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String : Any]
                    print(json["user_id"]!)
                    print(json["message"]!)
                
                    if((json["message"]!) as! String == "Signed in successfully"){
                        DispatchQueue.main.async {
                            var desk:HomeScreenController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeScreenController
                            self.present(desk, animated: true)
          
                        }
                    }else{
                        DispatchQueue.main.async {
                            var alertCon:UIAlertController = UIAlertController(title: "Invaild Username & Password", message: "Cheak User & PASS", preferredStyle: UIAlertController.Style.alert)
                            
                            var cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
                            
                            alertCon.addAction(cancelAction)
                            self.present(alertCon, animated: true, completion: nil)
                        }
                        print("Failed Login:")
                    }
                }
                catch{
                    print(err)
                }
            }
            dataTask.resume()
        }catch{
            print("Json Converter Error:",error)
        }
    }
    
    func createAccount(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}



