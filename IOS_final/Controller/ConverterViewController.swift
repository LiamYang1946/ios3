//
//  ConverterViewController.swift
//  IOS_final
//
//  Created by xthe on 2022/5/19.
//

import UIKit

class ConverterViewController: UIViewController {

    var AUD = 0.0
    var USD = 0.0
    var CNY = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let url =  "https://v6.exchangerate-api.com/v6/aeba01992f72ab0ce22b8a4f/latest/USD"
        getData(from: url)
        
        firstRateText.keyboardType = UIKeyboardType.decimalPad;
        secondRateText.keyboardType = UIKeyboardType.decimalPad;
        thirdRateText.keyboardType = UIKeyboardType.decimalPad;
        firstRateText.placeholder = String(AUD)
        secondRateText.placeholder = String(USD)
        thirdRateText.placeholder = String(CNY)
    }
    
    @IBOutlet weak var firstRateText: UITextField!
    @IBAction func firstRateAction(_ sender: Any) {
        if let tempText = Double(firstRateText.text!){
            let USDRate = USD / AUD * tempText
            let CNYRate = CNY / AUD * tempText
            secondRateText.text = nil
            thirdRateText.text = nil
            secondRateText.placeholder = String(USDRate);
            thirdRateText.placeholder = String(CNYRate);
        }
    }
    @IBOutlet weak var secondRateText: UITextField!
    @IBAction func secondRateAction(_ sender: Any) {
        if let tempText = Double(secondRateText.text!){
            let AUDRate = AUD / USD * tempText
            let CNYRate = CNY / USD * tempText
            firstRateText.text = nil
            thirdRateText.text = nil
            firstRateText.placeholder = String(AUDRate);
            thirdRateText.placeholder = String(CNYRate);
        }
    }
    @IBOutlet weak var thirdRateText: UITextField!
    @IBAction func thirdRateAction(_ sender: Any) {
        if let tempText = Double(thirdRateText.text!){
            let AUDRate = AUD / CNY * tempText
            let USDRate = USD / CNY * tempText
            firstRateText.text = nil
            secondRateText.text = nil
            firstRateText.placeholder = String(AUDRate);
            secondRateText.placeholder = String(USDRate);
        }
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
