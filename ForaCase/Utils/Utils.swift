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
    
    func getSelectedItemValue(selectedItemKey:String,homeViewModel:HomeViewModel,index:Int)->(Double?,String){
        var dou:Double?
        var str:String = "0.0"
        switch selectedItemKey {
        case "las":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].las)
            str = homeViewModel.allStocks[index].las ?? " - "

        case "pdd":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].pdd)
            str = "%\(String(describing: homeViewModel.allStocks[index].pdd ?? " - "))"
        case "ddi":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].ddi)
            str = homeViewModel.allStocks[index].ddi ?? " - "
        
        case "low":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].low)
            str = homeViewModel.allStocks[index].low ?? " - "
            
        case "high":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].hig)
            str = homeViewModel.allStocks[index].hig ?? " - "
            
        case "buy":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].buy)
            str = homeViewModel.allStocks[index].buy ?? " - "
        case "sel":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].sel)
            str = homeViewModel.allStocks[index].sel ?? " - "
        case "pdc":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].pdc)
            str = homeViewModel.allStocks[index].pdc ?? " - "
        case "cei":
             dou = convertToDouble(doubleString: homeViewModel.allStocks[index].cei)
            str = homeViewModel.allStocks[index].cei ?? " - "
        case "flo":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].flo)
            str = homeViewModel.allStocks[index].flo ?? " - "
        case "gco":
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].gco)
            str = homeViewModel.allStocks[index].gco ?? " - "
        default:
            dou = convertToDouble(doubleString: homeViewModel.allStocks[index].las)
            str = homeViewModel.allStocks[index].las ?? " - "
        }
        
        return (dou,str)
    }
}
