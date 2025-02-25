//
//  MockRecordsHelper.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import Foundation

struct MockRecordsHelper {
    static func mockRecords(count: Int = 20) -> [Record] {
        let incomeCategories: [(title: String, range: ClosedRange<Double>)] = [
            ("Salario", 2000...5000),
            ("Freelance", 500...2000),
            ("Dividendos", 100...1000),
            ("Venta", 50...500),
            ("Reembolso", 20...200),
            ("Inversión", 1000...3000),
            ("Bonus", 300...1000),
            ("Regalo", 50...300)
        ]

        let outcomeCategories: [(title: String, range: ClosedRange<Double>)] = [
            ("Supermercado", 50...200),
            ("Restaurante", 20...100),
            ("Transporte", 10...50),
            ("Netflix", 10...20),
            ("Gimnasio", 30...80),
            ("Ropa", 50...300),
            ("Gasolina", 40...100),
            ("Internet", 40...80),
            ("Luz", 50...150),
            ("Agua", 20...60),
            ("Teléfono", 30...70)
        ]

        let calendar = Calendar.current
        let now = Date()

        return (0..<count).map { _ in
            let type = Double.random(in: 0...1) < 0.6 ? RcordType.outcome : RcordType.income

            let category = type == .income ?
            incomeCategories.randomElement()! :
            outcomeCategories.randomElement()!

            let randomDays = Int.random(in: -60...0)
            let randomDate = calendar.date(byAdding: .day, value: randomDays, to: now)!

            let amount = Double.random(in: category.range).rounded()

            return Record(
                id: UUID().uuidString,
                title: category.title,
                date: randomDate,
                type: type,
                amount: amount
            )
        }
        .sorted { $0.date > $1.date }
    }

    static func applyFilter(to records: [Record], by filter: FilterItem) -> [Record] {
        let calendar = Calendar.current
        let now = Date()

        return records.filter { record in
            switch filter {
            case .today:
                return calendar.isDate(record.date, inSameDayAs: now)

            case .week:
                let currentWeekComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)
                let recordWeekComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: record.date)

                return currentWeekComponents.yearForWeekOfYear == recordWeekComponents.yearForWeekOfYear &&
                currentWeekComponents.weekOfYear == recordWeekComponents.weekOfYear

            case .month:
                return calendar.component(.month, from: record.date) == calendar.component(.month, from: now) &&
                calendar.component(.year, from: record.date) == calendar.component(.year, from: now)

            case .year:
                let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
                return record.date >= oneYearAgo && record.date <= now
            }
        }
    }
}
