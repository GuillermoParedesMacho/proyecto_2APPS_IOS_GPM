//
//  DBAPIController.swift
//  proyectoFinCurso2APPSGPM
//
//  Created by user177872 on 2/25/21.
//

import Foundation

class DBAPIControlle{
    
    //data needed for operations
    static private let urlApi = "";
    static private var token = "";
    
    //operations
    static public func logIn(){
        //TODO preparar request
        var url = urlApi
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                print("Algo fue mal")
                return
            }
            
        }).resume()
    }
    
    //functions for operations
    static private func updateAPI(var newToken:String){
        token = newToken
    }
    
}
