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
    
    private var trackPlayers = [AKPlayer]() {
        didSet {
            do {
                try AudioKit.stop()
            } catch {
                print("Maestro AudioKit.stop error: \(error)")
            }
            
            mixer = AKMixer(trackPlayers)
            AudioKit.output = mixer
            
            do {
                try AudioKit.start()
            } catch {
                print("Maestro AudioKit.start error: \(error)")
            }
            
            trackPlayers.forEach {
                if $0.isPlaying {
                    let pos = $0.currentTime
                    $0.stop()
                    $0.play(from: pos)
                }
            }
        }
    }
    private var mixer: AKMixer?
    
    private let trackURLs = [
        Bundle.main.url(forResource: "SampleAudio_0.4mb", withExtension: "mp3")!,
        Bundle.main.url(forResource: "SampleAudio_0.7mb", withExtension: "mp3")!
    ]
    
    func playFirstTrack() {
        playNewPlayer(fileURL: trackURLs[0])
    }
    
    func next() {
        trackPlayers.forEach { $0.stop() }
        trackPlayers.removeAll()
        
        playNewPlayer(fileURL: trackURLs[1])
    }
    
    func fadeAndStartNext() {
        playNewPlayer(fileURL: trackURLs[1])
        
        //here we would adjust the volume of the players and remove the first player after 3 seconds
    }
    
    private func playNewPlayer(fileURL: URL) {
        let newPlayer = AKPlayer(url: fileURL)!
        trackPlayers.append(newPlayer) //triggers didSet to update AudioKit.output
        
        newPlayer.play()
    }
    
}
