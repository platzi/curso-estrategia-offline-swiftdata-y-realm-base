//
//  RecordCellViewModel.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

struct RecordCellViewModel {

    private let record: Record

    init(record: Record) {
        self.record = record
    }

    var title: String {
        record.title
    }

    var date: String {
        record.date.showText()
    }

    var amount: String {
        "$\(record.amount.toMoneyAmount())"
    }

    var type: RcordType {
        record.type
    }
}
