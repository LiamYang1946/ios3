//
//  MarketViewController.swift
//  IOS_final
//
//  Created by xthe on 2022/5/21.
//

import UIKit

class MarketViewController: UIViewController {

    var AUD = 0.0
    var USD = 0.0
    var CNY = 0.0
    var rateUrl =  "https://v6.exchangerate-api.com/v6/aeba01992f72ab0ce22b8a4f/latest"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRate(money: "USD")
        getData(from: rateUrl)
        
    }
    
    @IBAction func AUDToOther(_ sender: Any) {
        let tempAUD = AUD / AUD
        let tempUSD = USD / AUD
        let tempCNY = CNY / AUD
        AUDShow.text = String(tempAUD)
        USDShow.text = String(tempUSD)
        CNYShow.text = String(tempCNY)
        nowCurreny.text = "AUD"
        targetCurreny.text = "USD"
    }
    
    @IBAction func USDToOther(_ sender: Any) {
        let tempAUD = AUD / USD
        let tempUSD = USD / USD
        let tempCNY = CNY / USD
        AUDShow.text = String(tempAUD)
        USDShow.text = String(tempUSD)
        CNYShow.text = String(tempCNY)
        nowCurreny.text = "USD"
        targetCurreny.text = "AUD"
    }
    
    @IBAction func CNYToOther(_ sender: Any) {
        let tempAUD = AUD / CNY
        let tempUSD = USD / CNY
        let tempCNY = CNY / CNY
        AUDShow.text = String(tempAUD)
        USDShow.text = String(tempUSD)
        CNYShow.text = String(tempCNY)
        nowCurreny.text = "CNY"
        targetCurreny.text = "AUD"
    }
    
    @IBOutlet weak var AUDShow: UITextField!
    
    @IBOutlet weak var USDShow: UITextField!
    
    @IBOutlet weak var CNYShow: UITextField!

    @IBOutlet weak var selectedCurreny: UIButton!
    
    @IBOutlet weak var nowCurreny: UILabel!
    
    @IBOutlet weak var targetCurreny: UILabel!
    
    
    func fetchRate(money: String){
        self.rateUrl = "\(rateUrl)/\(money)"
    }
    
    private func getData(from url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("wrong")
                return
            }
            var result: Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("fail \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.result)
            self.USD = json.conversion_rates.USD
            self.CNY = json.conversion_rates.CNY
            self.AUD = json.conversion_rates.AUD
            

        })
        
        task.resume()
    }
    

}
