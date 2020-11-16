import Foundation
import RxSwift
import RxCocoa
import Moya

protocol NasaServiceContract {
    func getNasaItem(apiKey: String, start_date: String, end_date: String, hdUrlImage: Bool) -> Single<[NasaResponseItem]>
}

class NasaService: NasaServiceContract {
    
    private let provider = ApiProvider<NasaAPI>()
    private let providerMock = ApiProvider<NasaAPI>(stub: true)
    
    func getNasaItem(apiKey: String, start_date: String, end_date: String, hdUrlImage: Bool) -> Single<[NasaResponseItem]> {
        return self.provider
            .rx
            .request(.getNasaItem(apiKey: apiKey, start_date: start_date, end_date: end_date, hdUrlImage: hdUrlImage))
            .mapDefault([NasaResponseItem].self)
    }
    
}
