//
//  ViewController.swift
//  Haberler
//
//  Created by ENES AKSOY on 19.05.2019.
//  Copyright © 2019 ENES AKSOY. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices


class ViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var titleNews = [String] ()
    var urlNews = [String] ()
    var urlImages = [String]()
    var explanationNews = [String] ()
    
    var slides = [ScrollVC] ()
    
    
    
    let apikey : String = "05d0ea935a3a43e6b2aa9b5c018b3675"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.delegate = self
        rates()
        
        pageController.numberOfPages = 10
        pageController.currentPage = 0
        
        
        view.addSubview(pageController)
        
        self.scrollView.contentSize.height = 1.0
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
        
    {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)
        
    }
    
    func setScrollView(slides: [ScrollVC]) {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count
            
        {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            scrollView.addSubview(slides[i])
            
        }
    }
    
    
    
    func sliders() -> [ScrollVC] {
        
        var slides: [ScrollVC] = []
        for i in 0..<10 {
            let slide:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide.imageView.sd_setImage(with: URL(string: urlImages[i] , relativeTo: nil), placeholderImage: nil)
            slide.titleLabel.text = titleNews[i]
            slide.urlLabel.text = urlNews[i]
            slide.explanationLabel.text = explanationNews[i]
            slide.configure()
            slide.delegate = self
            slides.append(slide)
        }
        
        return slides
    }
    
    func rates () {
        
        let url = URL (string: "https://api.hurriyet.com.tr/v1/articles?apikey=\(apikey)")
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
                            for data in jSONResult {
                                
                                let files = data["Files"] as! Array<AnyObject>
                                let fileUrl = files[0] as! Dictionary<String, AnyObject>
                                self.urlImages.append(fileUrl["FileUrl"] as! String)
                                self.urlNews.append(data["Url"]! as! String)
                                self.titleNews.append(data["Title"]! as! String)
                                self.explanationNews.append(data["Description"]! as! String)
                                
                            }
                            self.slides = self.sliders()
                            self.setScrollView(slides: self.slides)
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

extension ViewController: NewsListDelegate {
    func newsTapped(imageUrl: String) {
        print(imageUrl)
        let url = NSURL(string: imageUrl)
        let svc = SFSafariViewController(url: url! as URL)
        present(svc, animated: true, completion: nil)
    }
}
