//
//  MainTableCellViewModel.swift
//  Soliu
//
//  Created by Yoonha Kim on 6/27/21.
//

import Foundation

protocol DiaryTableViewCellViewModelProtocol {
    var note: String { get }
    var name: String { get }
    var mood: String { get }
    var date: String { get }
}
class DiaryTableViewCellViewModel: DiaryTableViewCellViewModelProtocol {

    var diary: Diary?
    
    init(diary: Diary?) {
        self.diary = diary
    }
    
    var note: String {
        diary?.note ?? ""
    }
    
    var name: String {
        diary?.name ?? ""
    }
    
    var mood: String {
        diary?.name ?? ""
    }
    
    var date: String {
        diary?.date ?? ""
    }
    
}
