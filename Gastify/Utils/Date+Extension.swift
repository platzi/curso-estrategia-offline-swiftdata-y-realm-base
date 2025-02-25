//
//  Date+Extenssion.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//
import Foundation

extension Date {
    func showText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
