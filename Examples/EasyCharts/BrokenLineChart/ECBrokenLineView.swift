//
//  ECBrokenLineView.swift
//  Examples
//
//  Created by yjSong on 2017/9/23.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class ECBrokenLineView: UIView {
    var normalCollectionView : ECBrokenLineNormalCollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupLineCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLineCollectionView() {
        let frame : CGRect =  CGRect(x: 0, y: 0, width: ECScreenW, height: 200)
        self.normalCollectionView =
            ECBrokenLineNormalCollectionView.init(frame: frame)
        self.addSubview(self.normalCollectionView!)
    }
}
