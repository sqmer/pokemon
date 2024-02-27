//
//  MobileVLCKitAudioPlayer.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/26/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import MobileVLCKit

class MobileVLCKitAudioPlayer: AudioPlayable {
    
    let mediaPlayer = VLCMediaPlayer()
    
    func play(filePath: URL) {

        let media = VLCMedia(url: filePath)
        mediaPlayer.media = media
        mediaPlayer.play()
    }
}
