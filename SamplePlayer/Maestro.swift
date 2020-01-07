//
//  Maestro.swift
//  SamplePlayer
//
//  Created by Jordan Hipwell on 8/29/19.
//  Copyright © 2019 Jordan Hipwell. All rights reserved.
//

import Foundation
import AudioKit

final class Maestro: NSObject {
    
    static let shared = Maestro()
    
    private var audioPlayer: AKPlayer?
    private var ambientPlayer: AKPlayer = {
        let player = AKPlayer(url: Bundle.main.url(forResource: "drums", withExtension: "wav")!)!
        player.isLooping = true
        return player
    }()
    private var mixer: AKMixer?
    
    private let audioFileURL = Bundle.main.url(forResource: "waves", withExtension: "mp3")!
    
    func play() {
        playNewPlayer(fileURL: audioFileURL)
    }
    
    func next() {
        //In the real app we'd play the next audio file in the playlist but for the demo we'll just play the same file
        playNewPlayer(fileURL: audioFileURL)
    }
    
    private func playNewPlayer(fileURL: URL) {
        audioPlayer?.stop()
        audioPlayer = nil
        
        do {
            try AudioKit.stop()
        } catch {
            print("Maestro AudioKit.stop error: \(error)")
        }
        
        audioPlayer = AKPlayer(url: fileURL)!
        mixer = AKMixer([audioPlayer!, ambientPlayer])
        AudioKit.output = mixer
        
        do {
            try AudioKit.start()
        } catch {
            print("Maestro AudioKit.start error: \(error)")
        }
        
        if ambientPlayer.isPlaying {
            //need to resume playback from current position
            let pos = ambientPlayer.currentTime
            ambientPlayer.stop()
            ambientPlayer.play(from: pos)
        } else {
            ambientPlayer.play()
        }
        
        audioPlayer?.play()
    }
    
}
