//
//  UserViewModel.swift
//  SeSAC7Week7
//
//  Created by andev on 8/8/25.
//

//UIKit import 안함
import Foundation

class UserViewModel {
    
    let loadButtonTapped: Field<Void> = Field(())
    let resetButtonTapped = Field(())
    let addButtonTapped = Field(())

    let list: Field<[Person]> = Field([])
    
    init() {
        print("Init")
        loadButtonTapped.playAction { _ in
            self.load()
        }
        
        resetButtonTapped.playAction { _ in
            self.reset()
        }
        
        addButtonTapped.playAction { _ in
            self.add()
        }
    }
    
    func load() {
        list.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    func reset() {
        list.value.removeAll()
    }
    
    func add() {
        let jack = Person(name: "Jack", age: Int.random(in: 1...100))
        list.value.append(jack)
    }
    
    func cellForRowAtData(indexPath: Int) -> String {
        let data = list.value[indexPath]
        return "\(data.name), \(data.age)세"
    }
    
}
