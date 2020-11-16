import Foundation
import RxSwift
import RxCocoa

class InfinityScrollViewModel: BaseViewModel {
    
    struct Constants {
        static let API_KEY = "DEMO_KEY"
        static let hdUrlImage = true
    }
    
    private let repository: NasaRepository
    private let nasaService: NasaService
    
    var items : [NasaResponseItem] = []
    
    private let _reload = PublishSubject<()>()
    var reload: Driver<()> {
        return self._reload.asDriver(onErrorJustReturn: ())
    }
    
    init(repository: NasaRepository, service: NasaService) {
        self.repository = repository
        self.nasaService = service
    }
    
    func fetchObject(dateOffset: Int) {
        //TODO - shimmer - loading method to be add
        self.repository
            .getNasaItem(apiKey: Constants.API_KEY, date: getDate(offsetInDays: dateOffset), hdUrlImage: Constants.hdUrlImage)
            .subscribe(onSuccess: { object in
                self.items.append(object)
                self._reload.onNext(())
            }, onError: handleError(error:))
            .disposed(by: self.disposeBag)
    }
    
    func getDate(offsetInDays: Int) -> String {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let futureDate = Calendar.current.date(byAdding: .day, value: -offsetInDays, to: currentDateTime)
        let dateString = dateFormatter.string(from: futureDate!)
        return dateString
    }
}
