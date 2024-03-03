//
//  ViewController.swift
//  Stop_Watch
//
//  Created by Бектур Дуйшембеков on 1/6/24.
//

import UIKit

class StopWatchController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // Properties for Timer
    let hours = Array(0...23)
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    
    // Created Icon of Timer
    lazy var stopWatchIcon: UIImageView = {
        let icon = UIImage(named: "Timer")
        let iconView = UIImageView(image: icon)
        return iconView
    }()
    
    // Properties for Segmented Control
    let items = ["Timer", "StopWatch"]
    
    // Created Segmented Control
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    // Created StopWatch Timer label
    lazy var stopWatchLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    // Created Picker View
    lazy var timerPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setUpConstraints()
    }
    
    func setUpConstraints() {
        //StopWatch Icon
        view.addSubview(stopWatchIcon)
        stopWatchIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopWatchIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            stopWatchIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopWatchIcon.widthAnchor.constraint(equalToConstant: 50),
            stopWatchIcon.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //Segmented Control
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: stopWatchIcon.bottomAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // StopWatch Label
        view.addSubview(stopWatchLabel)
        stopWatchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopWatchLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
            stopWatchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(timerPicker)
        timerPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerPicker.topAnchor.constraint(equalTo: stopWatchLabel.bottomAnchor, constant: 30),
            timerPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return seconds.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hours[row])"
        case 1:
            return "\(minutes[row])"
        case 2:
            return "\(seconds[row])"
        default:
            return nil
        }
    }
}


//
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
//    @IBOutlet weak var stopWatchLabel: UILabel!
//    @IBOutlet weak var startButton: UIButton!
//    @IBOutlet weak var pauseButton: UIButton!
//    @IBOutlet weak var resetButton: UIButton!
//    
//    @IBOutlet weak var pickerView: UIPickerView!
//    
//    // For StopWatch
//    var timer: Timer?
//    var isStopWatchRunning = false
//    var count = 0
//    
//    // For Timer
//    var countDownSeconds: Int =  0
//    var initialCountDownSeconds: Int = 0
//    var isTimerRunning: Bool = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
//        
//        pickerView.delegate = self
//        pickerView.dataSource = self
//    }
//    
//    @objc func segmentedControlValueChanged() {
//        updateUIForSelectedSegment()
//    }
//    
//    func updateUIForSelectedSegment() {
//        let selectedIndex = segmentedControl.selectedSegmentIndex
//        if selectedIndex == 0 {
//            stopWatchLabel.text = "00:00:00"
//            pickerView.isHidden = true
//            updateStopWatchLabel()
//        } else {
//            pickerView.isHidden = false
//            updateTimerLabelFromPicker()
//        }
//        stopStopWatch()
//    }
//    
//    func updateStopWatchLabel() {
//        timer = Timer.scheduledTimer(timeInterval: 0.01,
//                                            target: self,
//                                            selector: #selector(updateStopWatch),
//                                            userInfo: nil,
//                                            repeats: true)
//    }
//    
//
//    
//    @IBAction func startButtonTapped(_ sender: UIButton) {
//        let selectedIndex = segmentedControl.selectedSegmentIndex
//        if selectedIndex == 0 {
//            if isStopWatchRunning {
//                stopStopWatch()
//            } else {
//                startStopWatch()
//            }
//        } else if selectedIndex == 1 {
//            if isTimerRunning {
//                stopTimer()
//            } else {
//                startTimer()
//            }
//        }
//    }
//    @IBAction func pauseButtonTapped(_ sender: UIButton) {
//        let selectedIndex = segmentedControl.selectedSegmentIndex
//        if selectedIndex == 0 {
//            stopStopWatch()
//        } else if selectedIndex == 1 {
//            startTimer()
//        }
//    }
//    @IBAction func resetButtonTapped(_ sender: UIButton) {
//        let selectedIndex = segmentedControl.selectedSegmentIndex
//        if selectedIndex == 0 {
//            resetStopWatch()
//        } else if selectedIndex == 1 {
//            resetTimer()
//        }
//    }
//    
//    @objc func updateStopWatch() {
//        if isStopWatchRunning {
//            count = count + 10
//            let time = millisecondsToMinutesSecondsMilliseconds(milliseconds: count)
//            let timeString = makeTimeString(minutes: time.0, seconds: time.1, milliseconds: time.2)
//            stopWatchLabel.text = timeString
//        }
//    }
//    
//    func startStopWatch() {
//        isStopWatchRunning = true
//        startButton.isEnabled = false
//        pauseButton.isEnabled = true
//        resetButton.isEnabled = true
//    }
//    
//    func stopStopWatch() {
//        isStopWatchRunning = false
//        startButton.isEnabled = true
//        pauseButton.isEnabled = true
//        resetButton.isEnabled = true
//    }
//    
//    func resetStopWatch() {
//        isStopWatchRunning = false
//        count = 0
//        let time = millisecondsToMinutesSecondsMilliseconds(milliseconds: count)
//        let timeString = makeTimeString(minutes: time.0, seconds: time.1, milliseconds: time.2)
//        stopWatchLabel.text = timeString
//        
//        startButton.isEnabled = true
//        pauseButton.isEnabled = false
//        resetButton.isEnabled = false
//    }
//    
//    func millisecondsToMinutesSecondsMilliseconds(milliseconds: Int) -> (Int, Int, Int) {
//        let totalSeconds = milliseconds / 1000
//        return ((totalSeconds / 60), (totalSeconds % 60), (milliseconds % 1000))
//    }
//    
//    func makeTimeString(minutes: Int, seconds: Int, milliseconds: Int) -> String {
//            let timeString = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds % 1000 / 10)
//            return timeString
//    }
//    func updateTimerLabelFromPicker() {
//            let selectedRowHour = pickerView.selectedRow(inComponent: 0)
//            let selectedRowMinute = pickerView.selectedRow(inComponent: 1)
//            let selectedRowSecond = pickerView.selectedRow(inComponent: 2)
//            
//            countDownSeconds = selectedRowHour * 3600 + selectedRowMinute * 60 + selectedRowSecond
//            initialCountDownSeconds = countDownSeconds
//            updateTimeLabel()
//    }
//
//    func updateTimeLabel() {
//            let time = secondsToHoursMinutesSeconds(seconds: countDownSeconds)
//            let timeString = String(format: "%02d:%02d:%02d", time.0, time.1, time.2)
//            stopWatchLabel.text = timeString
//    }
//        
//    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
//            let hours = seconds / 3600
//            let minutes = (seconds % 3600) / 60
//            let seconds = seconds % 60
//            
//            return (hours, minutes, seconds)
//    }
//    
//    func startTimer() {
//           isTimerRunning = true
//           pickerView.isHidden = true
//           startButton.isEnabled = false
//           pauseButton.isEnabled = true
//           resetButton.isEnabled = true
//           timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
//       }
//
//       func stopTimer() {
//           isTimerRunning = false
//           startButton.isEnabled = true
//           pauseButton.isEnabled = false
//           resetButton.isEnabled = true
//           timer?.invalidate()
//       }
//    func resetTimer() {
//           isTimerRunning = false
//           pickerView.isHidden = false
//           startButton.isEnabled = true
//           pauseButton.isEnabled = false
//           resetButton.isEnabled = false
//           countDownSeconds = initialCountDownSeconds
//           timer?.invalidate()
//           updateTimeLabel()
//       }
//
//       @objc func updateCountdown() {
//           if countDownSeconds > 0 {
//               countDownSeconds -= 1
//               updateTimeLabel()
//           } else {
//               stopTimer()
//               // Таймер завершен, выполните необходимые действия
//           }
//       }
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            return 3
//        }
//        
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            return component == 0 ? 24 : 60
//        }
//        
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return String(format: "%2d", row)
//        }
//        
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            updateTimerLabelFromPicker()
//        }
// 

