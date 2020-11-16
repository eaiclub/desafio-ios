import Foundation
import RxSwift
import RxCocoa

class InfinityScrollViewModel: BaseViewModel {
    
    struct Constants {
        static let API_KEY = "DEMO_KEY"
        static let hdUrlImage = true
        static let numberOfItems = 10
    }
    
    private let repository: NasaRepository
    private let nasaService: NasaService
    
    var items : [NasaResponseItem] = []
    
    private var isLoading = false
    private var currentStartDate = Date()
    private var currentEndDate = Date()
    
    private let _reload = PublishSubject<()>()
    var reload: Driver<()> {
        return self._reload.asDriver(onErrorJustReturn: ())
    }
    
    init(repository: NasaRepository, service: NasaService) {
        self.repository = repository
        self.nasaService = service
    }
    
    func setupInitialDates() {
        currentEndDate = Date()
        currentStartDate = getDateOffsetBy(date: currentEndDate, days: Constants.numberOfItems)
        //print("EndDate: \(convertDateToString(date: currentEndDate)) StartDate: \(convertDateToString(date: currentStartDate))")
    }
    
    func fetchObject() {
        guard !isLoading else {
          return
        }
        isLoading = true
        //TODO - shimmer - loading method to be add
        self.repository
            .getNasaItem(apiKey: Constants.API_KEY, start_date: currentStartDate, end_date: currentEndDate, hdUrlImage: Constants.hdUrlImage)
            .subscribe(onSuccess: { object in
                self.items.append(contentsOf: object)
                self.setupNewStartAndEndDates()
                self.isLoading = false
                self._reload.onNext(())
            }, onError: { error in
                self.isLoading = false
                self.handleError(error: error)
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupNewStartAndEndDates() {
        currentEndDate = getDateOffsetBy(date: currentEndDate, days: 11)
        currentStartDate = getDateOffsetBy(date: currentStartDate, days: 11)
        //print("EndDate: \(convertDateToString(date: currentEndDate)) StartDate: \(convertDateToString(date: currentStartDate))")
    }
    
    func getDateOffsetBy(date: Date, days: Int) -> Date {
        guard let pastDate = Calendar.current.date(byAdding: .day, value: -days, to: date) else { return Date() }
        return pastDate
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getNumberOfRows()-> Int {
        return items.count+1
    }
    
    func fetchObjectOnWillDisplay(indexPath: IndexPath) {
        if indexPath.item == items.count-1 {
            fetchObject()
        }
    }
}
