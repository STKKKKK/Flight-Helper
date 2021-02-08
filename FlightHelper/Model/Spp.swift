//
//  spp.swift
//  spp
//
//  Created by mac on stopNumber21/2/2.
//

import Foundation

class Spp{
    
    let cityNumber = 16
    var source:Int
    var destination:Int
    
    var map = [[Int]](repeating: [Int](repeating: 0, count:16), count:16)
    var visit = [Int] (repeating:0 ,count:16)
    var precursor = [Int] (repeating:0, count:16)
    
    
    func dj() -> Int{
        var current = source
        var dis = [Int] (repeating: 999999, count:cityNumber)
        
        dis[current] = 0
        visit[current] = 1
        precursor[current] = -1
        while (visit.contains(0)){
            for i in 0..<cityNumber{
                if (map[current][i] + dis[current])<dis[i] && map[current][i] != 0{
                    dis[i] = map[current][i] + dis[current]
                    precursor[i] = current
                    }
            }
            var temp:Int = 999999
            var next:Int = 0
            for i in 0..<cityNumber{
                if visit[i] == 0 && dis[i] < temp{
                    temp = dis[i]
                    next = i
                }
            }
            visit[next] = 1
            current = next
        }
        return dis[destination]
    }
       
    func shortway() -> String {
        var s:String = ""
        var index:Int = destination
        s = s + DefaultData.cities[index]
        index = precursor[index]
        
        while index != -1{
            s = s + "->" + DefaultData.cities[index]
            index = precursor [index]
        }
        return s
    }
    
    init(source:Int, destination:Int){
        self.source = destination
        self.destination = source
        
        let dbManager = DBManager.shareInstance()
        let flights = dbManager.retrieveAll()
        for flight in flights {
            if flight.price < map[flight.originID][flight.destinationID] || map[flight.originID][flight.destinationID] == 0 {
                map[flight.originID][flight.destinationID] = flight.price
            }
        }
    }

}

