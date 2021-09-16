//
//  TestScreenCoordinator.swift
//  Soliu
//
//  Created by JungpyoHong on 9/15/21.
//

import Foundation

//MARK:- Create TestScreen Layer

protocol TestScreenCoordinatorProtocol {
    func isLoggedIn()
    func increaseProgress()
}

class TestScreenCoordinator: TestScreenCoordinatorProtocol {
    
    private let testScreen: TestScreenViewController
    private let testDetailScreen: TestDetailViewController
    
    init(testScreen: TestScreenViewController,
         testDetailScreen: TestDetailViewController) {
        self.testScreen = testScreen
        self.testDetailScreen = testDetailScreen
    }
    
    func isLoggedIn() {
        testScreen.isLoggedIn()
    }
    
    func increaseProgress() {
        testDetailScreen.increaseProgress()
    }
}
