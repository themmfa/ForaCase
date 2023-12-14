//
//  ViewController.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import DropDown
import UIKit

class HomeViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    var activityIndicator = CustomActivityIndicator()
    var timer:Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    let priceChangeDropdown: DropDown = {
        let dropdownMenu = DropDown()
        dropdownMenu.dataSource = ["Son","Fark","% Fark","Dusuk","Yuksek"]
        return dropdownMenu
    }()
    
    let priceDifferenceDropdown: DropDown = {
        let dropdownMenu = DropDown()
        dropdownMenu.dataSource = ["Son","Fark","% Fark","Dusuk","Yuksek"]
        return dropdownMenu
    }()
    
    @IBOutlet weak var dropdownView: UIView!
    
    @IBOutlet weak var priceChangeDropdownButton: UIButton!
    @IBAction func priceChangeButtonClicked(_ sender: Any) {
        priceChangeDropdown.show()
    }
    
    @IBAction func priceDifferenceButtonClicked(_ sender: Any) {
        priceDifferenceDropdown.show()
    }
    
    @IBOutlet weak var priceDifferenceDropdownButton: UIButton!
    
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        priceChangeSelectionAction()
        priceDifferenceSelectionAction()
        layout()
        customCollectionView.dataSource = self
        customCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.startAnimating(in: self)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshList), userInfo: nil, repeats: true)
        homeViewModel.getAllStocks()
    }
    
    @objc func refreshList(){
        homeViewModel.getAllStocks()
    }
}

extension HomeViewController {
    func layout(){
        priceChangeDropdown.anchorView = dropdownView
        priceDifferenceDropdown.anchorView = dropdownView
    }
    
    func priceChangeSelectionAction(){
        priceChangeDropdown.selectionAction = { index, item in
            self.priceChangeDropdownButton.setTitle(item, for: .normal)
        }
    }
    
    func priceDifferenceSelectionAction(){
        priceDifferenceDropdown.selectionAction = { index, item in
            self.priceDifferenceDropdownButton.setTitle(item, for: .normal)
        }
    }
}

extension HomeViewController:HomeViewModelDelegate {
    func getAllStocks(_ response: ApiResponse) {
        if response.isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.customCollectionView.reloadData()
            }
        }
        
        if !response.isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.allStocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.stockNameLabel.text = homeViewModel.allStocks[indexPath.row].cod ?? ""
        cell.lastChangedTimeLabel.text = homeViewModel.allStocks[indexPath.row].clo ?? ""
        cell.lastPriceTable.text = homeViewModel.allStocks[indexPath.row].las ?? ""
        let difference = homeViewModel.allStocks[indexPath.row].difference ?? 0.0
        cell.differenceLabel.text = String(format: "%.4f", difference)
        if difference == 0.0 {
            cell.arrowImageView.backgroundColor = .gray
            cell.arrowImageView.image = nil
        }else if difference > 0{
            cell.arrowImageView.backgroundColor = .green
            cell.arrowImageView.image = UIImage(systemName: "arrow.up")
        }else{
            cell.arrowImageView.backgroundColor = .red
            cell.arrowImageView.image = UIImage(systemName: "arrow.down")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            size = layout.itemSize;
            size.width = collectionView.bounds.width
        }
        
        return size
    }
}

