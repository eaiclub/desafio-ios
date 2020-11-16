//
//  NetworkConfig.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import Foundation

// MARK: - Environment
/**
 Enum dos environments e suas respectivas urls
 - Author:
 Alexandre Furquim
 */
public enum Environment: String {
    ///Ambiente de desenvolvimento
    case develop
    ///Ambiente de teste
    case qa
    ///Ambiente de produção
    case prod
}
//MARK: - NetworkConfig
/**
 Classe responsável pela configuração do ambiente e EntryPoint
 - Author:
 Alexandre Furquim
 */
public class NetworkConfig {
    ///Variavel de ambiente
    var environment: Environment?

    ///Constante responsável pela instancia unica da classe NetworkConfig
    public static let shared = NetworkConfig()
    ///Constante responsável pela instancia unica do bundle
    private let bundle = Bundle(for: NetworkConfig.self)
    
    ///Init da classe
    public init() {}
    // MARK: setEnvironment
    /**
     Função responsável por configurar o ambiente
     - Author:
     Alexandre Furquim
     - parameters:
     - environment: Variável do ambiente a ser configurado
     */
    public func setEnvironment(_ environment: Environment) {
        NetworkConfig.shared.environment = environment
    }
            
}
