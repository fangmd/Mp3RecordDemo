//
//  ViewController.swift
//  Mp3Record
//
//  Created by Double on 2017/7/3.
//  Copyright © 2017年 Double. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation





class ViewController: UIViewController {
    
    let mBtnStart: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(startRecord), for: .touchUpInside)
        return btn
    }()
    
    let mBtnStop: UIButton = {
        let btn = UIButton()
        btn.setTitle("Stop", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(stopRecord), for: .touchUpInside)
        return btn
    }()
    
    let mBtnPlay: UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(playRecord), for: .touchUpInside)
        return btn
    }()
    
    let mBtnConvert: UIButton = {
        let btn = UIButton()
        btn.setTitle("Convert", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(convertRecord), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        AVAudioSession.sharedInstance().requestRecordPermission () {
            [unowned self] allowed in
            if allowed {
                // Microphone allowed, do what you like!
                NSLog("permission Allowed")
                
                self.startRecord()
            } else {
                // User denied microphone. Tell them off!
                NSLog("permission deni")
                // tell user turn on Audio record permission in settings
                
            }
        }
        
        
        
        initView()
        
    }
    
    func initView(){
        self.view.addSubview(mBtnStart)
        self.view.addSubview(mBtnStop)
        self.view.addSubview(mBtnPlay)
        self.view.addSubview(mBtnConvert)
        
        
        mBtnStart.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(20)
            make.top.equalTo(self.view).offset(20 + 44)
        }
        mBtnStop.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(20)
            make.top.equalTo(mBtnStart.snp.bottom)
        }
        mBtnPlay.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(20)
            make.top.equalTo(mBtnStop.snp.bottom)
        }        
        mBtnConvert.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(20)
            make.top.equalTo(mBtnPlay.snp.bottom)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // play
    var mPlayer: AVAudioPlayer?
    func playRecord(){
        
//        convertRecord()
        
        NSLog("Play %@, @@", [mFilePath ?? "", mMp3FilePath ?? ""])
        
        let audioUrl = URL(fileURLWithPath: mMp3FilePath!, isDirectory: false)
        
        do {
            mPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            guard let mPlayer = mPlayer else { return }
            
            mPlayer.prepareToPlay()
            mPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
        
        
    }
    
    //--- convert
    
    func convertRecord(){        
        
        
//        AudioWrapper.audioPCMtoMP3(mFilePath, mMp3FilePath)
        
        
//        AudioHelper().exportTempWavAsMp3(wavFilePath: mFilePath!)
        
        AudioWrapper.toMp3(mFilePath, mMp3FilePath)
        
        
        
    }
    
    //---------- record
    
    var audioRec: AVAudioRecorder?
    var mFilePath: String?
    var mMp3FilePath: String?
    
    func startRecord(){
        
        // 0. Create a URL path where you’ll store the recording. This is usually the documents folder of your app.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        
        let tmpDirPath = NSTemporaryDirectory()
        mFilePath = tmpDirPath.appending("audioFileName.caf")
        mMp3FilePath = tmpDirPath.appending("audioFileName.mp3")
        
        NSLog("Temporary path: %@ ,, @@", [tmpDirPath, mFilePath])
        
        let audioUrl = URL(fileURLWithPath: mFilePath!, isDirectory: false)
        
        
        // 1. create the session
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2. configure the session for recording and playback
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            audioRec = try AVAudioRecorder(url: audioUrl, settings: settings)
            audioRec?.delegate = self
            audioRec?.record()
            
            
        }
        catch let error {
            // failed to record!
        }
        
    }
    
    func stopRecord(){
        audioRec?.stop()
    }
    
    func recordingEnded(success: Bool){
        // record end result
        NSLog("Record End %@", String(success))
    }
    
    
    
    
    
}

extension ViewController: AVAudioRecorderDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            recordingEnded(success: false)
        } else {
            recordingEnded(success: true)
        }
    }
    
}

