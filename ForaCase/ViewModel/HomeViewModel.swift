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
                var currentStocks = try await financeApiService.getAllStocks(stocks: self.stocks)
                if allStocks.isEmpty {
                    allStocks = currentStocks
                }else{
                    for currentStock in currentStocks{
                        if let index = allStocks.firstIndex(where: { $0.tke == currentStock.tke }) {
                            let previousLast = allStocks[index].las == nil ? "0.0" : allStocks[index].las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                            let currentLast = currentStock.las == nil ? "0.0" : currentStock.las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                            let difference = (Double(previousLast) ?? 0.0) - (Double(currentLast) ?? 0.0)
                            let newestStock = Stock(cod: currentStock.cod, gro: currentStock.gro, tke: currentStock.tke, def: currentStock.def, clo: currentStock.clo, flo: currentStock.flo, cei: currentStock.cei, pdd: currentStock.pdd, low: currentStock.low, sel: currentStock.sel, buy: currentStock.buy, ddi: currentStock.ddi, hig: currentStock.hig, las: currentStock.las, pdc: currentStock.pdc,gco: currentStock.gco,difference: difference)
                            currentStocks[index] = newestStock
                        } else {
                            continue
                        }
                    }
                    allStocks = currentStocks
                }
                delegate?.getAllStocks(ApiResponse(isSuccess: true))
            } catch {
                delegate?.getAllStocks(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }
    
    func handleUIChanges(cell: CustomCollectionViewCell, difference: Double?,stringToDouble:String?) {
        guard let difference = difference, var stringToDouble = stringToDouble else {
            setDefaultUI(cell: cell)
            return
        }
        stringToDouble.removeAll(where: ({$0 == "%"}))
        let doubleValue = Utils.shared.convertToDouble(doubleString: stringToDouble)
        cell.differenceLabel.textColor = (doubleValue ?? 0.0 > 0) ? .green : (doubleValue ?? 0.0 < 0) ? .red : .gray
        cell.arrowImageView.backgroundColor = (difference > 0) ? .green : (difference < 0) ? .red : .gray
        cell.arrowImageView.image = (difference > 0) ? UIImage(systemName: "arrow.up") : (difference < 0) ? UIImage(systemName: "arrow.down") : nil
    }
    
    func setDefaultUI(cell: CustomCollectionViewCell) {
        cell.differenceLabel.textColor = .gray
        cell.arrowImageView.backgroundColor = .gray
        cell.arrowImageView.image = nil
    }
}
