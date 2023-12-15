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
    
    func handleUIChanges(cell: CustomCollectionViewCell, difference: Double?) {
        guard let difference = difference else {
            setDefaultUI(cell: cell)
            return
        }

        cell.arrowImageView.backgroundColor = (difference > 0) ? .green : (difference < 0) ? .red : .gray
        cell.differenceLabel.textColor = (difference > 0) ? .green : (difference < 0) ? .red : .gray
        cell.arrowImageView.image = (difference > 0) ? UIImage(systemName: "arrow.up") : (difference < 0) ? UIImage(systemName: "arrow.down") : nil
    }

    func setDefaultUI(cell: CustomCollectionViewCell) {
        cell.differenceLabel.textColor = .gray
        cell.arrowImageView.backgroundColor = .gray
        cell.arrowImageView.image = nil
    }
}
