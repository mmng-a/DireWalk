//
//  Settings.swift
//  DireWalk
//
//  Created by Masashi Aso on 2019/09/06.
//  Copyright © 2019 麻生昌志. All rights reserved.
//

import MapKit

final class Settings {
    
    static let shared = Settings()
    private init() {}
    
    public enum ArrowImage: String, Codable, CaseIterable, UserDefaultConvertible {
        case fillLocation = "fillLocation"
        case location = "borderLocation"
        
        var name: String { self.rawValue.localized }
    }
    
    @UserDefault(.arrowImageName, defaultValue: .fillLocation)
    var arrowImage: ArrowImage
    @UserDefault(.arrowColor, defaultValue: 0.75)
    var arrowColor: CGFloat
    @UserDefault(.showDistance, defaultValue: false)
    var alwaysDontShowsDistance: Bool
//    @UserDefault(.mapType, defaultValue: .mutedStandard)
//    var mapType: MKMapType
    
}

#if canImport(UIKit)
import UIKit
#endif
@available(iOS 2.0, *)
extension Settings.ArrowImage {
    var image: UIImage {
        switch self {
        case .fillLocation:
            if #available(iOS 13, *) {
                return UIImage(systemName: "location.fill")!
            } else {
                return UIImage(named: "DirectionFill")!
            }
        case .location:
            if #available(iOS 13, *) {
                let config = UIImage.SymbolConfiguration(weight: .light)
                return UIImage(systemName: "location", withConfiguration: config)!
            } else {
                return UIImage(named: "Direction")!
            }
        }
    }
}

//#if canImport(WatchKit)
//import WatchKit
//#endif
//@available(watchOS 6.0, *)
//extension Settings.ArrowImage {
//    var image:
//}


// iOS 12でenumのCodableがうまくいかない(無理？)
// アプデした場合はnilってdefaultValueが呼ばれるから大丈夫なはず！
extension Settings.ArrowImage {
    init?(with object: Any) {
        if #available(iOS 13, *) {
            guard let data = object as? Data,
                let value = try? JSONDecoder().decode(Self.self, from: data) else {
                    return nil
            }
            self = value
        } else {
            guard let raw = object as? String else { return nil }
            let array = Self.allCases.map({$0})
            for c in array {
                if c.rawValue == raw {
                    self = c
                    return
                }
            }
            return nil
        }
    }
    
    func object() -> Any? {
        if #available(iOS 13, *) {
            return try? JSONEncoder().encode(self)
        }else {
            return rawValue
        }
    }
}
