//
//  PlaySound.swift
//  LoveCare
//
//  Created by Yacine on 9/2/23.
//

import SwiftUI
import AVFoundation

var avAudioPlayer: AVAudioPlayer?

func playSound(sound:String, type:String?){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            avAudioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            avAudioPlayer?.play()
        }catch{
            print("Enable to play sound, or sound not found")
        }
    }
}

