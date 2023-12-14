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
                            let previousLast = allStocks[index].las == nil ? "0.0" : allStocks[index].las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                            let currentLast = currentStock.las == nil ? "0.0" : currentStock.las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
                            let difference = (Double(previousLast) ?? 0.0) - (Double(currentLast) ?? 0.0)
                            let newestStock = Stock(cod: currentStock.cod,
                                                    gro: currentStock.gro,
                                                    tke: currentStock.tke,
                                                    def: currentStock.def,
                                                    clo: currentStock.clo,
                                                    pdd: currentStock.pdd,
                                                    las: currentStock.las,
                                                    difference: difference)
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
