//
//  Record.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import Foundation

enum RcordType: String, Identifiable {
    var id: String { rawValue }
    case income = "INCOME"
    case outcome = "OUTCOME"

    var label: String {
        switch self {
        case .income: return "Nuevo ingreso"
        case .outcome: return "Nuevo gasto"
        }
    }
}

struct Record: Identifiable, Hashable {
    let id: String
    let title: String
    let date: Date
    let type: RcordType
    let amount: Double
}
