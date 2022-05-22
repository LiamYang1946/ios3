//
//  ViewController.swift
//  IOS_final
//
//  Created by 杨礼铭 on 2022/5/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url =  "https://v6.exchangerate-api.com/v6/aeba01992f72ab0ce22b8a4f/latest/USD"
        getData(from: url)
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
            print(json.conversion_rates.AUD)
            print(json.conversion_rates.CNY)
        })
        
        task.resume()
    }
    
    
}

