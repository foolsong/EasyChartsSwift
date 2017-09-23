//
//  ECBrokenLineNormalCollectionView.swift
//  Examples
//
//  Created by 宋永建 on 2017/9/22.
//  Copyright © 2017年 Global. All rights reserved.
//

import UIKit

class ECBrokenLineNormalCollectionView: ECBrokenLineCollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        self.dataSource = self
        self.delegate = self
    }
}

extension ECBrokenLineNormalCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
