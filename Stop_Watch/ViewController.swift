//
//  ViewController.swift
//  Stop_Watch
//
//  Created by Бектур Дуйшембеков on 1/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stopWatchLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer: Timer?
    var timerRunning = false
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func changeLabel() {
        let hours = count / 3600
        let minutes = (count / 60) % 60
        let seconds = count % 60
        stopWatchLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
//    @IBAction func startButtonTapped(_ sender: UIButton) {
//        startStopWatch()
//        updateButtonState()
//    }
//    @IBAction func pauseButtonTapped(_ sender: UIButton) {
//        pauseStopWatch()
//        updateButtonState()
//    }
//    @IBAction func resetButtonTapped(_ sender: UIButton) {
//        resetStopWatch()
//        updateButtonState()
//    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startStopWatch()
        updateButtonState()
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        pauseStopWatch()
        updateButtonState()
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetStopWatch()
        updateButtonState()
    }
    
    func startStopWatch() -> () {
        if(!timerRunning) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            timerRunning = true
            updateButtonState()
        }
    }
    
    func pauseStopWatch() -> () {
        if(timerRunning) {
            timer?.invalidate()
            timerRunning = false
            updateButtonState()
        }
    }
    
    func resetStopWatch() -> () {
        timer?.invalidate()
        timerRunning = false
        count = 0
        changeLabel()
        updateButtonState()
    }
    
    @objc func updateStopWatch() {
        count += 1
        changeLabel()
    }

    func updateButtonState() {
        startButton.isEnabled = !timerRunning
        pauseButton.isEnabled = timerRunning
        resetButton.isEnabled = !timerRunning
    }
 
}
