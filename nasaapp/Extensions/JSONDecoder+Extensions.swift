import Foundation

extension JSONDecoder {
    
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .iso8601
        /*decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase*/
        return decoder
    }
    
    static var noTimezone: JSONDecoder {
        let decoder = JSONDecoder()
        /*decoder.dateDecodingStrategy = .formatted(DateFormatter.dateUTC)
        decoder.keyDecodingStrategy = .convertFromSnakeCase*/
        return decoder
    }
}
