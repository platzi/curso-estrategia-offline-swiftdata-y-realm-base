//
//  FilterItem.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

enum FilterItem: Identifiable {
    var id: Self { self }
    case today
    case week
    case month
    case year

    var label: String {
        switch self {
        case .today: return "Hoy"
        case .week: return "Esta semana"
        case .month: return "Este mes"
        case .year: return "Último año"
        }
    }
}
