//
//  Maestro.swift
//  SamplePlayer
//
//  Created by Jordan Hipwell on 8/29/19.
//  Copyright © 2019 Jordan Hipwell. All rights reserved.
//

import Foundation
import AudioKit

final class Maestro : NSObject {
    static let shared = Maestro()
    
    var audioPlayers = [TrackPlayer]()
    
    let trackURLs = [
        Bundle.main.url(forResource: "SampleAudio_0.7mb", withExtension: "mp3")!,
        Bundle.main.url(forResource: "SampleAudio_0.4mb", withExtension: "mp3")!
    ]
    
    func setUp() {
        setUpTrackPlayers(fileURL: trackURLs.first!)
        play()
    }
    
    func setUpTrackPlayers(fileURL: URL) {
        let playerOne = TrackPlayer(url: fileURL)
        audioPlayers.append(playerOne)
        
        AudioKit.output = playerOne.handleMixerChain() //boom
        
        do {
            try AudioKit.start()
            playerOne.play()
        } catch {
            print("Maestro AudioKit.start error: \(error)")
        }
    }
    
    func next() {
        for player in audioPlayers {
            player.stop()
        }
        audioPlayers.removeAll()
        
        setUpTrackPlayers(fileURL: trackURLs.last!)
    }
    
    func play() {
        
    }
}

final class TrackPlayer {
    let player : AKPlayer
    lazy var timePitch = AKTimePitch()
    
    init(url: URL) {
        player = AKPlayer(url: url)!
    }
    
    func handleMixerChain(pitch: Double = 0.0, tempo: Double = 1.0) -> AKTimePitch {
        timePitch = AKTimePitch(player)
        timePitch.pitch = pitch
        timePitch.rate = tempo
        return timePitch
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.stop()
    }
    
}
