//
//  HomeViewModel.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

protocol HomeViewModelDelegate {
    func getAllStocks(_ response: ApiResponse)
}

class HomeViewModel {
    var delegate: HomeViewModelDelegate?
    var allStocks:[Stock] = []
    
    private let financeApiService:FinanceApiService =  FinanceApiService()
    
    func getAllStocks() {
        Task {
            do {
                var currentStocks = try await financeApiService.getAllStocks()
                if allStocks.isEmpty {
                    allStocks = currentStocks
                }else{
                    for currentStock in currentStocks{
                        // TODO(ferdogan): Refactor here
                        if let index = allStocks.firstIndex(where: { $0.tke == currentStock.tke }) {
                            let difference = Utils.shared.calculateDifference(index: index, allStocks: allStocks, currentStock: currentStock)
                            let differencePercentage = Utils.shared.calculateDifferencePercentage(index: index, allStocks: allStocks, currentStock: currentStock)
                            let newestStock = Stock(cod: currentStock.cod,
                                                    gro: currentStock.gro,
                                                    tke: currentStock.tke,
                                                    def: currentStock.def,
                                                    clo: currentStock.clo,
                                                    pdd: currentStock.pdd,
                                                    las: currentStock.las,
                                                    difference: difference,
                                                    differencePercentage: differencePercentage)
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
}
