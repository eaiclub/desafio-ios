import Foundation

struct NasaResponse: Decodable {
    let data: NasaResponseData
}

struct NasaResponseData: Decodable {
    let submission: String
    let widget: String
    let lead: String
}
