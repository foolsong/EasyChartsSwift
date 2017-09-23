//
//  ECBrokenLineNormalCollectionView.swift
//  Examples
//
//  Created by yjSong on 2017/9/22.
//  Copyright © 2017 Global. All rights reserved.
//

import UIKit

class ECBrokenLineNormalCollectionView: ECBrokenLineCollectionView {

    var pointModelList : [ECBrokenLinePointModel] = []
    let collectionViewFrame : CGRect?
    
    init(frame: CGRect) {
        self.collectionViewFrame = frame
        super.init(frame: frame, collectionViewLayout: collectionViewLayout())
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        self.backgroundColor = UIColor.white
        self.register(ECBrokenLineCollectionViewCell.self,
                      forCellWithReuseIdentifier: "ECBrokenLineCollectionViewCell")
        self.dataSource = self
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsetsMake(0, cellWidth() * 2, 0, cellWidth() * 2)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: cellWidth(), height: 200)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension ECBrokenLineNormalCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pointModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ECBrokenLineCollectionViewCell",
                                                      for: indexPath)
        cell.layer.borderWidth = 0.5
//        cell.layer.borderColor = UIColor.ECRandomColor.cgColor
//        cell.backgroundColor = UIColor.ECRandomColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         let cell = cell as! ECBrokenLineCollectionViewCell
        cell.configureCell(pointYList: self.pointModelList, index: indexPath.row)
    }
}

extension ECBrokenLineNormalCollectionView {
    fileprivate func cellWidth() -> CGFloat {
        return self.collectionViewFrame!.size.width * 0.2
    }
}

extension ECBrokenLineNormalCollectionView {
    func reloadCollectionData(modelList: [ECBrokenLinePointModel]) {
        self.pointModelList = modelList
        self.reloadData()
    }
}
