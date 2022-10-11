import UIKit
import Combine

// MARK: - Ex: @Published, sink() -

var cancellable: AnyCancellable

class Weather {
    @Published var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}

let weather = Weather(temperature: 20)

cancellable = weather.$temperature
    .sink() {
        print ("Temperature now: \($0)")
    }

weather.temperature = 25

// MARK: - End -
