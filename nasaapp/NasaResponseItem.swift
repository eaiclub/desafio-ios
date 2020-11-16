import Foundation

struct NasaResponseItem: Decodable {
    var copyright: String?
    let date: String
    let explanation: String
    let hdurl: URL?
    let media_type: String
    let service_version: String
    let title: String
    let url: URL
}
