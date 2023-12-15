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
    var cod, gro, tke, def,clo, flo, cei: String?
    let pdd, low, sel, buy: String?
    let ddi, hig, las, pdc, gco: String?
    let difference:Double?
}

// MARK: - Stocks
struct StockInfoList: Codable {
    let l: [UpdatedStockInfo]?
    let z: String?
}

// MARK: - L
struct UpdatedStockInfo: Codable {
    let tke, clo, flo, cei: String?
    let pdd, low, sel, buy: String?
    let ddi, hig, las, pdc: String?
}
