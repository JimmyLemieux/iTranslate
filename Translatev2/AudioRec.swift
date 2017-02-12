//
//  AudioRec.swift
//  
//
//  Created by James Lemieux on 2017-01-25.
//
//


//Im going to redo all of this shit
import UIKit
import AVFoundation

class AudioRec: UIViewController,AVAudioRecorderDelegate {

    
    var audioRecorder:AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRecord()

    }
    
    //Set up the AvAudioRecorder
    func initRecord() {
        
    
        do{
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.setActive(true)
            
            //The settings for the avaudiorecorder
            let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),
                                 AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
                                 AVNumberOfChannelsKey : NSNumber(value: 1),
                                 AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]
            
            //The url parameter is where it is saving
         audioRecorder = try AVAudioRecorder(url: documents(), settings: recordSettings)
         audioRecorder?.delegate = self
         audioRecorder?.prepareToRecord()
            
        
        } catch {
         //error handle
        }
        
    }
    
    
    func documents() -> URL {
        //Gain access to the file system locally
        let file = FileManager.default
        //Specify the file types etc
        let url = file.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteURL
        //Add a string to the file component
        let str = url.appendingPathComponent("recording.m4a")
        return str
    }
    
    //Where I will call the play function
    @IBAction func startRecord(_:Any) {
        audioRecorder?.record()
    }
    
    //Call the stop record
    @IBAction func stopRecord(_:Any) {
        audioRecorder?.stop()
    }
    


}
