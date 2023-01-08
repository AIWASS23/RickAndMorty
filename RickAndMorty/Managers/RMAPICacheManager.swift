//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

/*
    NSCache é um objeto em Swift que é usado para armazenar dados em cache de maneira eficiente. Ele é uma 
    classe do Foundation que se comporta de maneira semelhante a um dicionário, permitindo que você 
    armazene e recupere objetos usando chaves. No entanto, ao contrário de um dicionário, o NSCache é 
    otimizado para lidar com grandes quantidades de dados e tem mecanismos de limpeza de cache automáticos 
    para remover objetos menos usados quando o sistema precisa de mais memória.

    Para usar o NSCache, basta criar uma instância dele e chamar os métodos "setObject" e "objectForKey" 
    para armazenar e recuperar objetos, respectivamente. Aqui está um exemplo de como fazer isso:

    let cache = NSCache<NSString, NSData>()

    let data = Data(...)
    let key = "key" as NSString

    cache.setObject(data as NSData, forKey: key)

    if let cachedData = cache.object(forKey: key) as Data? {
        // Faz algo com os dados em cache
    }
    Você também pode especificar um limite de memória máximo para o cache e um tamanho de objeto máximo, 
    se desejar. Isso pode ser útil para garantir que o cache não consuma muita memória e não armazena 
    objetos muito grandes.
    -------------------------------------------------------------------------------------------------------
    NSData é um tipo de objeto em Swift que representa uma sequência de bytes. Ele é uma classe do 
    Foundation que é usada para armazenar e manipular dados binários, como arquivos de imagem ou áudio. 
    NSData é uma classe "toll-free bridged" com a classe Data do Swift, o que significa que você pode 
    usar NSData como se fosse um Data e vice-versa.

    Para criar uma instância de NSData, você pode usar um dos inicializadores da classe, como por exemplo 
    "init(contentsOf:)", que permite criar uma instância a partir de um arquivo em disco, ou "init(data:)", 
    que permite criar uma instância a partir de outra instância de Data ou NSData. 

    EXEMPLO:
    let fileURL = URL(fileURLWithPath: "arquivo.txt")
    let data = try NSData(contentsOf: fileURL, options: .mappedIfSafe)

    let swiftData = Data(...)
    let nsData = NSData(data: swiftData)

    Uma vez que você tenha uma instância de NSData, você pode acessar os bytes que ela contém usando o 
    método "bytes" ou "getBytes(_:length:)". Você também pode criar uma instância de String a partir 
    dos bytes de NSData usando o método "init(data:encoding:)", como no exemplo a seguir:

    let string = String(data: nsData as Data, encoding: .utf8)

    Além disso, você pode usar os métodos "write(to:options:)" ou "write(toFile:options:)" para gravar 
    os bytes de NSData em um arquivo em disco.

    NSData também possui métodos para realizar operações de criptografia, como criptografia e 
    decriptografia de dados usando cifras simétricas ou assimétricas. Você também pode usar o NSData 
    para criar instâncias de outros tipos de objetos, como por exemplo NSImage (em macOS) ou UIImage (em iOS).
*/

import Foundation

final class RMAPICacheManager {

    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]

    init() {
        setUpCache()
    }

    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }

    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }

    private func setUpCache() {
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}

/*
    RMAPICacheManager é uma classe final em Swift que gerencia o cache de respostas de uma API. Ela possui 
    uma propriedade de instância chamada "cacheDictionary" que é um dicionário que mapeia os endpoints 
    da API para objetos do tipo NSCache.

    A classe possui um inicializador que chama a função "setUpCache" que inicializa o cacheDictionary 
    com um objeto NSCache vazio para cada endpoint da API. A classe possui uma função "cachedResponse" 
    que retorna os dados armazenados em cache para o endpoint e a URL especificados, se eles existirem. 
    Ela também possui uma função "setCache" que armazena os dados especificados em cache para o endpoint 
    e a URL especificados.
*/
