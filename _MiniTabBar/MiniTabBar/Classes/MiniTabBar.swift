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
  var title: String
  var icon: UIImage
  public init(title: String, icon:UIImage) {
    self.title = title
    self.icon = icon
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

  public var itemWidth: CGFloat = 100.0

  fileprivate var itemViews = [MiniTabBarItemView]()
  fileprivate var currentSelectedIndex: Int?

  public init(items: [MiniTabBarItem]) {
    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor(white: 1.0, alpha: 0.8)

    self.addSubview(visualEffectView)

    keyLine.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    self.addSubview(keyLine)

    var i = 0
    for item in items {
      let itemView = MiniTabBarItemView(title: item.title, icon: item.icon)
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
    visualEffectView.frame = self.bounds
    keyLine.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)

    let spacing = Int((frame.size.width - (CGFloat(self.itemViews.count) * itemWidth)) / CGFloat(self.itemViews.count + 1))
    for (i, itemView) in self.itemViews.enumerated() {
      let x = CGFloat(spacing * (i+1)) + (itemWidth * CGFloat(i))
      itemView.frame = CGRect(x: x, y: 0, width: itemWidth, height: frame.size.height)
    }
  }

  func itemTapped(_ gesture: UITapGestureRecognizer) {
    let itemView = gesture.view as! MiniTabBarItemView
    let selectedIndex = self.itemViews.index(of: itemView)!
    self.selectItem(selectedIndex)
  }

  public func selectItem(_ selectedIndex: Int, animated: Bool = true) {
    if (selectedIndex == self.currentSelectedIndex) {
      return
    }
    self.currentSelectedIndex = selectedIndex

    let itemView = self.itemViews[selectedIndex]
    for (index, v) in self.itemViews.enumerated() {
      v.setSelected((index == selectedIndex), animated: animated)
    }

    self.delegate?.tabSelected(selectedIndex)
  }
}

