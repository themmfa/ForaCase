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
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        priceChangeSelectionAction()
        priceDifferenceSelectionAction()
        self.activityIndicator.startAnimating(in: self)
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            }
        }
        
        if !response.isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                print(response.errorMessage)
            }
        }
    }
}

