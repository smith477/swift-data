//
//  SWLogger.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/15/23.
//

import Foundation
import OSLog

enum SWLogger {
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let log = Logger(subsystem: subsystem, category: "log")
}
