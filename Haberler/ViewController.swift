//
//  ViewController.swift
//  Haberler
//
//  Created by ENES AKSOY on 19.05.2019.
//  Copyright © 2019 ENES AKSOY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var titleNews = [String] ()
    var urlNews = [String] ()
    //let apikey = "05d0ea935a3a43e6b2aa9b5c018b3675"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rates()
    }
    func rates () {
        
    let url = URL (string: "https://api.hurriyet.com.tr/v1/articles?apikey=05d0ea935a3a43e6b2aa9b5c018b3675")
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: url!) { (data, response, error) in
        if error != nil {
            
            let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }else {
            if data != nil {
                do {
                    let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<Dictionary<String,AnyObject>>
                    
                     DispatchQueue.main.async {
                        // print(jSONResult)
                        for ids in jSONResult {
                            self.titleNews.append(ids["Title"]! as! String)
                            self.urlNews.append(ids["Url"]! as! String)
                        }
                        print(self.titleNews)
                        print(self.urlNews)
                    }
                }catch {
                    
                    let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    task.resume()
}
}



