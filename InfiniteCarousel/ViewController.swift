//
//  ViewController.swift
//  Test
//
//  Created by Ming Tee on 6/12/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = flowLayout
    collectionView.decelerationRate = .fast
    collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionViewCell")
    collectionView.isPagingEnabled = true
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count * 2
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var trueRow: Int = indexPath.row
    if indexPath.row > models.count - 1 {
      trueRow -= models.count
    }

    print("true row   : \(trueRow)")
    print("default row: \(indexPath.row)")
    print("===============")

    let trueIndexPath: IndexPath = IndexPath(row: trueRow, section: 0)
    let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: trueIndexPath) as! CollectionViewCell
    let model: Model = models[trueRow % models.count]
    cell.configure(text: "\(model.label)", color: model.color)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width, height: self.view.frame.height)
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let scrollViewContentWidth = scrollView.contentSize.width
    var scrollViewContentOffset: CGPoint = scrollView.contentOffset
    if scrollViewContentOffset.x < scrollViewContentWidth / 4 {
      scrollViewContentOffset.x += scrollViewContentWidth / 2
      scrollView.contentOffset = scrollViewContentOffset
    } else if scrollViewContentOffset.x > scrollViewContentWidth / 4 * 3 {
      scrollViewContentOffset.x -= scrollViewContentWidth / 2
      scrollView.contentOffset = scrollViewContentOffset
    }
  }

  private let models: [Model] = [
    .init(label: 0, color: .random),
    .init(label: 1, color: .random),
    .init(label: 2, color: .random),
    .init(label: 3, color: .random),
    .init(label: 4, color: .random),
    .init(label: 5, color: .random)
  ]
}

extension UIColor {
  static var random: UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
  }
}

struct Model {
  let label: Int
  let color: UIColor
}

// Other attemped implementation for test/learning purposes

//  func snapToNearestCell(_ collectionView: UICollectionView) {
//    for i in 0..<collectionView.numberOfItems(inSection: 0) {
//
//      let itemWithSpaceWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
//      let itemWidth = collectionViewFlowLayout.itemSize.width
//
//      if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
//        let indexPath = IndexPath(item: i, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        break
//      }
//    }
//  }
//
//  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////    snapToNearestCell(collectionView)
//    self.collectionView.scrollToNearestVisibleCollectionViewCell()
//  }

//  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////    snapToNearestCell(collectionView)
//    if !decelerate {
//      self.collectionView.scrollToNearestVisibleCollectionViewCell()
//    }
//  }

//class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
//
//  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
//
//    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//    let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
//
//    let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
//
//    let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
//
//    layoutAttributesArray?.forEach({ (layoutAttributes) in
//      let itemOffset = layoutAttributes.frame.origin.x
//      if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
//        offsetAdjustment = itemOffset - horizontalOffset
//      }
//    })
//
//    return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//  }
//}


//extension UICollectionView {
//  func scrollToNearestVisibleCollectionViewCell() {
//    self.decelerationRate = .fast
//    let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
//    var closestCellIndex = -1
//    var closestDistance: Float = .greatestFiniteMagnitude
//    for i in 0..<self.visibleCells.count {
//      let cell = self.visibleCells[i]
//      let cellWidth = cell.bounds.size.width
//      let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
//
//      // Now calculate closest cell
//      let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
//      if distance < closestDistance {
//        closestDistance = distance
//        closestCellIndex = self.indexPath(for: cell)!.row
//      }
//    }
//    if closestCellIndex != -1 {
//      self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
//    }
//  }
//}

