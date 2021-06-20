//
//  ReportModel.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/17.
//

import Foundation
import RealmSwift

class TimerModel: Object {
  @objc dynamic var time = ""
}

class ReportModel: Object {
  @objc dynamic var date = ""
  @objc dynamic var category = ""
  @objc dynamic var word = ""
}
