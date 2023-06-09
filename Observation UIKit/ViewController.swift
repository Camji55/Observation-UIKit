//
//  ViewController.swift
//  Observation UIKit
//
//  Created by Cameron Ingham on 6/9/23.
//

import Observation
import UIKit

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

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    let counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
    }
    
    private func render() {
        withObservationTracking {
            countLabel.text = "\(counter.count)"
        } onChange: { [weak self] in
            Task { @MainActor [weak self] in
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

