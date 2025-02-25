//
//  HomeView.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack(path: self.$viewModel.path) {
            GeometryReader { proxy in
                ZStack {
                    Color.white.ignoresSafeArea(.all)
                    VStack(alignment: .leading, spacing: 16) {
                        Header
                        Filters
                        SummaryCards(cardHeight: proxy.size.width/2)
                        Activities
                    }
                    if viewModel.loading {
                        LoadingView()
                    }
                }
                .navigationDestination(for: HomeNavigationRoute.self) { route in
                    switch route {
                    case .recordDetail(let record):
                        RecordDetailView(viewModel: RecordDetailViewModel(record: record))
                    }
                }
                .onAppear {
                    self.viewModel.getInitialData()
                }
                .sheet(item: self.$viewModel.sheet) { item in
                    switch item {
                    case .newRecord:
                        FormRecordView(viewModel: FormRecordViewModel())
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var Header: some View {
        VStack(alignment: .leading, spacing: 16)  {
            HStack(alignment: .center) {
                Text("Gastify")
                    .font(.title())
                    .foregroundStyle(Color.dark)
                Spacer()
                Button(action: {
                    self.viewModel.newRecord()
                }) {
                    IconImage(.plus)
                }
            }
            VStack(alignment: .leading, spacing: 0)  {
                Text("Bienvenido de nuevo.")
                    .font(.label())
                    .foregroundStyle(Color.dark)
                Text("Estas son tus finanzas de hoy")
                    .font(.label())
                    .foregroundStyle(Color.dark)
            }
        }.padding(.horizontal)
    }

    @ViewBuilder
    private var Filters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 8)  {
                IconImage(.filter)
                ForEach(self.viewModel.reorganizeFilters()) { filter in
                    Pill(label: filter.label,
                         status: self.viewModel.isFilterSelected(filter) ? .selected : .unselected) {
                        self.viewModel.filterSelected(filter)
                    }
                }
            }.padding(.horizontal)
        }
    }

    @ViewBuilder
    private func SummaryCards(cardHeight: CGFloat) -> some View {
        HStack(alignment: .top, spacing: 8) {
            BigCard(loading: self.viewModel.loadingTotals,
                    topText: "Tus ingresos",
                    bottomText: self.viewModel.totalIncomeText,
                    height: cardHeight)

            BigCard(loading: self.viewModel.loadingTotals,
                    topText: "Tus gastos",
                    bottomText: self.viewModel.totalOutcomeText,
                    height: cardHeight,
                    color: .secondary)
        }.padding(.horizontal)
    }

    @ViewBuilder
    private var Activities: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tus actividades")
                .font(.title(size: .large))
                .foregroundStyle(Color.dark)
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(self.viewModel.records) { record in
                        Button(action: {
                            self.viewModel.goToDetail(record)
                        }) {
                            RecordCellView(viewModel: RecordCellViewModel(record: record))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
