//
//  UserDefaultsNames.swift
//  DireWalk
//
//  Created by Masashi Aso on 2019/08/30.
//  Copyright © 2019 麻生昌志. All rights reserved.
//

import UIKit

fileprivate typealias Key = UserDefaultTypedKey

extension UserDefaultTypedKeys {
    static let place = Key<Place?>("place")
    static let favoritePlaces = Key<Set<Place>>("favoritePlaces")
    
    // MARK: ViewSettings
    static let arrowImageName = Key<Settings.ArrowImage>("arrowImageName")
    static let showFar = Key<Bool>("showFar")
    static let arrowColor = Key<CGFloat>("arrowColorWhite")
    static let isAlwaysDarkAppearance = Key<Bool>("isAlwaysDarkAppearance")
    
    static let date = Key<Date>("date")
    static let usingTimes = Key<Int>("usingTimes")
}
