//
//  bookHistoryController.swift
//  DigitalflakeProject
//
//  Created by Codebetter on 08/04/24.
//

import UIKit

class bookHistoryController: UIViewController, UITableViewDataSource {
   

    
    @IBOutlet weak var bookTableView: UITableView!
    
    var Bookhist:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var str = "https://demo0413095.mockable.io/digitalflake/api/get_bookings?user_id=1"
        var myUrl = URL(string: str)
        var urlReq = URLRequest(url: myUrl!)
        urlReq.httpMethod = "GET"
    
        
        let jsonData = URLSession.shared.dataTask(with : urlReq) {
            (urlData:Data?, response:URLResponse?, err:Error?)
            in
            print(response)
            do{
                var jsonData = try JSONSerialization.jsonObject(with: urlData!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                print(jsonData["bookings"])
                self.Bookhist = jsonData["bookings"] as! [[String:Any]]
        
                print(self.Bookhist)
                
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
            }catch{
                print("JSON Converter error:")
            }
        }
    
        jsonData.resume()
        bookTableView.dataSource = self
        let cellNib:UINib = UINib(nibName: "BookTableViewCell", bundle: nil)
        bookTableView.register(cellNib, forCellReuseIdentifier: "bookHis")
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bookhist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BookTableViewCell = bookTableView.dequeueReusableCell(withIdentifier: "bookHis") as! BookTableViewCell
     
        let empData:[String:Any] = Bookhist[indexPath.row]
        var id:Int = empData["workspace_id"]! as! Int
        var name = empData["workspace_name"]!
        var date = empData["booking_date"]!
        
        cell.nameLabel!.text = "Name   : \(name as! String)"
        cell.deskIdLabel!.text = "Desk ID   :\(String(id))"
        cell.bookedLabel!.text = "Booked on   :\(date as! String)"
    
        return cell
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
