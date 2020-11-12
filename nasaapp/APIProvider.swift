import Foundation
import Moya

class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    private let enabledMock = ProcessInfo.processInfo.arguments.contains("UITest")
    private let isMockBuild = true
    private let logEnabled: Bool = true
    
    init(stub: Bool = false) {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let networkLogger = self.logEnabled ? [plugin] : []
        if self.enabledMock || stub {
            super.init(stubClosure: MoyaProvider.delayedStub(1),
                       plugins: networkLogger)
        } else {
            super.init(plugins: networkLogger)
        }
    }

    static var defaultHeader: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

