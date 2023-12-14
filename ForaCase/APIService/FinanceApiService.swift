//
//  APIService.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

class FinanceApiService {
    private let baseUrl:String = "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/"
    
    func getRequest(url:String)->URLRequest?{
        guard let url = URL(string: "\(baseUrl)\(url)") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func getAllStocks() async throws -> Stocks? {
        guard let request = getRequest(url: "ForeksMobileInterviewSettings") else {return nil}
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(Stocks.self, from: data)
            return response
        } catch {
            throw error
        }
    }
    
    func seperateAllString(stockList:[Stock]) -> String? {
        guard let tkes = stockList.map({ $0.tke }) as? [String] else {return nil }
        let resultString = tkes.joined(separator: "~")
        return resultString
    }
    
    func getSpecificStock(stockList:[Stock]) async throws -> Stock? {
        guard let keys = seperateAllString(stockList: stockList) else { return nil}
        guard let request = getRequest(url: "ForeksMobileInterview?fields=pdd,las&stcs=\(keys)") else {return nil}
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(Stock.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
