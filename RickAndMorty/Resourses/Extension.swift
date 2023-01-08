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
