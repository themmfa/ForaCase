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
    var allStocks:[Stock]?
    
    private let financeApiService:FinanceApiService =  FinanceApiService()
    
    func getAllStocks() {
        Task {
            do {
                allStocks = try await financeApiService.getAllStocks()
                delegate?.getAllStocks(ApiResponse(isSuccess: true))
            } catch {
                delegate?.getAllStocks(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }
}
