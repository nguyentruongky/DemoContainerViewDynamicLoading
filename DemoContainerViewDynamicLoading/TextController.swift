//
//  TextController.swift
//  DemoContainerViewDynamicLoading
//
//  Created by Ky Nguyen on 1/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class TextController: UITableViewController {

    var delegate : MainDelegate?
    
    var vietnamTravelLocations = ["Vịnh Hạ Long", "Nha Trang", "Địa đạo Củ Chi", "Đồng bằng sông Cửu Long", "Mũi Né", "Ruộng bậc thang Sa Pa", "Phú Quốc", "Hội An", "Hồ Hoàn Kiếm", "Vịnh Hạ Long", "Nha Trang", "Địa đạo Củ Chi", "Đồng bằng sông Cửu Long", "Mũi Né", "Ruộng bậc thang Sa Pa", "Phú Quốc", "Hội An", "Hồ Hoàn Kiếm", "Vịnh Hạ Long", "Nha Trang", "Địa đạo Củ Chi", "Đồng bằng sông Cửu Long", "Mũi Né", "Ruộng bậc thang Sa Pa", "Phú Quốc", "Hội An", "Hồ Hoàn Kiếm", "Vịnh Hạ Long", "Nha Trang", "Địa đạo Củ Chi", "Đồng bằng sông Cửu Long", "Mũi Né", "Ruộng bậc thang Sa Pa", "Phú Quốc", "Hội An", "Hồ Hoàn Kiếm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return vietnamTravelLocations.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)

        cell.textLabel?.text = "\(indexPath.row + 1). \(vietnamTravelLocations[indexPath.row])"

        return cell
    }
    
    func getTableContentHeight() -> CGFloat {
        
        return CGFloat(vietnamTravelLocations.count) * 44
    }
    
    func downloadComplete() {
        
        // add to images
        tableView.reloadData()
        let height = getTableContentHeight()
        
        delegate?.updateTheEmbedController(height)
    }
}
