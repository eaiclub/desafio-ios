import Foundation
import Moya

enum NasaAPI {
    case getNasaItem(apiKey: String, date: String, hdUrlImage: Bool)
}

extension NasaAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.nasa.gov")!
    }
    
    var path: String {
        switch self {
        case .getNasaItem(_, _, _):
            return "/planetary/apod"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNasaItem:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getNasaItem:
            return "video".jsonData
        }
    }
    
    public var task: Task {
        switch self {
        case .getNasaItem(let apiKey, let date ,let hdUrlImage):
            return .requestParameters(parameters:
                ["api_key" : apiKey,
                "date": date,
                "hd" : hdUrlImage], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
}

extension String {
    
    var jsonData: Data {
        return Bundle.main.dataFromJsonFile(name: self)
    }
    
}

extension Bundle {
    
    func dataFromJsonFile(name: String) -> Data {
        guard let path = self.path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return Data()
        }
        return data
    }
    
}
