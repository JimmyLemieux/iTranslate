//
//  SpeakingAi.swift
//  Translatev2
//
//  Created by James Lemieux on 2017-01-21.
//  Copyright © 2017 JamesLemieux. All rights reserved.
//

import Foundation
import TesseractOCR




class Tesseract: UIViewController,G8TesseractDelegate {
    
    var text : String?
    
    func callTesseract(image:UIImage)  {
        
        if let tess = G8Tesseract(language: "eng") {
            
            tess.image = image.g8_blackAndWhite()
            tess.delegate = self
            tess.recognize()
            
            text = tess.recognizedText
        }
    }
    
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        
        print(tesseract.progress)
    }
    
    


    


    
    
    
    
    
    
    
    
    
    
    
    
}
