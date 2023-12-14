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
                    let newestStock = Stock(cod: stock.cod, gro: stock.gro, tke: stock.tke, def: stock.def, clo: newStock.clo, pdd: newStock.pdd, las: newStock.las)
                    updatedList.append(newestStock)
                }
            }
        }
        return updatedList
    }
    
    func calculateDifference(index:Int,allStocks:[Stock],currentStock:Stock)->Double{
        let previousLast = allStocks[index].las == nil ? "0.0" : allStocks[index].las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        let currentLast = currentStock.las == nil ? "0.0" : currentStock.las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        let difference = (Double(previousLast) ?? 0.0) - (Double(currentLast) ?? 0.0)
        return difference
    }
    
    func calculateDifferencePercentage(index:Int,allStocks:[Stock],currentStock:Stock)->Double{
        let previousLast = allStocks[index].las == nil ? "0.0" : allStocks[index].las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        let currentLast = currentStock.las == nil ? "0.0" : currentStock.las!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".")
        let step1 = (Double(previousLast) ?? 0.0) - (Double(currentLast) ?? 0.0)
        let step2 = ((Double(previousLast) ?? 0.0) + (Double(currentLast) ?? 0.0))/2
        let differencePercentage = (step1/step2) * 100
        return differencePercentage
    }
    
    func getSelectedData(selectedData:String,homeViewModel:HomeViewModel,index:Int)->Double{
        if selectedData == "Fark"{
            return homeViewModel.allStocks[index].difference ?? 0.0
        }else{
            return homeViewModel.allStocks[index].differencePercentage ?? 0.0
        }
    }
}
