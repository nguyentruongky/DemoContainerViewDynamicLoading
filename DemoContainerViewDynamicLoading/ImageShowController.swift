//
//  ImageShowController.swift
//  DemoContainerViewDynamicLoading
//
//  Created by Ky Nguyen on 1/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class ImageCell : UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
}

class ImageShowController: UITableViewController {

    var delegate : MainDelegate?
    
    var imageUrls = ["http://blog.palomacruise.com/vi/wp-content/uploads/2015/08/vinh-ha-long-8.jpg",
        "http://tiepthigiadinh.com.vn/images/ctvdulich/22(3).jpg",
        "http://www.esfahanemrooz.ir/pic/image/Life%20Style/Travel/jazebe%20zire%20zamin/shahre%20ghar%20ha%20england.jpg",
        "https://tinhte.cdnforo.com/store/2015/09/3147004_IMG_5883.jpg",
        "https://s-media-cache-ak0.pinimg.com/originals/3d/bf/4f/3dbf4f9b6b9f1ad5802e18163b759a14.jpg",
        "https://tinhte.cdnforo.com/store/2013/06/3426298_IMG_4472.jpg"
    ]
    
    var downloadedImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        runSerialDownload()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return downloadedImages.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! ImageCell

        cell.coverImageView.image = downloadedImages[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
    }
    
    func getTableContentHeight() -> CGFloat {
        
        return CGFloat(downloadedImages.count) * 150
    }
    
    func downloadComplete() {
        
        // add to images
        tableView.reloadData()
        let height = getTableContentHeight()
        delegate?.updateTheEmbedController(height)
    }
    
    func downloadImage(url: String) {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        let img = UIImage(data: data!)!
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.downloadedImages.append(img)
            self.downloadComplete()
        })
    }
    
    func runSerialDownload() {
        
        let serialQueue = dispatch_queue_create("imagesQueue", DISPATCH_QUEUE_SERIAL)
        
        for url in imageUrls {
            
            dispatch_async(serialQueue) { () -> Void in
                
                self.downloadImage(url)
            }
        }
    }
}
