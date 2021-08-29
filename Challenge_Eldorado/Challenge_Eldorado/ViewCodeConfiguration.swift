//
//  ViewCodeConfiguration.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import Foundation

protocol ViewCodeConfiguration{
    func buildHierarchy()
    func setupConstraint()
    func configureView()
}

extension ViewCodeConfiguration{
    func configureView(){}
    
    func applyViewCode(){
        buildHierarchy()
        setupConstraint()
        configureView()
    }
}
