//
//  Utils.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    private init(){
        
    }
    
    func getNewData(stocks:[Stock]?,newStocks:[UpdatedStockInfo]?)->[Stock]{
        var updatedList:[Stock] = []
        for stock in stocks ?? [] {
            for newStock in newStocks ?? [] {
                if stock.tke == newStock.tke {
                    let newestStock = Stock(cod: stock.cod, gro: stock.gro, tke: stock.tke, def: stock.def, clo: newStock.clo, pdd: newStock.pdd, las: newStock.las)
                    updatedList.append(newestStock)
                }
            }
        }
        return updatedList
    }
}
