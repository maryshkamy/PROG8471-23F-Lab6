//
//  ViewModel.swift
//  Lab6MarianaRiosSilveiraCarvalho
//
//  Created by Mariana Rios Silveira Carvalho on 2023-10-15.
//

import Foundation

protocol ViewModelProtocol {
    var dataSoure: [String] { get }
    func add(item: String?)
    func remove(at index: Int)
    func saveData()
    func loadData()
}

class ViewModel: ViewModelProtocol {

    // MARK: - Private(set) Properties
    private(set) var dataSoure: [String]

    // MARK: - Private Constants
    private let dataKey = "ToDoList"
    private let userDefaults = UserDefaults.standard

    // MARK: - Initializer
    init() {
        self.dataSoure = []
    }

    // MARK: - Protocol Functions
    func add(item: String?) {
        guard let text = item, text != "" else { return }
        self.dataSoure.append(text)
        self.saveData()
    }

    func remove(at index: Int) {
        self.dataSoure.remove(at: index)
        self.saveData()
    }
    
    func saveData() {
        userDefaults.set(dataSoure, forKey: dataKey)
    }

    func loadData() {
        self.dataSoure = userDefaults.stringArray(forKey: dataKey) ?? []
    }
}
