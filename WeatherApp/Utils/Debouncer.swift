//
//  Debouncer.swift
//  WeatherApp
//
//  Created by Roman Siro on 22.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation

class Debouncer {

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    typealias Handler = () -> Void
    var handler: Handler?

    private let timeInterval: TimeInterval
    private var timer: Timer?

    func renewInterval() {
        timer?.invalidate()
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
                self?.handleTimer(timer)
            })
        } else {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
        }
    }

    @objc private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }

}
