//
//  ViewController.swift
//  Translatev2
//
//  Created by James Lemieux on 2017-01-08.
//  Copyright © 2017 JamesLemieux. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    var dict:[String:String] = [:]
    var langName = [String]()
    var langCode = [String]()
    var tempIndex : Int?
    
    var tempLang:String?
    
    var BASE_URL:String?
    
    var jsonString:String?
    var tempBrailleString:String = ""
    var count:Int = 0
    
    
    var brailleDict:[Character:String] = [:]
    
    var time:DispatchTime! {
        return DispatchTime.now() + 1.0 // seconds
    }
    
    
    @IBOutlet var textView:UITextView!
    @IBOutlet var pickerView:UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        textView.delegate = self
        
        textView.returnKeyType = .go
        textView.keyboardType = .default
        textView.resignFirstResponder()

        dict = [
            "French" : "en-fr",
            "Russian": "en-ru",
            "Spanish": "en-es",
            "Chinese": "en-zh",
            "Hebrew" : "en-he",
            "Japenese": "en-js",
            "Latin": "en-la",
            "Greek": "en-el",
            "Braille" : "braille"
        ]
        
        brailleDict = [
            " " : " ",
            "a" : " ",
            "b" : " ",
            "c" : "⠁",
            "d" : "⠃",
            "e" : "⠉",
            "f" : "⠙",
            "g" : "⠑",
            "h" : "⠋",
            "i" : "⠣",
            "j" : "⠊",
            "k" : "⠚",
            "l" : "⠅",
            "m" : "⠇",
            "n" : "⠍",
            "o" : "⠝",
            "p" : "⠕",
            "q" : "⠏",
            "r" : "⠟",
            "s" : "⠗",
            "t" : "⠌",
            "u" : "⠥",
            "v" : "⠧",
            "w" : "⠺",
            "x" : "⠭",
            "y" : "⠽",
            "z" : "⠵"
        ]
            
    
        for(index,element) in dict {
            langName.append(index)
            langCode.append(element)
        }
    
    
    
    
    
    }
    
////////////////////////////////
    
    //MARK: Actions
    @IBAction func translateButton(_:Any){
        switch tempLang {
        case nil: alert(title: "NO LANGUAGE", message: "Please select a language")
        case "braille"?: brailleConfig(message: self.textView.text)
        default:
            setupTranslate(language: tempLang, messageText: self.textView.text)

        }
    }
    
    @IBAction func cameraView(_:Any){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.allowsEditing = false
        
        self.present(pickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func recordView(_:Any){
        
        
        
        
        
        
    }

////////////////////////////////

    //MARK: Translation Functions
    
    func setupTranslate(language:String?,messageText:String?){
        
        
        if(language != nil && messageText != nil){
            
            BASE_URL = "https://translate.yandex.net/api/v1.5/tr.json/translate?lang="+language!+"&text="+messageText!+"&key=trnsl.1.1.20161220T042033Z.b5f159689cdee9ca.aa6b6ad214dabfea32307230917e465a9811fa22"
            
            BASE_URL = BASE_URL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        }
        let request = URLRequest(url: URL(string: BASE_URL!)!)
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if(error == nil){
                
                DispatchQueue.main.asyncAfter(deadline: self.time, execute: {
                    
                    let json = JSON(data:data!)
                    self.jsonString = json["text"][0].string!
                    if(self.jsonString != nil){
                        print(self.jsonString!)
                        
                        self.performSegue(withIdentifier: "toShow", sender: self.jsonString!)
                    }
                    
                })
                
            }
            
            
            }.resume()
        
    }
    
    // I made this on my own XD
    func brailleConfig(message:String) {
        let range = message.characters.count
        print(range)
        //loops through message
        for i in message.characters {
            //loop through dict
            for (key, value) in brailleDict {
                //compare the key and char, then get braille from dict value
                if(i == key) {
                    count += 1
                    tempBrailleString += value
                    //When finished going through string, send it!
                    if(count == range){
                        self.performSegue(withIdentifier: "toShow", sender: tempBrailleString)
                        print("done")
                    }
                } 
                
            }
        }
    }
    
        

    
    ///////////////////////////////////////
    
    
    //MARK: Delegate methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toShow":let destination = segue.destination as! TranslateView
        destination.text = sender as! String?
        case"toAudio":_ = segue.destination as! AudioRec
            //Send stuff over here
        default:
            print("the segue")
        }
        
       
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempLang = langCode[row]
        tempIndex = row
        if(tempIndex == 1){
            
            alert(title: "Warning", message: "The Braille translator does not work properly with capitals, a bug I am working on")
        }
        print(tempIndex)
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return langName[row]
    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //If it user selects the return key
        if(text == "\n"){
            textView.resignFirstResponder()
            print("hey")
            return false
            
            
        }
        
        return true
    }

    
    
    //Picked images

    
    //Retreiving instance of image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let tes = Tesseract()
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //Here is where we send in tesseract buddy!!!
        tes.callTesseract(image: image!)
        
    }
    
    
    
  ////////////////////////////////////////////
    
    //MARK: alert views
    
    func alert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true , completion: nil)
    }
    
    
    
}

