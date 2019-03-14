//
//  DoubleExt.swift
//  Siri-Into
//
//  Created by admin on 14/03/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

extension Double{
    func convertToClockTime() -> String{
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%0d:%02d", minutes,seconds)
    }
}
