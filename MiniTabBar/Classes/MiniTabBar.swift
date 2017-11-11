//
//  MiniTabBar.swift
//  Pods
//
//  Created by Dylan Marriott on 11/01/17.
//
//

import Foundation
import UIKit

public class MiniTabBarItem {
    var title: String?
    var icon: UIImage?
    var customView: UIView?
    var offset = UIOffset.zero
    public var selectable: Bool = true
    public init(title: String, icon:UIImage) {
        self.title = title
        self.icon = icon
    }
    public init(customView: UIView, offset: UIOffset = UIOffset.zero) {
        self.customView = customView
        self.offset = offset
    }
}

public protocol MiniTabBarDelegate: class {
    func tabSelected(_ index: Int)
}

public class MiniTabBar: UIView {
    
    public weak var delegate: MiniTabBarDelegate?
    public let keyLine = UIView()
    public override var tintColor: UIColor! {
        didSet {
            for itv in self.itemViews {
                itv.tintColor = self.tintColor
            }
        }
    }
    public var font: UIFont? {
        didSet {
            for itv in self.itemViews {
                itv.font = self.font
            }
        }
    }
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight)) as UIVisualEffectView
    public var backgroundBlurEnabled: Bool = true {
        didSet {
            self.visualEffectView.isHidden = !self.backgroundBlurEnabled
        }
    }
    
    fileprivate var itemViews = [MiniTabBarItemView]()
    fileprivate var currentSelectedIndex: Int?
    fileprivate let bg = UIView()
    
    public init(items: [MiniTabBarItem]) {
        super.init(frame: CGRect.zero)
        
        
        bg.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        addSubview(bg)
        
        self.addSubview(visualEffectView)
        
        keyLine.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(keyLine)
        
        var i = 0
        for item in items {
            let itemView = MiniTabBarItemView(item)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MiniTabBar.itemTapped(_:))))
            self.itemViews.append(itemView)
            self.addSubview(itemView)
            i += 1
        }
        
        self.selectItem(0, animated: false)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        bg.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1000)
        visualEffectView.frame = bg.bounds
        keyLine.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
        
        let itemWidth = self.frame.width / CGFloat(self.itemViews.count)
        for (i, itemView) in self.itemViews.enumerated() {
            let x = itemWidth * CGFloat(i)
            itemView.frame = CGRect(x: x, y: 0, width: itemWidth, height: frame.size.height)
        }
    }

    func itemTapped(_ gesture: UITapGestureRecognizer) {
        let itemView = gesture.view as! MiniTabBarItemView
        let selectedIndex = self.itemViews.index(of: itemView)!
        self.selectItem(selectedIndex)
    }
    
    public func selectItem(_ selectedIndex: Int, animated: Bool = true) {
        if !self.itemViews[selectedIndex].item.selectable {
            return
        }
        if (selectedIndex == self.currentSelectedIndex) {
            return
        }
        self.currentSelectedIndex = selectedIndex
        
        for (index, v) in self.itemViews.enumerated() {
            let selected = (index == selectedIndex)
            v.setSelected(selected, animated: animated)
        }
        
        self.delegate?.tabSelected(selectedIndex)
    }
}

