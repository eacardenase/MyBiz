import Fluent
import Vapor

struct DatabaseSeed: Migration {
    let Moljnir = UUID(uuidString: "4270CFAB-2959-4308-A732-623A6D6F748F")!
    let Shield = UUID(uuidString: "7F6F4B73-D231-438F-93DF-8816FE07E443")!
    let Arrows = UUID(uuidString: "267F7506-3291-4261-A91C-26FDDE85E04E")!

    let BlackWidow = UUID(uuidString: "8803F62C-67F3-4A6E-AA0F-EBFE3FF4F08B")!

    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        prepareUsers(on: database)
            .and(prepareAnnouncements(on: database))
            .and(prepareEmployees(on: database))
            .and(prepareEvents(on: database))
            .and(prepareProducts(on: database))
            .and(preparePurchases(on: database))
            .transform(to: ())
    }

    private func prepareUsers(on database: any Database) -> EventLoopFuture<Void> {
        let password = try? Bcrypt.hash("hailHydra")

        guard let hashedPassword = password else {
            fatalError("Failed to create admin user")
        }

        let user = User(name: "Agent", username: "agent@shield.org", passwordHash: hashedPassword)

        return user.create(on: database)
            .transform(to: ())
    }

    private func prepareAnnouncements(on database: any Database) -> EventLoopFuture<Void> {
        Announcement(message: "A thing happened").create(on: database)
            .and(Announcement(message: "More stuff to come soon!").create(on: database))
            .transform(to: ())
    }

    private func prepareEvents(on database: any Database) -> EventLoopFuture<Void> {
        Event(name: "Alien invasion", date: Date().at(8), type: "Appointment", duration: .hours(1))
            .create(on: database)
            .and(
                Event(
                    name: "Interview with Hydra", date: Date().at(13, minutes: 30),
                    type: "Appointment",
                    duration: .hours(0.5)
                ).create(on: database)
            )
            .and(
                Event(
                    name: "Panic attack", date: Date(timeIntervalSinceNow: .days(7)).at(10),
                    type: "Meeting",
                    duration: .hours(1)
                ).create(on: database)
            )
            .transform(to: ())
    }

    func preparePurchases(on database: any Database) -> EventLoopFuture<Void> {
        PurchaseOrder(
            poNumber: "88616",
            comment: "For Assembly",
            purchaser: BlackWidow,
            purchaseDate: Date(),
            dueDate: nil,
            purchases: [
                PurchaseOrder.Purchase(productId: Moljnir, quantity: 1),
                PurchaseOrder.Purchase(productId: Shield, quantity: 1),
            ]
        ).create(on: database)
            .and(
                PurchaseOrder(
                    poNumber: "88617",
                    comment: nil,
                    purchaser: BlackWidow,
                    purchaseDate: Date(),
                    dueDate: Date(timeIntervalSinceNow: .days(7)),
                    purchases: [PurchaseOrder.Purchase(productId: Arrows, quantity: 400)]
                ).create(on: database)
            )
            .transform(to: ())
    }

    func prepareProducts(on database: any Database) -> EventLoopFuture<Void> {
        Product(name: "Exploding Arrows", unitPrice: 38.5).create(on: database)
            .and(
                Product(id: Arrows, name: "Electrical Arrows", unitPrice: 119.28)
                    .create(on: database)
            )
            .and(Product(name: "Acid Arrow", unitPrice: 9.5).create(on: database))
            .and(Product(id: Moljnir, name: "Moljnir", unitPrice: 72000).create(on: database))
            .and(Product(id: Shield, name: "Shield", unitPrice: 1_200_837).create(on: database))
            .and(Product(name: "Web Slinger", unitPrice: 750).create(on: database))
            .and(Product(name: "Nanotech Armor", unitPrice: 650_888).create(on: database))
            .and(Product(name: "Metal Claws", unitPrice: 27_800).create(on: database))
            .and(Product(name: "Fortune Cookie 🥠", unitPrice: 0.5).create(on: database))
            .and(Product(name: "Blank Cassette", unitPrice: 45.66).create(on: database))
            .transform(to: ())
    }

    func prepareEmployees(on database: any Database) -> EventLoopFuture<Void> {
        let nf = UUID()
        let pc = UUID()
        let cd = UUID()
        let o = UUID()
        let wm = UUID()
        let s = UUID()

        return Employee(
            id: nf, givenName: "Nick", familyName: "Fury", location: "Unknown", manager: nil,
            directReports: [BlackWidow, pc, cd], birthday: "05-04-1963"
        ).create(on: database)
            .and(
                Employee(
                    id: BlackWidow, givenName: "Natasha", familyName: "Romanoff",
                    location: "Voromir",
                    manager: nf, directReports: [o, wm], birthday: "10-22-1984"
                ).create(on: database)
            )
            .and(
                Employee(
                    id: pc, givenName: "Phil", familyName: "Coulson", location: "DC", manager: nf,
                    directReports: [], birthday: "04-08-1964"
                ).create(on: database)
            )
            .and(
                Employee(
                    id: o, givenName: "", familyName: "Okoye", location: "Wakanda",
                    manager: BlackWidow,
                    directReports: [], birthday: "10-01-1998"
                ).create(on: database)
            )
            .and(
                Employee(
                    id: wm, givenName: "James", familyName: "Rhodes", location: "DC",
                    manager: BlackWidow,
                    directReports: [], birthday: "10-08-1968"
                ).create(on: database)
            )
            .and(
                Employee(
                    id: cd, givenName: "Carol", familyName: "Danvers", location: "Space",
                    manager: nf,
                    directReports: [s], birthday: "03-01-1968"
                ).create(on: database)
            )
            .and(
                Employee(
                    id: s, givenName: "Monica", familyName: "Rambeau", location: "New York",
                    manager: cd,
                    directReports: [], birthday: "10-18-1982"
                ).create(on: database)
            )
            .transform(to: ())
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        return database.eventLoop.makeSucceededVoidFuture()
    }
}
