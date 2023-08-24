//
//  TimerViewController.swift
//  EggTimer
//
//  Created by Squadzip on 8/24/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    var timer: Timer = Timer()
    var timerCount = 0 {
        didSet {
            if timerCount != 0 {
                timerLabel.text = "\(timerCount) Seconds Left"
            } else {
                timerLabel.text = "Egg is \(eggButtonTapped) Cooked"
                audioPlayer?.play()
                showDoneButton()
            }
            
            let progress = 1.0  - Float(timerCount) / Float(eggButtonTapped.timer)
            self.progressView.progress = progress
        }
    }
    var eggButtonTapped: Egg = .Soft
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onStartTimer()
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file:", error.localizedDescription)
            }
        }
    }
    
    private func showDoneButton() {
        pauseButton.isHidden = true
        cancelButton.isHidden = true
        doneButton.isHidden = false
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        timer.invalidate()
        self.dismiss(animated: true)
    }
    
    private func onStartTimer() {
        progressView.progress = 0
        timer.invalidate()
        timerCount = eggButtonTapped.timer
        runTimer()
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            timerCount -= 1
            print(timerCount)
            if timerCount == 0 {
                timer.invalidate()
            }
        })
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        timer.invalidate()
        self.dismiss(animated: true)
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        sender.isHidden = true
        resumeButton.isHidden = false
    }
    
    @IBAction func resumeButtonTapped(_ sender: UIButton) {
        runTimer()
        sender.isHidden = true
        pauseButton.isHidden = false
    }
}
