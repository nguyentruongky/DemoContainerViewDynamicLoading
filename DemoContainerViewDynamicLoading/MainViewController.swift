//
//  MainViewController.swift
//  DemoContainerViewDynamicLoading
//
//  Created by Ky Nguyen on 1/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

protocol MainDelegate {
    
    func updateTheEmbedController(height: CGFloat)
}

class MainViewController: UIViewController, MainDelegate {

    var dynamicHeight: CGFloat = 0
    
    @IBOutlet weak var controllerIndicatorSegment: UISegmentedControl!
    
    
    @IBOutlet weak var scrollView: UIScrollView!

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
        textController.delegate = self
        
        self.addChildViewController(textController)
        pageContainer.addSubview(textController.view)
        textController.view.frame = CGRectMake(0, 0, pageContainer.frame.size.width, dynamicHeight)
    }
    
    func createImageController() {
        
        let imageController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ImageShowController") as! ImageShowController
        dynamicHeight = imageController.getTableContentHeight()
        imageController.delegate = self
        imageController.tableView.scrollEnabled = false
        
        self.addChildViewController(imageController)
        pageContainer.addSubview(imageController.view)
        imageController.view.frame = CGRectMake(0, 0, pageContainer.frame.size.width, dynamicHeight * 2)
    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        createImageController()
        updateScrollContentSize()
    }
    
    func updateTheEmbedController(height: CGFloat) {
        
        dynamicHeight = height
        
        if controllerIndicatorSegment.selectedSegmentIndex == 0 {
            
            createImageController()
        }
        else {
            
            createTextController()
        }
        
        updateScrollContentSize()

    }
}
