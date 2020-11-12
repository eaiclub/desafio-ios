import Foundation
import RxSwift
import RxCocoa
import Moya

protocol NasaServiceContract {
    func getNasaItem(apiKey: String, date: String, hdUrlImage: Bool) -> Single<NasaResponse>
}

class OpportunityService: NasaServiceContract {
    
    private let provider = ApiProvider<NasaAPI>()
    private let providerMock = ApiProvider<NasaAPI>(stub: true)
    
    func getNasaItem(apiKey: String, date: String, hdUrlImage: Bool) -> Single<NasaResponse> {
        return self.provider
            .rx
            .request(.getNasaItem(apiKey: apiKey, date: date, hdUrlImage: hdUrlImage))
            .mapDefault(NasaResponse.self)
    }
    
}
