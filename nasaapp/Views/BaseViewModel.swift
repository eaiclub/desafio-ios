import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModelContract {
    var onError: Driver<ServiceError> { get }
    func handleError(error: Error)
}

class BaseViewModel: BaseViewModelContract {
    
    internal let disposeBag = DisposeBag()
    private let handleError = HandleError()
    private let _onError = PublishSubject<ServiceError>()
    var onError: Driver<ServiceError> {
        return _onError.asDriver(onErrorJustReturn: .none)
    }

    func handleError(error: Error) {
        //This Line - Add CrashLytics or Any Event Crash Tracker you want
                                
        let responseError = handleError.handle(with: error)
        print(responseError.errorMessage)
        self._onError.onNext(responseError)
    }
    
}
