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
  @objc dynamic var imageUrl = ""
}

class ReportModel: Object {
  @objc dynamic var date = ""
  @objc dynamic var category = ""
  @objc dynamic var word = ""
}

class EventModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var memo = ""
    @objc dynamic var date = "" //yyyy.MM.dd
    @objc dynamic var start_time = "" //00:00
    @objc dynamic var end_time = "" //00:00
}
