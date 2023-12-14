//
//  StockModel.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

// MARK: - Stocks
struct Stocks: Codable,Equatable {
    let mypageDefaults: [Stock]?
    let mypage: [FilterParameters]?
}

// MARK: - Mypage
struct FilterParameters: Codable,Equatable {
    let name, key: String?
}

// MARK: - MypageDefault
struct Stock: Codable,Equatable {
    var cod, gro, tke, def,clo,pdd,las: String?
    var difference:Double?
    var differencePercentage:Double?
}

// MARK: - Stocks
struct StockInfoList: Codable {
    let l: [UpdatedStockInfo]?
    let z: String?
}

// MARK: - L
struct UpdatedStockInfo: Codable {
    let tke, clo, pdd, las: String?
}
