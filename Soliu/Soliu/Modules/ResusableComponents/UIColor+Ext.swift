//
//  UIColor+Ext.swift
//  Soliu
//
//  Created by JungpyoHong on 8/27/21.
//
import UIKit
import Foundation



// MARK: - How to use extension

/*
 UIColor(hexaRGB: "#00F")                  // r 0.0 g 0.0 b 1.0 a 1.0
 UIColor(hexaRGB: "#00F", alpha: 0.5)      // r 0.0 g 0.0 b 1.0 a 0.5

 UIColor(hexaRGB: "#0000FF")               // r 0.0 g 0.0 b 1.0 a 1.0
 UIColor(hexaRGB: "#0000FF", alpha: 0.5)   // r 0.0 g 0.0 b 1.0 a 0.5

 UIColor(hexaRGBA: "#0000FFFF")            // r 0.0 g 0.0 b 1.0 a 1.0
 UIColor(hexaRGBA: "#0000FF7F")            // r 0.0 g 0.0 b 1.0 a 0.498

 UIColor(hexaARGB: "#FF0000FF")            // r 0.0 g 0.0 b 1.0 a 1.0
 UIColor(hexaARGB: "#7F0000FF")            // r 0.0 g 0.0 b 1.0 a 0.498
 */


extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }

    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}

