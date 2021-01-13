//
//  FeedPresenter.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import Foundation

final class FeedPresenter: Presenter {

    private let nasaService: NasaServiceProtocol
    private let currentDate: Date
    private let offset = 5

    private var celestialBodies: [CelestialBody] = []

    weak var view: FeedViewProtocol?

    init(nasaService: NasaServiceProtocol = NasaService(), currentDate: Date = Date()) {
        self.nasaService = nasaService
        self.currentDate = currentDate
    }

    func fetchBodies() {
        let date = getDate(from: celestialBodies.last?.date) ?? currentDate

        var dates = getPreviousDates(of: date)
        dates.reverse()

        nasaService.fetchCelestialBodies(for: dates) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bodies):
                self.celestialBodies.append(contentsOf: bodies.reversed())
                self.view?.reload(indexes: self.getIndexPathsToInsert(bodies))
            case .failure(let error):
                self.view?.failedToFetchNewItems(error: error)
            }
        }
    }

    func checkPagination(for index: IndexPath) {
        if index.row == celestialBodies.count - offset {
            fetchBodies()
        }
    }

    func getDetailPresenter(for indexPath: IndexPath) -> DetailPresenter {
        DetailPresenter(body: celestialBodies[indexPath.row])
    }

    private func getPreviousDates(of date: Date) -> [Date] {
        var dates: [Date] = []

        //if date is equal to current date should include it iterating from 0 to 10, otherwise 1 to 11
        let lowerBound = date == currentDate ? 0 : 1
        let upperBound = date == currentDate ? offset : offset + 1
        
        for index in lowerBound..<upperBound {
            if let previousDate = getDate(for: index, relativeTo: date) {
                dates.append(previousDate)
            }
        }

        return dates
    }

    private func getDate(from string: String?) -> Date? {
        guard let text = string else { return nil }

        return DateFormatter.current.date(from: text)
    }

    private func getDate(for index: Int, relativeTo date: Date) -> Date? {
        Calendar.current.date(byAdding: .day, value: -index, to: date)
    }

    func numberOfItems() -> Int {
        celestialBodies.count
    }

    func item(for index: Int) -> CelestialBody {
        celestialBodies[index]
    }

    ///due to pagination, we only insert the new rows instead of reload all table
    private func getIndexPathsToInsert(_ newBodies: [CelestialBody]) -> [IndexPath] {
       let startIndex = celestialBodies.count - newBodies.count
       let endIndex = startIndex + newBodies.count
       return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
