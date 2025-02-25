//
//  RecordDetailView.swift
//  Gastify
//
//  Created by Santiago Moreno on 7/01/25.
//

import SwiftUI

struct RecordDetailView: View {

    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: RecordDetailViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                RecordCellView(viewModel: RecordCellViewModel(record: self.viewModel.record))
                    .padding(.top)
                Spacer()
                HStack {
                    SecondaryButton(label: "Eliminar") {
                        self.viewModel.showDeleteRecordAlert()
                    }
                    PrimaryButton(label: "Editar") {
                        self.viewModel.updateRecord()
                    }
                }.padding()
            }
            if viewModel.loading {
                LoadingView()
            }
        }
        .alert("Eliminar registro",
               isPresented: self.$viewModel.showDeleteAlert, actions: {
            HStack {
                Button {
                    self.viewModel.showDeleteAlert = false
                } label: {
                    Text("Cancelar")
                }
                Button {
                    self.viewModel.deleteRecord {
                        dismiss()
                    }
                } label: {
                    Text("Eliminar")
                        .foregroundStyle(Color.red)
                        .fontWeight(.medium)
                }
            }
        }, message: {
            Text("¿Estas seguro que deseas eliminar este registro?")
        })
        .sheet(item: self.$viewModel.sheet) { item in
            switch item {
            case .updateRecord(let record):
                FormRecordView(viewModel: FormRecordViewModel(record: record))
            }
        }
        .navigationTitle("Detalle de registro")
    }
}

#Preview {
    let record = Record(id: "1",
                        title: "Preview new record",
                        date: Date(),
                        type: .income,
                        amount: 1000)
    return RecordDetailView(viewModel: RecordDetailViewModel(record: record))
}
