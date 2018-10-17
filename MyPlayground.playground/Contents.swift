protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set }
    func update(value: Int?)
}

final class newsResource: Observable {
    private var observers: [Observer] = []
    var vaule: Int? {
        didSet {
            notifyObservers()
        }
    }
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where:{$0.element.id == observer.id})?.offset  else { return }
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(value: vaule) }
    }
}

final class NewsAgency: Observer {
    
    var id = "newsAgency"
    
    func update(value: Int?) {
        if let value = value {
            print("NewsAgency handle updated value: \(value)")
        }
    }
}

final class Reporter: Observer {
    
    var id = "reporter"
    
    func update(value: Int?) {
        if let value = value {
            print("Reporter. updated value: \(value)")
        }
    }
}

final class Blogger: Observer {
    
    var id = "blogger"
    
    func update(value: Int?) {
        if let value = value {
            print("Blogger. New article about value updated value: \(value)")
        }
    }
}

let resource = newsResource()
let newsAgency = NewsAgency()
let reporter = Reporter()
let blogger = Blogger()

resource.add(observer: newsAgency)
resource.add(observer: reporter)

resource.vaule = 5

resource.add(observer: blogger)

resource.vaule = 7

resource.remove(observer: reporter)

resource.vaule = 7
