import ArgumentParser

struct Dicer: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "A utility for performing maths.", subcommands: [Roll.self], defaultSubcommand: Roll.self)
    
    // MARK: Options
    
    struct Options: ParsableArguments {
        @Flag(inversion: .prefixedNo, help: "Prints each dice value separately") var showSeparately = false
        
        @Argument(help: ArgumentHelp("Dices to operate on", discussion: "Each dice should be prefixed with the `d` letter (shorcut for dice)", valueName: "dices", shouldDisplay: true), transform: Dice.from)
        var dices: [Dice]
    }
    
}

// MARK: Roll Command

extension Dicer {
    
    struct Roll: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Rolls provided dices")
        
        @Option(help: "Repetas the throw <n> times") var `repeat`: Int = 1
        @OptionGroup var options: Options
        
        func run() {
            `repeat`.times { _ in throwDices() }
        }
        
        private func throwDices() {
            if options.showSeparately {
                for dice in options.dices { print(dice.rollValue) }
            } else {
                print(options.dices.reduce(0) { sum, val in
                    return sum + val.rollValue
                })
            }
        }
    }
    
}

extension Dice: ExpressibleByArgument {
    init?(argument: String) {
        guard argument.hasPrefix("d") else {
            return nil
        }
        
        let firstNumberIndex = argument.index(argument.startIndex, offsetBy: 1)
        let numberSubstring = argument.suffix(from: firstNumberIndex)
        
        guard let number = Int(String(numberSubstring)), number > 0 else {
            return nil
        }
        
        sides = number
    }
    
    static func from(argument: String) throws -> Dice {
        guard argument.hasPrefix("d") else {
            throw ValidationError("Wrong Prefix - should be letter d instead of \(argument.first ?? Character(""))")
        }
        
        let firstNumberIndex = argument.index(argument.startIndex, offsetBy: 1)
        let numberSubstring = argument.suffix(from: firstNumberIndex)
        
        guard let number = Int(String(numberSubstring)) else {
            throw ValidationError("Couldn't conver dice to number - \(String(numberSubstring))")
        }
        
        do {
            let dice = try Dice(sides: number)
            return dice
        }
        catch Dice.DiceError.wrongValue(let message) {
            throw ValidationError(message)
        }
        catch {
            throw ValidationError("Unknow error")
        }
        
    }
    
}

Dicer.main()
