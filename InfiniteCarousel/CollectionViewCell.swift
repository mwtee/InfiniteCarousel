//
//  CollectionViewCell.swift
//  Test
//
//  Created by Ming Tee on 6/12/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

  @IBOutlet private var label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print("init cell")
  }

  func configure(text: String?, color: UIColor) {
    label.text = text
    backgroundColor = color
  }
}
