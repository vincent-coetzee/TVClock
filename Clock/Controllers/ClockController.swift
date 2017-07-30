//
//  ViewController.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/07.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

class ClockController: UIViewController,UICollectionViewDataSource
    {
    @IBOutlet private weak var clockView:ClockView!
    @IBOutlet private weak var worldClockView:UICollectionView!
    @IBOutlet private weak var flipper:DigitFlippingView!
    
    private let clocks = WorldClockCollection.defaultClocks()
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        worldClockView.register(WorldClockCell.self, forCellWithReuseIdentifier: "com.macsemantics.WorldClockCell")
        worldClockView.dataSource = self
        worldClockView.backgroundColor = UIColor.black
        let layout = worldClockView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:180,height:236)
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
        return(clocks.clocks.count)
        }
    
    public func collectionView(_ collectionView:UICollectionView,cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
        {
        let (label,secondsFromGMT) = clocks.clocks[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.macsemantics.WorldClockCell", for: indexPath) as! WorldClockCell
        cell.label = label
        cell.secondsFromGMT = secondsFromGMT
        return(cell)
        }
    
    @IBAction public func onTapped(_ sender:Any?)
        {
        flipper.digit = .two
        }
    
    override func didReceiveMemoryWarning()
        {
        super.didReceiveMemoryWarning()
        }
    }

