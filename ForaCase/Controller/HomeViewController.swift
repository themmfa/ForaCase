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
    lazy var selectedData:String = "las"
    
    deinit {
        timer?.invalidate()
    }
    
    lazy var priceDifferenceDropdown: DropDown = {
        let dropdownMenu = DropDown()
        return dropdownMenu
    }()
    
    @IBOutlet weak var dropdownView: UIView!
    
    
    @IBAction func priceDifferenceButtonClicked(_ sender: Any) {
        priceDifferenceDropdown.show()
    }
    
    @IBOutlet weak var priceDifferenceDropdownButton: UIButton!
    
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        priceDifferenceSelectionAction()
        layout()
        customCollectionView.dataSource = self
        customCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.startAnimating(in: self)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshList), userInfo: nil, repeats: true)
    }
    
    @objc func refreshList(){
        homeViewModel.getAllStocks()
    }
}

extension HomeViewController {
    func layout(){
        priceDifferenceDropdown.anchorView = dropdownView
        let selectedItemText = self.homeViewModel.stocks?.mypage?.first(where: ({$0.key == self.selectedData}))
        priceDifferenceDropdownButton.setTitle(selectedItemText?.name ?? "Son", for: .normal)
    }

    func priceDifferenceSelectionAction(){
        priceDifferenceDropdown.selectionAction = { index, item in
            self.selectedData = self.homeViewModel.stocks?.mypage?[index].key ?? "las"
            self.priceDifferenceDropdownButton.setTitle(self.homeViewModel.stocks?.mypage?[index].name ?? "Son", for: .normal)
        }
    }
    
    func showErrorDialog(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.refreshList), userInfo: nil, repeats: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController:HomeViewModelDelegate {
    func getAllStocks(_ response: ApiResponse) {
        if response.isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                let stringArray: [String] = self?.homeViewModel.stocks?.mypage?.map { $0.name ?? "" } ?? []
                self?.priceDifferenceDropdown.dataSource = stringArray
                self?.customCollectionView.reloadData()
            }
        }
        
        if !response.isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.timer?.invalidate()
                self?.showErrorDialog(message: response.errorMessage ?? "")
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
        var differenceString = Utils.shared.getSelectedItemValue(selectedItemKey: selectedData, homeViewModel: homeViewModel, index: indexPath.row)
        cell.differenceLabel.text = differenceString 
        homeViewModel.handleUIChanges(cell: cell, difference: homeViewModel.allStocks[indexPath.row].difference,stringToDouble: differenceString)
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

