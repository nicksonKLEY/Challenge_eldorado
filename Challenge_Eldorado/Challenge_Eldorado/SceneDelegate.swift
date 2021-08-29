//
//  SceneDelegate.swift
//  Challenge_Eldorado
//
//  Created by Nickson Kley Gonçalves Da Silva on 29/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene{
            
            let window = UIWindow(windowScene: windowScene)
            
            let initialView = ViewController()
            
            window.rootViewController = UINavigationController(rootViewController: initialView)
            self.window = window
            window.makeKeyAndVisible()
            
        }
        
    }

    


}

