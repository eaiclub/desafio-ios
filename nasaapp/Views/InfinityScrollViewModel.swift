import Foundation
import RxSwift
import RxCocoa

class InfinityScrollViewModel: BaseViewModel {
    
    struct Constants {
        static let API_KEY = ""
        static let date = "2020-11-12"
        static let hdUrlImage = false
    }
    
    private let repository: NasaRepository
    private let nasaService: NasaService
    
    private let _reload = PublishSubject<()>()
    var reload: Driver<()> {
        return self._reload.asDriver(onErrorJustReturn: ())
    }
    
    init(repository: NasaRepository, service: NasaService) {
        self.repository = repository
        self.nasaService = service
    }
    
    func fetchObject() {
        //TODO - shimmer - loading method to be add
        self.repository
            .getNasaItem(apiKey: "DEMO_KEY", date: "2020-11-12", hdUrlImage: true)
            .subscribe(onSuccess: { object in
                print(object)
                self._reload.onNext(())
            }, onError: handleError(error:))
            .disposed(by: self.disposeBag)
    }
}
