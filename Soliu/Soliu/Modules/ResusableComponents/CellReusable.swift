//
//  CellReusable.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/22/21.
//

import Foundation

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
         String(describing: self)
    }
}
