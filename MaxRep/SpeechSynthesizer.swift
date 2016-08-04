//
//  SpeechSynthesizer.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/22/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?

class SpeechSynthesizer{
    
    let synthesizer: AVSpeechSynthesizer!
    let url = NSBundle.mainBundle().URLForResource("referee", withExtension: "wav")!

    
    init(){
        synthesizer = AVSpeechSynthesizer()
        synthesizer.pauseSpeakingAtBoundary(.Immediate)
    }
    
    func speak(text:String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speakUtterance(utterance)
    }
    
    func playSound() {
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
}