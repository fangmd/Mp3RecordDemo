//
//  AudioHelper.swift
//  Mp3Record
//
//  Created by Double on 2017/7/4.
//  Copyright © 2017年 Double. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


protocol AudioHelperDelegate {
    func assetExportSessionDidFinishExport(session: AVAssetExportSession, outputUrl: NSURL)
}

class AudioHelper: NSObject {
    
    var delegate: AudioHelperDelegate?
    
    func concatenate(audioUrls: [NSURL]) {
        
//        //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
//        var composition = AVMutableComposition()
//        var compositionAudioTrack:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
//        
//        //create new file to receive data
//        var documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
//        var fileDestinationUrl = URL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingPathComponent("resultmerge.wav"))
//        println(fileDestinationUrl)
//        
//        StorageManager.sharedInstance.deleteFileAtPath(NSTemporaryDirectory().stringByAppendingPathComponent("resultmerge.wav"))
//        
//        var avAssets: [AVURLAsset] = []
//        var assetTracks: [AVAssetTrack] = []
//        var durations: [CMTime] = []
//        var timeRanges: [CMTimeRange] = []
//        
//        var insertTime = kCMTimeZero
//        
//        for audioUrl in audioUrls {
//            let avAsset = AVURLAsset(URL: audioUrl, options: nil)
//            avAssets.append(avAsset)
//            
//            let assetTrack = avAsset.tracksWithMediaType(AVMediaTypeAudio)[0] as! AVAssetTrack
//            assetTracks.append(assetTrack)
//            
//            let duration = assetTrack.timeRange.duration
//            durations.append(duration)
//            
//            let timeRange = CMTimeRangeMake(kCMTimeZero, duration)
//            timeRanges.append(timeRange)
//            
//            compositionAudioTrack.insertTimeRange(timeRange, ofTrack: assetTrack, atTime: insertTime, error: nil)
//            insertTime = CMTimeAdd(insertTime, duration)
//        }
//        
//        //AVAssetExportPresetPassthrough => concatenation
//        var assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough)
//        assetExport?.outputFileType = AVFileTypeWAVE
//        assetExport.outputURL = fileDestinationUrl
//        assetExport.exportAsynchronouslyWithCompletionHandler({
//            self.delegate?.assetExportSessionDidFinishExport(assetExport, outputUrl: fileDestinationUrl!)
//        })
    }
    
    func exportTempWavAsMp3(wavFilePath: String) {        
        AudioWrapper.convertFromWav(toMp3: wavFilePath)
    }
}
