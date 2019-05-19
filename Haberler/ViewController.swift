//
//  ViewController.swift
//  Haberler
//
//  Created by ENES AKSOY on 19.05.2019.
//  Copyright © 2019 ENES AKSOY. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var titleNews = [String] ()
    var urlNews = [String] ()
    var urlImages = [String]()
    var explanationNews = [String] ()
    
    var slides = [ScrollVC] ()
    
    //let apikey = "05d0ea935a3a43e6b2aa9b5c018b3675"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        rates()
        
        //slides = sliders()
        //setScrollView(slides: slides)
        
        
        
        //        Sayfa belirteçlerinin başlangıç ayarı
        
        pageController.numberOfPages = slides.count
        pageController.currentPage = 0
        
        view.addSubview(pageController)
        
        
        //        Dikey kaydırmayı devre dışı bırakmak için
        
        self.scrollView.contentSize.height = 1.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
        
    {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        pageController.currentPage = Int(pageIndex)
        
        
        //        Dikey durum
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        //        Yatay durum
        
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        //        Yatay ve dikey olarak kaçıncı scrollView'de olduğumuzu anlamak için bulunan view / maximum view
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        
        
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25)
        {
            
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
            
        }
        else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50)
        {
            
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
            
        }
        else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75)
        {
            
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.50, y: (0.75-percentOffset.x)/0.50)
            
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
            
        }
        else if(percentOffset.x > 0.75 && percentOffset.x <= 1)
        {
            
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.75, y: (1-percentOffset.x)/0.75)
            
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
            
        
        }
    }
    
    
    
    func setScrollView(slides: [ScrollVC])
        
    {
        
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
    
            let slide1:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide1.imageView.sd_setImage(with: URL(string: urlImages[0] , relativeTo: nil), placeholderImage: nil)
            slide1.titleLabel.text = titleNews[0]
            slide1.urlLabel.text = urlNews[0]
            slide1.explanationLabel.text = explanationNews[0]
            
            
            let slide2:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide2.imageView.sd_setImage(with: URL(string: urlImages[1] , relativeTo: nil), placeholderImage: nil)
            slide2.titleLabel.text = titleNews[1]
            slide2.urlLabel.text = urlNews[1]
            slide2.explanationLabel.text = explanationNews[1]
            
            
            let slide3:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide3.imageView.sd_setImage(with: URL(string: urlImages[2] , relativeTo: nil), placeholderImage: nil)
            slide3.titleLabel.text = titleNews[2]
            slide3.urlLabel.text = urlNews[2]
            slide3.explanationLabel.text = explanationNews[2]
            
            
            let slide4:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide4.imageView.sd_setImage(with: URL(string: urlImages[3] , relativeTo: nil), placeholderImage: nil)
            slide4.titleLabel.text = titleNews[3]
            slide4.urlLabel.text = urlNews[3]
            slide4.explanationLabel.text = explanationNews[3]
        
            let slide5:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide5.imageView.sd_setImage(with: URL(string: urlImages[4] , relativeTo: nil), placeholderImage: nil)
            slide5.titleLabel.text = titleNews[4]
            slide5.urlLabel.text = urlNews[4]
            slide5.explanationLabel.text = explanationNews[4]
            
            
            let slide6:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide6.imageView.sd_setImage(with: URL(string: urlImages[5] , relativeTo: nil), placeholderImage: nil)
            slide6.titleLabel.text = titleNews[5]
            slide6.urlLabel.text = urlNews[5]
            slide6.explanationLabel.text = explanationNews[5]
            
            
            
            let slide7:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide7.imageView.sd_setImage(with: URL(string: urlImages[6] , relativeTo: nil), placeholderImage: nil)
            slide7.titleLabel.text = titleNews[6]
            slide7.urlLabel.text = urlNews[6]
            slide7.explanationLabel.text = explanationNews[6]
            
            
            let slide8:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide8.imageView.sd_setImage(with: URL(string: urlImages[7] , relativeTo: nil), placeholderImage: nil)
            slide8.titleLabel.text = titleNews[7]
            slide8.urlLabel.text = urlNews[7]
            slide8.explanationLabel.text = explanationNews[7]
            
            
            
            let slide9:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide9.imageView.sd_setImage(with: URL(string: urlImages[8] , relativeTo: nil), placeholderImage: nil)
            slide9.titleLabel.text = titleNews[8]
            slide9.urlLabel.text = urlNews[8]
            slide9.explanationLabel.text = explanationNews[8]
            
            
            let slide10:ScrollVC = Bundle.main.loadNibNamed("ScrollView", owner: self, options: nil)?.first as! ScrollVC
            slide10.imageView.sd_setImage(with: URL(string: urlImages[9] , relativeTo: nil), placeholderImage: nil)
            slide10.titleLabel.text = titleNews[9]
            slide10.urlLabel.text = urlNews[9]
            slide10.explanationLabel.text = explanationNews[9]
            
            return [slide1, slide2, slide3, slide4, slide5, slide6, slide7, slide8, slide9, slide10]
            
       
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



