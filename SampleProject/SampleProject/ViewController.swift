//
//  ViewController.swift
//  SampleProject
//
//  Created by Al Shamas Tufail on 27/03/2015.
//  Copyright (c) 2015 Al Shamas Tufail. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadioGroupDelegate {
    

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let groupView = RadioGroupView(withGroupId: "groupOne", andOptions: [RadioOption(label: "Yes", optionValue: "yes"), RadioOption(label: "No", optionValue: "no")])
        groupView.delegate = self
        groupView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(groupView)
        let leadingConstraint = NSLayoutConstraint(item: groupView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let trailingConstraint = NSLayoutConstraint(item: groupView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 20)
        let topConstraint = NSLayoutConstraint(item: groupView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100)
        view.addConstraints([leadingConstraint, trailingConstraint, topConstraint])
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func didSelectOption(option: RadioOption, groupId: String) {
        print(option)
        print(groupId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

