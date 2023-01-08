//
//  Extension.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

/*
    A extensão adiciona uma nova função à classe UIView chamada "addSubviews" 
    que permite adicionar várias subviews ao mesmo tempo. A função é chamada passando 
    uma lista de argumentos variáveis de tipo UIView. Cada elemento da lista é adicionado 
    à view atual como uma subview usando a função addSubview().
*/
