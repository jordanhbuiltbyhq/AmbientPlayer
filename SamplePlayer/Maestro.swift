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
    
    var trackPlayers = [AKPlayer]()
    
    let trackURLs = [
        Bundle.main.url(forResource: "SampleAudio_0.7mb", withExtension: "mp3")!,
        Bundle.main.url(forResource: "SampleAudio_0.4mb", withExtension: "mp3")!
    ]
    
    func playFirstTrack() {
        playNewPlayer(fileURL: trackURLs[0])
    }
    
    func playNewPlayer(fileURL: URL) {
        let newPlayer = AKPlayer(url: fileURL)!
        trackPlayers.append(newPlayer)
        
        AudioKit.output = newPlayer //boom
        
        do {
            try AudioKit.start()
            newPlayer.play()
        } catch {
            print("Maestro AudioKit.start error: \(error)")
        }
    }
    
    func next() {
        trackPlayers.forEach { $0.stop() }
        trackPlayers.removeAll()

        do {
            try AudioKit.stop()
        } catch {
            print("Maestro AudioKit.stop error: \(error)")
        }
        
        playNewPlayer(fileURL: trackURLs[1])
    }
    
    func fadeAndStartNext() {
        //TODO: This crashes because we change the output without stopping AudioKit
        //but we can't stop playback of the first AKPlayer
        //Note that the fading logic is not included here
        
        playNewPlayer(fileURL: trackURLs[1])
    }
    
}
