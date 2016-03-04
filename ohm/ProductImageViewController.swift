//
//  ProductImageViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/2/25.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class ProductImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var cache: CacheUtils = CacheUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = cache.cacheGetString("imageName") as String
        
        self.imageView.image = UIImage(named: imageName)
    }
    
    @IBAction func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
