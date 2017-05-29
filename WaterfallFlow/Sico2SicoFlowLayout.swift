//
//  Sico2SicoFlowLayout.swift
//  WaterfallFlow
//
//  Created by 吴德志 on 2017/5/28.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit

protocol Sico2SicoFlowLayoutDataSource:class {
    
    func numberOfCols(_ waterfall : Sico2SicoFlowLayout)->Int
    func watefall(_ watefall : Sico2SicoFlowLayout, item: Int) ->CGFloat
}

class Sico2SicoFlowLayout: UICollectionViewFlowLayout {
    
    weak var  dataSource : Sico2SicoFlowLayoutDataSource?
    fileprivate lazy var  cellArrts: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var  cols :Int = {
        return self.dataSource?.numberOfCols(self)  ?? 2
    }()!
    fileprivate lazy var  totalHeights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)

}

extension Sico2SicoFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        // 1 获取cell的个数
        let  itemCount = collectionView!.numberOfItems(inSection: 0)
        
        //2 给每个cell创建一个UICollectionViewLayoutAttributes
        let  cellW :CGFloat = ((collectionView?.bounds.width)! - sectionInset.left - sectionInset.right - CGFloat(cols-1)*minimumInteritemSpacing) / CGFloat(cols)
        
        for i in cellArrts.count..<itemCount{
            let  indexPath = IndexPath(item: i, section: 0)
            
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            guard let  cellH :CGFloat = dataSource?.watefall(self, item: i) else {
                fatalError("请实现对应的数据源方法 并返回Cell的高度")
            }
            
            let minH = totalHeights.min()!
            let  minIndex = totalHeights.index(of: minH)!
            let cellx :CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let celly :CGFloat = minH
            attr.frame = CGRect(x: cellx, y: celly, width: cellW, height: cellH)
            
            cellArrts.append(attr)
            
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
            
        }
    }
}

extension Sico2SicoFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellArrts
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom - minimumLineSpacing)
    }

}
