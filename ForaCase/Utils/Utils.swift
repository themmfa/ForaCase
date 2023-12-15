//
//  Utils.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    private init(){}
    
    func getNewData(stocks:[Stock]?,newStocks:[UpdatedStockInfo]?)->[Stock]{
        var updatedList:[Stock] = []
        for stock in stocks ?? [] {
            for newStock in newStocks ?? [] {
                if stock.tke == newStock.tke {
                    let newestStock = Stock(cod: stock.cod, gro: stock.gro, tke: stock.tke, def: stock.def, clo: newStock.clo, flo: newStock.flo, cei: newStock.cei, pdd: newStock.pdd, low: newStock.low, sel: newStock.sel, buy: newStock.buy, ddi: newStock.ddi, hig: newStock.hig, las: newStock.las, pdc: newStock.pdc,gco: stock.gco,difference: stock.difference)
                    updatedList.append(newestStock)
                }
            }
        }
        return updatedList
    }
    
    func convertToDouble(doubleString:String?)->Double?{
        guard let value = doubleString else{return nil}
        let replacedString = value.replacingOccurrences(of: ",", with: ".")
        return Double(replacedString)
    }
    
    func getSelectedItemValue(selectedItemKey: String, homeViewModel: HomeViewModel, index: Int) -> String {
        let stock = homeViewModel.allStocks[index]
        var str: String = " - "

        switch selectedItemKey {
        case "las": str = stock.las ?? str
        case "pdd": str = "%\(stock.pdd ?? str)"
        case "ddi": str = stock.ddi ?? str
        case "low": str = stock.low ?? str
        case "high": str = stock.hig ?? str
        case "buy": str = stock.buy ?? str
        case "sel": str = stock.sel ?? str
        case "pdc": str = stock.pdc ?? str
        case "cei": str = stock.cei ?? str
        case "flo": str = stock.flo ?? str
        case "gco": str = stock.gco ?? str
        default: str = stock.las ?? str
        }

        return str
    }
}
