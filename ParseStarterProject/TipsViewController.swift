//
//  TipsViewController.swift
//  Diappetes
//
//  Created by Admin on 20/06/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iOS-7-Wallpaper-2-577x1024.png")!)
        
        let url = URL(string: "http://fundacioncarlosslim.org/?s=diabetes")!
        
        webView.loadRequest(URLRequest(url: url))



        // Do any additional setup after loading the view.
    }
    
        /*let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
         
         //will happen when task completes
         
         if let urlContent = data{
         let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
         dispatch_async(dispatch_get_main_queue(), { ()  -> Void in
         self.webView.loadHTMLString(String(webContent!), baseURL:nil)
         })
         
         //print(webContent)
         }else{
         print("It didn´t work")
         //Show Error Message
         
         }
         }
         
         //task.resume()*/
        // Do any additional setup after loading the view, typically from a nib.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
