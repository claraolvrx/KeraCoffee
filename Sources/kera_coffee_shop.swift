// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation
import AVFoundation

@main
struct kera_coffee_shop: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Kera Coffee Shop",
        discussion: """
        This program simulates the atmosphere of a relaxing coffee shop illustrated by
        ASCII Art, allowing the user to place a custom order, add sugar or blow it. The
        user can also listenvto relaxing music and runs a guided breathing session. With
        a chill narrative, the program aims to make the terminal environment more pleasant,
        providing a refreshing break from its potentially stressful use.
        """,
        subcommands: [Menu.self, Order.self, Breathe.self, Music.self, Playlist.self]
    )
        
    mutating func run() throws {
        print(home)
    }
    
    struct Menu: ParsableCommand {
        
        static var configuration = CommandConfiguration(
            abstract: "Displays the menu of available drinks for ordering"
        )
        
        func run() throws {
            print(menu)
        }
    }
    
    struct Order: ParsableCommand {
        
        static var configuration = CommandConfiguration(
            abstract: "Places an order for a drink"
        )
        
        @Argument(help: "Number of the order (Enter a number between 1 and 5)")
        var orderNumber: Int
        
        @Argument(help: "The name of the client (Enter a name up to 9 letters)")
        var client: String = "client"
        
        @Flag(name: .shortAndLong, help: "Sweetens your drink")
        var sugar: Bool = false
        
        @Flag(name: .shortAndLong, help: "Close the program")
        var blow: Bool = false
        
        struct MenuOrder: Codable {
            let drink: String
            let process: String
            let artNormal: String
            let artSugar: String
            let artBlow: String
            let artSugarAndBlow: String
        }
        
        // lazy var menuOrders: [Int: MenuOrder] = [ ]
        lazy var menuOrders: [Int: MenuOrder] = [ // lazy - so atribui valores quando a função é executada
            1: MenuOrder(drink: "You asked for a Tea. Good Choice!", process: """
                Heating the water...
                Putting a bag of camomile leaves in the hot water...
                Wait for it...
                It's ready!
                """ , artNormal: makeTeaNormal(client: client), artSugar: makeTeaSugar(client: client), artBlow: makeTeaBlow(client: client), artSugarAndBlow: makeTeaSugarAndBlow(client: client)),
            2: MenuOrder(drink: "You asked for a Capuccino. You will love it!", process:
            """
            Heating the water...
            Adding coffee...
            Adding and mixing steamed milk...
            And just a bit of cinnamon...
            Have a good time ;D
            """, artNormal: makeCapuccinoNormal(client: client), artSugar: makeCapuccinoSugar(client: client), artBlow: makeCapuccinoBlow(client: client), artSugarAndBlow: makeCapuccinoSugarAndBlow(client: client)),
            3: MenuOrder(drink: "You asked for an Espresso. That's our speciality!", process:
            """
            Heating the water...
            And diluting dark coffee...
            Enjoy it <3
            """, artNormal: makeEspressoNormal(client: client), artSugar: makeEspressoSugar(client: client), artBlow: makeEspressoBlow(client: client), artSugarAndBlow: makeEspressoSugarAndBlow(client: client)),
            4: MenuOrder(drink: "You asked for a Latte. That's a classic!", process:
            """
            Heating the milk...
            And diluting dark coffee...
            Careful, it's hot :o
            """, artNormal: makeLatteNormal(client: client), artSugar: makeLatteSugar(client: client), artBlow: makeLatteBlow(client: client), artSugarAndBlow: makeLatteSugarAndBlow(client: client)),
            5: MenuOrder(drink: "You asked for an Afogatto. Personally, that's my favorite!", process:
            """
            Taking the espresso that you already knows...
            And adding our delicious vanilla gelato...
            Hope you like it ><
            """, artNormal: makeAfogattoNormal(client: client), artSugar: makeAfogattoSugar(client: client), artBlow: makeAfogattoBlow(client: client), artSugarAndBlow: makeAfogattoSugarAndBlow(client: client)),
        ]
        
        mutating func run() throws { // mutating - pq está mudando a struct
            prepare()
        }
        
        mutating func prepare() { // mutating - pq está mudando a struct
            if orderNumber > 5 || orderNumber < 1 {
                print("That isn't a valid order. Please choose a number between 1 and 5")}
            else {
                if let order = menuOrders[orderNumber] {
                    print("Hi,", client, order.drink)
                    sleep(3)
                    //""" """ - usadas para strings que ocupam mais de uma linha de código
                    //" " - usadas para strings que ocupam apenas uma linha de código
                    print(waitress)
                    sleep(3)
                    print(order.process)
                    sleep(4)
                    print(order.artNormal)
                    print()
                    sleep(3)
                    if sugar && blow {
                        print("Adding sugar and blowing your drink")
                        print()
                        print(order.artSugarAndBlow)
                    } else if sugar {
                        print("Adding sugar to your drink")
                        print()
                        print(order.artSugar)
                    } else if blow {
                        print("Blowing your drink")
                        print()
                        print(order.artBlow)
                    }
                    print("Thank for visiting Kera Coffee Shop, it was a pleasure to meet you :) Come back soon!")
                }
            }
        }
    }
}
    
struct Breathe: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Conducts a random type guided breathing session"
    )
    
    @Flag(name: .shortAndLong, help: "Starts a focused breathing session")
    var focus: Bool = false
    
    @Flag(name: .shortAndLong, help: "Starts a relaxing breathing session")
    var relax: Bool = false
    
    func run() throws {
        func focusBreathing() {
            let focusBreathe: [String] = ["Inhale, through your nose, focusing only on your breathing, counting 4 seconds...", oneBreathe, twoBreathe, threeBreathe, fourBreathe, "Now exhale, through your nose, for another 4 seconds...", oneBreathe, twoBreathe, threeBreathe, fourBreathe, "Inhale again through your nose.", oneBreathe, twoBreathe, threeBreathe, fourBreathe, "Now exhale once more for 4 seconds", oneBreathe, twoBreathe, threeBreathe, fourBreathe, "Now you can focus better on your tasks!"]
            for n in 0...focusBreathe.count - 1 {
                print(focusBreathe[n])
                sleep(2)
            }
        }
        
        func relaxBreathing() {
            let relaxBreathe: [String] = ["Sit in a comfortable position.", "Imagine the air is filled with peace.", "Inhale and feel that the air is spreading throughout your body, like positive energy.", "Exhale and imagine that the air leaves, taking away all the tension.", "Inhale again through your nose.", "Now exhale once more.", "I hope you feel relaxed :)"]
            for n in 0...relaxBreathe.count - 1 {
                print(relaxBreathe[n])
                sleep(3)
            }
        }
            
            if !focus && !relax {
                var ran: Int = (Int.random(in: 0..<2))
                if ran == 0 {
                    focusBreathing()
                }
                else {
                    relaxBreathing()
                }
            }
            
            if focus {
                focusBreathing()
            }
            else if relax {
                relaxBreathing()
                }
            }
        }

struct Music: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Add a number to play an specific track"
    )
    
    @Argument(help: "Number of the music (Enter a number between 1 and 4)")
    var musicNumber: Int
    
    static var audioPlayer: AVAudioPlayer!
    
    func run() throws {
        if musicNumber > 4 || musicNumber < 1 {
            print("That isn't a valid music number. Please choose a number between 1 and 4")
        } else {
            var i: String?
            while i != "q" {
                play(music: "music\(musicNumber)" )
                print("""
                Enjoy your music!
                Don't forget to turn up the volume or use headphones for better experience.
                """)
                RunLoop.main.run(until: .distantFuture)
                i = readLine()
            }
        }
    }
    
    func play(music: String) {
        do {
            let musicURL = Bundle.module.url(forResource: music, withExtension: "mp3")!
            Music.audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
            Music.audioPlayer.play()
        } catch {
            print(error)
        }
    }
}

struct Playlist: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Displays the playlist of available songs"
    )
    
    func run() throws {
        print(playlist)
    }
}

///*
// {
// "user": "gabi",
// "order": "coffee"
// }
// */
//
//struct Order: Encodable {
//    let user: String
//    let order: String
//    let audioPlayer: AVAudioPlayer
//    
//    enum CodingKeys: String, CodingKey {
//        case user
//        case order
//    }
//}
//
//let gabiOrder = Order(user: "gabi", order: "coffee") // Objeto / Instancia
//// Objeto => JSON
//let data = try! JSONEncoder().encode(gabiOrder) // Data / Bytes
//// Data => JSON
//data.write(to: URL(fileURLWithPath: "~/.keracoffee/order.json")!)
