//
//  HomeViewModel.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate {
    func getAllStocks(_ response: ApiResponse)
}

class HomeViewModel {
    var delegate: HomeViewModelDelegate?
    var allStocks:[Stock] = []
    var stocks:Stocks?
    private let financeApiService:FinanceApiService =  FinanceApiService()
    
    init() {
        Task{
            do{
                stocks = try await financeApiService.getAllStocksInfo()
            }catch{
                throw error
            }
        }
    }
    
    func getAllStocks() {
        Task {
            do {
                allStocks = try await financeApiService.getAllStocks(stocks: stocks)
                delegate?.getAllStocks(ApiResponse(isSuccess: true))
            } catch {
                delegate?.getAllStocks(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }
    
    func handleUIChanges(cell:CustomCollectionViewCell,difference:Double?){
        guard let difference = difference else {
            cell.differenceLabel.textColor = .gray
            cell.arrowImageView.backgroundColor = .gray
            cell.arrowImageView.image = nil
            return
        }
        if difference == 0.0 {
            cell.differenceLabel.textColor = .gray
            cell.arrowImageView.backgroundColor = .gray
            cell.arrowImageView.image = nil
        }else if difference > 0{
            cell.arrowImageView.backgroundColor = .green
            cell.differenceLabel.textColor = .green
            cell.arrowImageView.image = UIImage(systemName: "arrow.up")
        }else{
            cell.arrowImageView.backgroundColor = .red
            cell.differenceLabel.textColor = .red
            cell.arrowImageView.image = UIImage(systemName: "arrow.down")
        }
    }
}
