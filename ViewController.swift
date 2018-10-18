//
//  ViewController.swift
//  TestSingleViewApplication
//
//  Created by piatkovskyi on 10/18/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

//MARK: Model class
@objc class ViewColorModel: NSObject {
    @objc dynamic var backgroundColor = UIColor.red
}

class ViewController: UIViewController {
    
    //    let options = NSKeyValueObservingOptions([.new, .old, .initial, .prior])
    let options = NSKeyValueObservingOptions([.new])
    
    let modelObject = ViewColorModel()
    
    //MARK: ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Adding listener (self object)
        self.addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Starting loop
        self.changeRandomValue()
    }
    
    deinit {
        removeObserver(self, forKeyPath: "backgroundColor")
    }
    
    //MARK: Observer setup and detection methods
    func addObservers() {
        modelObject.addObserver(self, forKeyPath: "backgroundColor", options: options, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[NSKeyValueChangeKey.newKey] {
            print("name changed: \(newValue)")
            if let newColor = newValue as? UIColor {
                //Calling action method when
                self.setColorAction(color: newColor)
            }
        }
    }
    
    //MARK: Actions
    
    //Method - loop for changing modelObject backgroundColor value
    func changeRandomValue() {
        delay(1) {
            self.modelObject.backgroundColor = .random()
            self.changeRandomValue()
        }
    }
    
    //Method for setting up specific color on current view background color
    func setColorAction(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    //MARK: Additional method, that perform closure after specific delay
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

//MARK: Extensions for random number and color generation
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
