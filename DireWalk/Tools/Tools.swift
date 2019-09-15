//
//  Strings.swift
//  DireWalk
//
//  Created by 麻生昌志 on 2019/03/01.
//  Copyright © 2019 麻生昌志. All rights reserved.
//

import UIKit
import MapKit

// MARK: function wait
func wait(_ waitContinuation: @escaping (() -> Bool), compleation: @escaping (() -> Void)) {
    var wait = waitContinuation()
    // 0.01秒周期で待機条件をクリアするまで待ちます。
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        while wait {
            DispatchQueue.main.async {
                wait = waitContinuation()
                semaphore.signal()
            }
            semaphore.wait()
            Thread.sleep(forTimeInterval: 0.01)
        }
        // 待機条件をクリアしたので通過後の処理を行います。
        DispatchQueue.main.async {
            compleation()
        }
    }
}

// MARK: CLPlacemark
extension CLPlacemark {
    var address: String {
        let components = [self.administrativeArea, self.locality, self.thoroughfare, self.subThoroughfare]
        return components.compactMap { $0 }.joined(separator: "")
    }
}

// MARK: String
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "localized string with \(self)")
    }
    
    var localizedYet: String {
        "Please Localize \"\(self)\""
    }
}

// MARK: Date
extension Date {
    func isSameDay(to date: Date) -> Bool {
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: self) == dateFormatter.string(from: date)
    }
}
let dateFormatter = DateFormatter()

// MARK: Array
extension Array {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// MARK: UIPageViewController
extension UIPageViewController {
    var scrollView: UIScrollView? {
        view.subviews.first { $0 is UIScrollView } as? UIScrollView
    }
}

// MARK: UISearchBar
extension UISearchBar {
    var cancelButton: UIButton? {
        value(forKey: "cancelButton") as? UIButton
    }
}

// MARK: NSAttributedString
extension NSAttributedString {
    enum MyAttributes {
        case white40, white80
        
        func value() -> [NSAttributedString.Key : Any] {
            switch self {
            case .white80: return [.font: UIFont.systemFont(ofSize: 80),
                                   .foregroundColor: UIColor.white]
            case .white40: return [.font : UIFont.systemFont(ofSize: 40),
                                   .foregroundColor : UIColor.white]
            }
        }
    }
    
    static func get(_ string: String, attributes: MyAttributes) -> NSAttributedString {
        NSAttributedString(string: string, attributes: attributes.value())
    }
}
