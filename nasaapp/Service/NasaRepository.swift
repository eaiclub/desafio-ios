import Foundation
import RxSwift

protocol NasaRepositoryContract {
    func getNasaItem(apiKey: String, date: String, hdUrlImage: Bool) -> Single<NasaResponseItem>
}

class NasaRepository: NasaRepositoryContract {
    
    let service: NasaServiceContract
    
    init(with service: NasaServiceContract) {
        self.service = service
    }
    
    func getNasaItem(apiKey: String, date: String, hdUrlImage: Bool) -> Single<NasaResponseItem> {
        return self.service
            .getNasaItem(apiKey: apiKey, date: date, hdUrlImage: hdUrlImage)
    }
    
}
