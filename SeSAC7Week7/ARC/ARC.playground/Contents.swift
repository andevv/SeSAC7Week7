import UIKit

protocol MyDelegate: AnyObject {
    func sendData()
}

class MainVC: MyDelegate {
    
    lazy var customView = {
        let view = DetailView()
        view.jack = self
        return view
    }()
    
    func sendData() {
        print("안녕하세요")
    }
    
    deinit {
        print("MainVC Deinit")
    }
}

class DetailView {
    
    //weak >> 클래스의 인스턴스나, 참조 타입을 해결하기 위해 나온 키워드
    weak var jack: MyDelegate?
    
    func dismiss() {
        jack?.sendData()
    }
    
    deinit {
        print("DetailView Deinit")
    }
}

var view: MainVC? = MainVC()
view = nil

class Person {
    let name: String
    
    lazy var introduce = { [weak self] in
        guard let self = self else { return }
        print("저는 \(self.name)입니다.")
    }
    
    init(name: String) {
        self.name = name
        print("Person: Init")
    }
    
    deinit {
        print("Person: Deinit")
    }
}

var person: Person? = Person(name: "jack") //RC +1
person?.name
person?.introduce()
person = nil
person?.name
person?.introduce()

class Guild {
    var name: String
    weak var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild: Init")
    }
    
    deinit {
        print("Guild: Deinit")
    }
}

class User {
    var name: String
    weak var guild: Guild?
    
    init(name: String) {
        self.name = name
        print("User: Init")
    }
    
    deinit {
        print("User: Deinit")
    }
}

var sesac: Guild? = Guild(name: "새싹") //RC +1
var user: User? = User(name: "도사") //RC +1

sesac?.owner = user //RC +1
user?.guild = sesac //RC +1

//sesac?.owner = nil //RC -1
//user?.guild = nil //RC -1

sesac = nil //RC -1
user = nil //RC -1
