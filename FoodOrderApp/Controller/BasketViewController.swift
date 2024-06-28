//
//  BasketViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 28.06.24.
//

import UIKit

class BasketViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var basketCollectionView: UICollectionView!
    
    var basketItems: [Food] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            basketCollectionView.delegate = self
            basketCollectionView.dataSource = self
            basketCollectionView.register(UINib(nibName: "BasketCell", bundle: nil), forCellWithReuseIdentifier: "BasketCell")
            
            updateTotal()
        }
        
        func updateTotal() {
            let total = basketItems.reduce(0) { $0 + $1.price }
            totalLabel.text = "Total: $\(total)"
        }
    }

    extension BasketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return basketItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketCell", for: indexPath) as! BasketCell
            let item = basketItems[indexPath.row]
            cell.configure(with: item)
            return cell
        }
    }
