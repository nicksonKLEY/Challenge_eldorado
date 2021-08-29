//
//  ViewController.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let segmentedViews = ["All", "Saved"]
    
    override func loadView() {
        let body = UIView(frame: UIScreen.main.bounds)
        
        self.view = body
        
        addSegmented()
        
    }
    
    private func addSegmented(){
        
        let segmented = UISegmentedControl(items: segmentedViews)
        segmented.addTarget(self, action: #selector(segmentedDidChange(_:)), for: .valueChanged)
        
        segmented.translatesAutoresizingMaskIntoConstraints = false
        
        segmented.selectedSegmentIndex = 0
        
        view.addSubview(segmented)
        
        NSLayoutConstraint.activate([
            segmented.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmented.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func segmentedDidChange(_ segmentedControl: UISegmentedControl){
        
        print("\(segmentedViews[segmentedControl.selectedSegmentIndex])")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

