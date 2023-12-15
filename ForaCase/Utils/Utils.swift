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
                    let newestStock = Stock(cod: stock.cod, gro: stock.gro, tke: stock.tke, def: stock.def, clo: newStock.clo, flo: newStock.flo, cei: newStock.cei, pdd: newStock.pdd, low: newStock.low, sel: newStock.sel, buy: newStock.buy, ddi: newStock.ddi, hig: newStock.hig, las: newStock.las, pdc: newStock.pdc,gco: stock.gco)
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
    
    func getSelectedItemValue(selectedItemKey: String, homeViewModel: HomeViewModel, index: Int) -> (Double?, String) {
        let stock = homeViewModel.allStocks[index]

        var dou: Double?
        var str: String = " - "

        switch selectedItemKey {
        case "las": (dou, str) = (convertToDouble(doubleString: stock.las), stock.las ?? str)
        case "pdd": (dou, str) = (convertToDouble(doubleString: stock.pdd), "%\(stock.pdd ?? str)")
        case "ddi": (dou, str) = (convertToDouble(doubleString: stock.ddi), stock.ddi ?? str)
        case "low": (dou, str) = (convertToDouble(doubleString: stock.low), stock.low ?? str)
        case "high": (dou, str) = (convertToDouble(doubleString: stock.hig), stock.hig ?? str)
        case "buy": (dou, str) = (convertToDouble(doubleString: stock.buy), stock.buy ?? str)
        case "sel": (dou, str) = (convertToDouble(doubleString: stock.sel), stock.sel ?? str)
        case "pdc": (dou, str) = (convertToDouble(doubleString: stock.pdc), stock.pdc ?? str)
        case "cei": (dou, str) = (convertToDouble(doubleString: stock.cei), stock.cei ?? str)
        case "flo": (dou, str) = (convertToDouble(doubleString: stock.flo), stock.flo ?? str)
        case "gco": (dou, str) = (convertToDouble(doubleString: stock.gco), stock.gco ?? str)
        default: (dou, str) = (convertToDouble(doubleString: stock.las), stock.las ?? str)
        }

        return (dou, str)
    }
}
