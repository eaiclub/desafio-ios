import Foundation
import RxSwift

protocol NasaRepositoryContract {
    func getNasaItem(apiKey: String, start_date: String, end_date: String, hdUrlImage: Bool) -> Single<[NasaResponseItem]>
}

class NasaRepository: NasaRepositoryContract {
    
    let service: NasaServiceContract
    
    init(with service: NasaServiceContract) {
        self.service = service
    }
    
    func getNasaItem(apiKey: String, start_date: String, end_date: String, hdUrlImage: Bool) -> Single<[NasaResponseItem]> {
        return self.service
            .getNasaItem(apiKey: apiKey, start_date: start_date, end_date: end_date, hdUrlImage: hdUrlImage)
    }
    
}
