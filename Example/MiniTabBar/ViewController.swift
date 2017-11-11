//
//  ViewController.swift
//  MiniTabBar
//
//  Created by Dylan Marriott on 01/11/2017.
//  Copyright (c) 2017 Dylan Marriott. All rights reserved.
//

import UIKit
import MiniTabBar

class ViewController: UIViewController, MiniTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSimpleTabBar()
        //self.createCustomItemTabBar()
    }
    
    private func createSimpleTabBar() {
        var items = [MiniTabBarItem]()
        items.append(MiniTabBarItem(title: "Home", icon: #imageLiteral(resourceName: "tab1")))
        items.append(MiniTabBarItem(title: "Profile", icon: #imageLiteral(resourceName: "tab2")))
        items.append(MiniTabBarItem(title: "Tickets", icon: #imageLiteral(resourceName: "tab3")))
        let tabBar = MiniTabBar(items: items)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        self.view.addSubview(tabBar)
        
        let constraints = [
            tabBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCustomItemTabBar() {
        var items = [MiniTabBarItem]()
        items.append(MiniTabBarItem(title: "Home", icon: #imageLiteral(resourceName: "tab1")))
        
        let customButton = UIButton()
        customButton.backgroundColor = UIColor.orange
        customButton.layer.cornerRadius = 4
        customButton.frame.size = CGSize(width: 50, height: 50)
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        let customItem = MiniTabBarItem(customView: customButton, offset: UIOffset(horizontal: 0, vertical: -10))
        customItem.selectable = false
        items.append(customItem)
        
        items.append(MiniTabBarItem(title: "Tickets", icon: #imageLiteral(resourceName: "tab3")))
        let tabBar = MiniTabBar(items: items)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        self.view.addSubview(tabBar)
        
        let constraints = [
            tabBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 44),
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func tabSelected(_ index: Int) {
        print("Selected tab: ", index)
    }
    
    @objc private func customButtonTapped() {
        print("Custom button tapped")
    }
}

