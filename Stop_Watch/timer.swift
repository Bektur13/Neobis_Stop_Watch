//
//  Timer.swift
//  Stop_Watch
//
//  Created by Бектур Дуйшембеков on 1/13/24.
//

//
//  ViewController.swift
//  Stop_Watch
//
//  Created by Бектур Дуйшембеков on 1/6/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer: Timer?
    var timerRunning = false
    var count = 0
    let minutesArray: [Int] = Array(0...59)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupPickerView() {
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    func updateButtonState() {
        startButton.isEnabled = !timerRunning
        pauseButton.isEnabled = timerRunning
        resetButton.isEnabled = !timerRunning
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 60 : minutesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(row)" : "\(minutesArray[row])"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startTimer()
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
    
    func startTimer() -> () {
        if(!timerRunning) {
            let minutes = timePicker.selectedRow(inComponent: 0)
            let seconds = timePicker.selectedRow(inComponent: 1)
            count = (minutes * 60) + seconds
            updateTimerLabel()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        timePicker.selectRow(0, inComponent: 0, animated: true)
        timePicker.selectRow(0, inComponent: 1, animated: true)
        updateTimerLabel()
        updateButtonState()
    }
    
    @objc func updateTimer() {
        if(count > 0) {
            count -= 1
            updateTimerLabel()
            updateButtonState()
        }else {
            resetStopWatch()
        }
    }
    
    func updateTimerLabel() {
        let minutes = count / 60
        let seconds = count % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }}
