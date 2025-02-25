//
//  RecordCellView.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

struct RecordCellView: View {

    let viewModel: RecordCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Circle().fill(self.iconBackground)
                    IconImage(self.icon, color: Color.white)
                }
                .frame(width: 32, height: 32)
                VStack(alignment: .leading, spacing: 4) {
                    Text(self.viewModel.title)
                        .font(.label(weight: .medium))
                        .foregroundStyle(Color.dark)
                    Text(self.viewModel.date)
                        .font(.label(size: .small))
                        .foregroundStyle(Color.tertiary)
                }
                Spacer()
                Text(self.viewModel.amount)
                    .font(.title(size: .medium))
                    .foregroundStyle(Color.dark)
            }.padding(.horizontal)
            Divider()
        }
    }

    var icon: CustomIcon {
        self.viewModel.type == .income ? .arrowUp : .arrowDown
    }

    var iconBackground: Color {
        self.viewModel.type == .income ? .primary : .secondary
    }
}

#Preview {
    let income = Record(id: "1", title: "Primera quincena de enero", date: Date(), type: .income, amount: 10.8778)
    let outcome = Record(id: "2", title: "Gasto no 1", date: Date(), type: .outcome, amount: 100)
    let outcome1 = Record(id: "3", title: "Gasto no 2", date: Date(), type: .outcome, amount: 10000)
    let outcome2 = Record(id: "4", title: "Gasto no 3", date: Date(), type: .outcome, amount: 100500)
    let outcome3 = Record(id: "5", title: "Gasto no 4", date: Date(), type: .outcome, amount: 1000000)
    let outcome4 = Record(id: "6", title: "Gasto no 4", date: Date(), type: .outcome, amount: 1000000000)
    Group {
        RecordCellView(viewModel: RecordCellViewModel(record: income))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome1))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome2))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome3))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome4))
    }.padding()
}
