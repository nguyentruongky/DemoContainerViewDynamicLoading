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
    
    var images = ["Vietnam_1", "Vietnam_2", "Vietnam_3", "Vietnam_4", "Vietnam_5", "Vietnam_6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return images.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! ImageCell

        cell.coverImageView.image = UIImage(named: images[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
    }
    
    func getTableContentHeight() -> CGFloat {
        
        return CGFloat(images.count) * 150
    }
    
    func downloadComplete() {
        
        // add to images
        tableView.reloadData()
        let height = getTableContentHeight()
        
        delegate?.updateTheEmbedController(height)
    }
}
