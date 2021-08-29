//
//  ViewController.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class AllRepositoriesViewController: UIViewController {
    
    private lazy var tableview : UITableView = { return UITableView(frame: .zero) }()
    
    override func loadView() {
        let body = UIView(frame: UIScreen.main.bounds)
        body.backgroundColor = UIColor(red: (41/255), green: (42/255), blue: (48/255), alpha: 1)
        self.view = body
        
        addSegmented()
        
    }
    
    private func addSegmented(){
        
        let segmented = UISegmentedControl(items: segmentedViews)
        segmented.addTarget(self, action: #selector(segmentedDidChange(_:)), for: .valueChanged)
        
        segmented.translatesAutoresizingMaskIntoConstraints = false
        
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = UIColor(red: (87/255), green: (84/255), blue: (85/255), alpha: 1)
        
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

