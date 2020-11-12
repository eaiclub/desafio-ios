import Foundation
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait {
    
    func defaultLoading(_ isloading: PublishSubject<Bool>) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            isloading.onNext(false)
        }, onError: { _ in
            isloading.onNext(false)
        }, onSubscribe: {
            isloading.onNext(true)
        })
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapDefault<D: Decodable>(_ type: D.Type,
                                  atKeyPath keyPath: String? = nil,
                                  decoder: JSONDecoder? = nil) -> Single<D> {
        let customDecoder = decoder ?? JSONDecoder.default
        return flatMap { .just(try $0.map(type, atKeyPath: keyPath,
                                          using: customDecoder,
                                          failsOnEmptyData: true)) }
    }
}
