//
//  SegmentedViewControler.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    private let segmentedViews = ["All", "Saved"]
    
    private lazy var segmentedView : UIView = { return UIView(frame: .zero)}()
    private lazy var segmentedControl : UISegmentedControl = { return UISegmentedControl(frame: .zero)}()
    
    override func loadView() {
        <#code#>
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Swift Repositories"
        applyViewCode()
        
    }
    
}

extension SegmentedViewController : ViewCodeConfiguration{
    func buildHierarchy() {
        view.addSubview(segmentedView)
        view.addSubview(segmentedControl)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            segmentedControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func configureView() {
        <#code#>
    }
}
