//
//  SpeechSynthesizer.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/22/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechSynthesizer{
    
    let synthesizer: AVSpeechSynthesizer!
    
    init(){
        synthesizer = AVSpeechSynthesizer()
        synthesizer.pauseSpeakingAtBoundary(.Immediate)
    }
    
    func speak(text:String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speakUtterance(utterance)
    }
    
    
}