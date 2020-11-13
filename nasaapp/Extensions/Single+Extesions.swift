import Foundation
import RxSwift
import RxCocoa
import Moya

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapDefault<D: Decodable>(_ type: D.Type,
                                  atKeyPath keyPath: String? = nil,
                                  decoder: JSONDecoder? = nil) -> Single<D> {
        let customDecoder = decoder ?? JSONDecoder()
        return flatMap { .just(try $0.map(type, atKeyPath: keyPath,
                                          using: customDecoder,
                                          failsOnEmptyData: true)) }
    }
}
