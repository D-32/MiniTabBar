//
//  MiniTabBarItemView.swift
//  Pods
//
//  Created by Dylan Marriott on 12/01/17.
//
//

import Foundation
import UIKit

class MiniTabBarItemView: UIView {
  let titleLabel = UILabel()
  let iconView = UIImageView()

  private var selected = false

  override var tintColor: UIColor! {
    didSet {
      if self.selected {
        self.iconView.tintColor = self.tintColor
      }
      self.titleLabel.textColor = self.tintColor
    }
  }
  private let defaultFont = UIFont.systemFont(ofSize: 12)
  var font: UIFont? {
    didSet {
      self.titleLabel.font = self.font ?? defaultFont
    }
  }

  init(title: String, icon: UIImage) {
    super.init(frame: CGRect.zero)
    titleLabel.text = title
    titleLabel.font = self.defaultFont
    titleLabel.textColor = self.tintColor
    titleLabel.textAlignment = .center
    self.addSubview(titleLabel)

    iconView.image = icon.withRenderingMode(.alwaysTemplate)
    self.addSubview(iconView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 14)
    iconView.frame = CGRect(x: self.frame.width / 2 - 13, y: 12, width: 26, height: 20)
  }

  func setSelected(_ selected: Bool, animated: Bool = true) {
    self.selected = selected
    self.iconView.tintColor = selected ? self.tintColor : UIColor(white: 0.6, alpha: 1.0)

    if (animated && selected) {
      /*
       ICON
       */
      UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
        self.iconView.frame.origin.y = 5
      }, completion: { finished in
        UIView.animate(withDuration: 0.4, delay: 0.5, options: UIViewAnimationOptions(), animations: {
          self.iconView.frame.origin.y = 12
        })
      })


      /*
       TEXT
       */
      UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations: {
        self.titleLabel.frame.origin.y = 28
      }, completion: { finished in
        UIView.animate(withDuration: 0.2, delay: 0.5, options: UIViewAnimationOptions(), animations: {
          self.titleLabel.frame.origin.y = self.frame.size.height
        })
      })
    }
  }
}
