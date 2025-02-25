//
//  HomeViewModel.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//

import Foundation

enum HomeSheet: Identifiable {
    var id: Self { self }
    case newRecord
}

enum HomeNavigationRoute: Hashable {
    case recordDetail(_ record: Record)
}

class HomeViewModel: ObservableObject {

    @Published var path = [HomeNavigationRoute]()
    @Published var sheet: HomeSheet?
    @Published var loading = false
    @Published var loadingTotals = false

    var activeFilter: FilterItem = .today
    var records: [Record] = []
    var totalIncome: Double = 0
    var totalOutcome: Double = 0
    let filters: [FilterItem] = [.today, .week, .month, .year]
    // TODO: Remplazar por BD
    let mockRecords = MockRecordsHelper.mockRecords()

    var totalIncomeText: String {
        return "$\(self.totalIncome.toMoneyAmount())"
    }

    var totalOutcomeText: String {
        return "$\(self.totalOutcome.toMoneyAmount())"
    }

    func getInitialData() {
        self.getTotals()
        self.getRecords()
    }

    func getTotals() {
        // TODO: - Cambiar esta logica para obtener la data desde un servicio de BD
        self.loadingTotals = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.totalIncome = 10000000
            self.totalOutcome = 500000
            self.loadingTotals = false
        }
    }

    func getRecords() {
        // TODO: - Cambiar esta logica para obtener la data desde un servicio de BD
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.records = MockRecordsHelper.applyFilter(to: self.mockRecords,
                                                            by: self.activeFilter)
            self.loading = false
        }
    }

    func filterSelected(_ filter: FilterItem) {
        self.activeFilter = filter
        self.getRecords()
    }

    func isFilterSelected(_ filter: FilterItem) -> Bool {
        self.activeFilter == filter
    }

    func reorganizeFilters() -> [FilterItem] {
        guard let index = filters.firstIndex(of: activeFilter),
              index != 0 else { return filters }
        var newFilters = filters
        let selectedFilter = newFilters.remove(at: index)
        newFilters.insert(selectedFilter, at: 0)
        return newFilters
    }

    func newRecord() {
        self.sheet = .newRecord
    }

    func goToDetail(_ record: Record) {
        self.path.append(.recordDetail(record))
    }
}
