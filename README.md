# Observation-UIKit
Apple Observation framework integration with UIKit

## How it Works

### Declare your object as `@Observable`
```swift
@Observable
final class Counter {
    
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
}
```

### Observe and Render the Changes
```swift
class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    let counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
    }
    
    private func render() {
        withObservationTracking {
            // Any value that's read from the `Observed` class will be automatically tracked for changes.
            countLabel.text = "\(counter.count)"
        } onChange: { [weak self] in
            Task { @MainActor [weak self] in
                // Recursivly call this same function any time an `Observed` propery changes to re-render the view.
                self?.render()
            }
        }
    }
    
    @IBAction func incrementButtonTapped(_ sender: Any) {
        counter.increment()
    }
    
    @IBAction func decrementButtonTapped(_ sender: Any) {
        counter.decrement()
    }
}
```
