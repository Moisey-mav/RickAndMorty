//
//  UIView+Extesion.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 19.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
