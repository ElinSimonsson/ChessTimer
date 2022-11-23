//
//  ViewController.swift
//  ChessTimer
//
//  Created by Elin Simonsson on 2022-11-22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var p1TimerLabel: UILabel!
    @IBOutlet weak var p2TimerLabel: UILabel!
    @IBOutlet weak var buttonP1: UIButton!
    @IBOutlet weak var buttonP2: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    
    var timerP1 : Timer?
    var timerP2 : Timer?
    var totalTimeP1 = 180 // seconds
    var totalTimeP2 = 180 // seconds
    var isPausedP1 = false
    var isStoppedP1 = false
    var isStoppedP2 = false
    var timerStarted = false
    var timerStartedP2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartButton.isHidden = true
        
    }
    
    @objc func updateTimerP1() {
        self.p1TimerLabel.text = self.timeFormatted(self.totalTimeP1) // will show timer
        if totalTimeP1 != 0 {
            totalTimeP1 -= 1
        } else {
            if let timerP1 = self.timerP1 {
                self.timerP2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP2), userInfo: nil, repeats: true)
                isPausedP1 = true
                isStoppedP1 = true
                buttonP1.isHidden = true
                buttonP2.isHidden = false
                timerP1.invalidate()
                self.timerP1 = nil
            }
        }
    }
    
    @objc func updateTimerP2() {
        self.p2TimerLabel.text = self.timeFormatted(self.totalTimeP2) // will show timer
        if totalTimeP2 != 0 {
            totalTimeP2 -= 1
        } else {
            if let timerP2 = self.timerP2 {
                self.timerP1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP1), userInfo: nil, repeats: true)
                isPausedP1 = false
                isStoppedP2 = true
                buttonP2.isHidden = true
                buttonP1.isHidden = false
                timerP2.invalidate()
                self.timerP2 = nil
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    @IBAction func p1ButtonPressed(_ sender: UIButton) {
        
        if isPausedP1 == false && timerStarted {
            if let timerP1 = self.timerP1 {
                timerP1.invalidate()
            }
            
            if isStoppedP2 == false {
                self.timerP2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP2), userInfo: nil, repeats: true)
                isPausedP1 = true
                buttonP1.isHidden = true
                buttonP2.isHidden = false
            } else {
                restartButton.isHidden = false
                buttonP1.isHidden = true
            }
        }
        
        if timerStarted == false {
            timerStarted = true
            buttonP1.setTitle("Done", for: .normal)
            buttonP2.setTitle("Done", for: .normal)
            self.timerP1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP1), userInfo: nil, repeats: true)
            buttonP2.isHidden = true
        }
    }
    
    
    @IBAction func p2ButtonPressed(_ sender: UIButton) {
        
        if isPausedP1 && timerStarted {
            if let timerP2 = self.timerP2 {
                timerP2.invalidate()
            }
            
            if isStoppedP1 == false {
                self.timerP1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP1), userInfo: nil, repeats: true)
                isPausedP1 = false
                buttonP1.isHidden = false
                buttonP2.isHidden = true
            } else {
                restartButton.isHidden = false
                buttonP2.isHidden = true
            }
        }
        
        if timerStarted == false {
            timerStarted = true
            isPausedP1 = true
            self.timerP2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerP2), userInfo: nil, repeats: true)
            buttonP2.setTitle("Done", for: .normal)
            buttonP1.setTitle("Done", for: .normal)
            buttonP1.isHidden = true
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        isPausedP1 = false
        isStoppedP1 = false
        isStoppedP2 = false
        timerStarted = false
        timerStartedP2 = false
        buttonP1.isHidden = false
        buttonP2.isHidden = false
        restartButton.isHidden = true
        
        buttonP1.setTitle("Start", for: .normal)
        buttonP2.setTitle("Start", for: .normal)
        
        
        totalTimeP1 = 180
        totalTimeP2 = 180
        
        p1TimerLabel.text = "03:00"
        p2TimerLabel.text = "03:00"
  
    }
}


