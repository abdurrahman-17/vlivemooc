//
//  Date+Extension.swift
//  MOBIPlayer-Noor-Clone
//
//  Created by Sasikumar D on 13/06/23.
//

import UIKit

extension Date {
    var timestamp: Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}
