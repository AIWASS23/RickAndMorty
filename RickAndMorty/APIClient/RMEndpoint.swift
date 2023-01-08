//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

@frozen enum RMEndpoint: String, CaseIterable, Hashable {

    case character
    case location
    case episode
    case setting
}

/*
    A anotação "@frozen" é usada para indicar que uma estrutura ou classe não pode ser herdada. 
    Isso significa que não é possível criar uma subclasse de uma classe marcada como @frozen ou 
    usar uma estrutura marcada como @frozen como um tipo de parâmetro de classe. Isso é útil para 
    garantir que as estruturas e classes não sejam modificadas de forma inesperada por outro código, 
    o que pode levar a comportamentos inesperados e problemas de estabilidade. É importante observar 
    que a anotação @frozen só pode ser usada em estruturas e classes que são declaradas como "fixed-layout" 
    ou "públicas", o que significa que seus membros são armazenados de forma fixa em tempo de execução 
    e não podem ser adicionados ou removidos dinamicamente.

    CaseIterable é um protocolo em Swift que permite que uma enum itere sobre seus casos. Quando um 
    enum adota o protocolo CaseIterable, é possível acessar uma lista de todos os casos do enum usando 
    a propriedade "allCases". Isso pode ser útil em várias situações, como por exemplo, quando você 
    quer criar uma lista com todos os casos da enum para exibição em uma interface de usuário.
*/