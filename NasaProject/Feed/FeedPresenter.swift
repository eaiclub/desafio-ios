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
    private let offset = 10

    private var celestialBodies: [CelestialBody] = []

    init(nasaService: NasaServiceProtocol = NasaService(), currentDate: Date = Date()) {
        self.nasaService = nasaService
        self.currentDate = currentDate


        NasaService().fetchCelestialBody(for: Date()) { result in
            switch result {
            case .success(let body):
                print(body)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchBodies() {
        let date = getDate(from: celestialBodies.last?.date) ?? currentDate

        let dates = getPreviousDates(of: date)

        nasaService.fetchCelestialBodies(for: dates) { [weak self] result in
            switch result {
            case .success(let bodies):
                self?.celestialBodies.append(contentsOf: bodies)
                print(bodies)
            case .failure(let error):
                print(error)
            }
        }
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
}
