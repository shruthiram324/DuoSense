//
//  CollectionViewController.swift
//  GiorgioGuttilla_Lab4
//
//  Created by Giorgio Guttilla on 10/16/19.
//  Copyright © 2019 Giorgio Guttilla. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var theCollectionView: UICollectionView!
    
    var UserDrawings: [UserDrawing] = []{
        didSet {
           //UserDrawings = LoadAllDrawings()
            reloadView()
            print("yeee its working")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        theCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        
        UserDrawings = LoadAllDrawings()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func reloadView(){
        DispatchQueue.main.async {
            
            self.theCollectionView.reloadData()
        }
    }
    
    func refreshDrawings() {
        UserDrawings = LoadAllDrawings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDrawings = LoadAllDrawings()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDrawings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        
        cell.textLabel.text = UserDrawings[indexPath.row].title
        cell.imageView.image = UserDrawings[indexPath.row].image
        cell.controller = navigationController
        cell.collection = self
        
        return cell
    }

    
}
