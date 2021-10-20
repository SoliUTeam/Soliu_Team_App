//
//  DiarySubviewModel.swift
//  Soliu
//
//  Created by Yoonha Kim on 8/24/21.
//

import Foundation
import UIKit

class DiarySubviewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // CoreData
    func saveDiaryData(name: String, mood: Int32, date: String, note: String) {
        let diary = Diary(context: self.context)
        diary.name = name
        diary.mood = mood
        diary.date = date
        diary.note = note
        
        do {
            try self.context.save()
        } catch {
            print("Save Data failed")
        }
    }
}
