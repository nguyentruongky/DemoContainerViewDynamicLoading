//
//  MainViewController.swift
//  DemoContainerViewDynamicLoading
//
//  Created by Ky Nguyen on 1/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var dynamicHeight: CGFloat = 0
    @IBOutlet weak var pageContainer: UIView!
    
    @IBAction func selectPage(sender: AnyObject) {
        
        for controller in childViewControllers {
            
            controller.removeFromParentViewController()
        }
        
        for view in pageContainer.subviews {
            
            view.removeFromSuperview()
        }
        
        let segment = sender as! UISegmentedControl
        
        if segment.selectedSegmentIndex == 0 {
            
            createImageController()
        }
        else {
            
            createTextController()
        }
        
        updateScrollContentSize()
    }
    
    func updateScrollContentSize() {
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: dynamicHeight + 150)
    }
    
    func createTextController() {
        
        let textController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TextController") as! TextController
        dynamicHeight = textController.getTableContentHeight()
        textController.tableView.scrollEnabled = false
        
        self.addChildViewController(textController)
        pageContainer.addSubview(textController.view)
        textController.view.frame = CGRectMake(0, 0, pageContainer.frame.size.width, dynamicHeight)
    }
    
    func createImageController() {
        
        let imageController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ImageShowController") as! ImageShowController
        dynamicHeight = imageController.getTableContentHeight()
        imageController.tableView.scrollEnabled = false
        
        self.addChildViewController(imageController)
        pageContainer.addSubview(imageController.view)
        imageController.view.frame = CGRectMake(0, 0, pageContainer.frame.size.width, dynamicHeight * 2)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImageController()
        updateScrollContentSize()
    }
}
