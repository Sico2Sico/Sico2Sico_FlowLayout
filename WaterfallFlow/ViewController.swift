//
//  ViewController.swift
//  WaterfallFlow
//
//  Created by 吴德志 on 2017/5/28.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit



private let KCellID = "FlowCelllID"

private var  callers = 30

class ViewController: UIViewController {
    
    fileprivate lazy var  colletionView :UICollectionView = {
        let  layout :Sico2SicoFlowLayout = Sico2SicoFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        layout.dataSource = self
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:KCellID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colletionView)
       
    }
    
    
    
}


extension UIViewController : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return callers
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        
        if indexPath.item == callers-1 {
            callers += 30
            collectionView.reloadData()
        }
        
        return cell
    }
}

extension UIViewController : Sico2SicoFlowLayoutDataSource{

    func numberOfCols(_ waterfall: Sico2SicoFlowLayout) -> Int {
        return 4
    }
    
    func watefall(_ watefall: Sico2SicoFlowLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }

}
