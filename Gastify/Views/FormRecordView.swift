//
//  FormRecordView.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

struct FormRecordView: View {

    @FocusState private var titleFieldIsFocused

    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: FormRecordViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                Header
                Types
                Form
                Spacer()
                FormButton
            }.padding(.vertical)
            if viewModel.loading {
                LoadingView()
            }
        }
        .onAppear {
            self.titleFieldIsFocused = true
        }
    }

    @ViewBuilder
    private var Header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    IconImage(.close, size: 16, color: .dark)
                }
            }
            Text("Nuevo registro")
                .font(.title(size: .large))
                .foregroundStyle(Color.dark)
        }.padding(.horizontal)
    }

    @ViewBuilder
    private var Types: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 8)  {
                ForEach(self.viewModel.types) { type in
                    Pill(label: type.label,
                         color: type == .income ? .primary : .secondary,
                         status: self.viewModel.isSelectedType(type) ? .selected : .unselected) {
                        self.viewModel.typeSelected(type)
                    }
                }
            }.padding(.horizontal)
        }
    }

    @ViewBuilder
    private var Form: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Titulo del registro",
                      text: self.$viewModel.title)
            .textFieldStyle(.roundedBorder)
            .focused(self.$titleFieldIsFocused)
            TextField("Cantidad",
                      text: self.$viewModel.amount)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .onChange(of: self.viewModel.amount) { _, newValue in
                self.viewModel.validateAndFormatAmount(newValue)
            }
        }.padding(.horizontal)
    }

    @ViewBuilder
    private var FormButton: some View {
        HStack {
            PrimaryButton(label: self.viewModel.buttonTitle,
                          disabled: self.viewModel.isButtonDisabled) {
                self.viewModel.saveNewRecord {
                    dismiss()
                }
            }
        }.padding(.horizontal)
    }
}

#Preview {
    FormRecordView(viewModel: FormRecordViewModel())
}
