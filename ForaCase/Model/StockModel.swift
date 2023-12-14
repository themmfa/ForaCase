//
//  StockModel.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

// MARK: - Stocks
struct Stocks: Codable {
    let mypageDefaults: [Stock]?
    let mypage: [FilterParameters]?
}

// MARK: - Mypage
struct FilterParameters: Codable {
    let name, key: String?
}

// MARK: - MypageDefault
struct Stock: Codable {
    let cod, gro, tke, def,clo,pdd,las: String?
}
