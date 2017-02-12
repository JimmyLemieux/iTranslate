//
//  TranslateView.swift
//  Translatev2
//
//  Created by James Lemieux on 2017-01-08.
//  Copyright © 2017 JamesLemieux. All rights reserved.
//

import UIKit

class TranslateView: UIViewController {
    
    var text: String? = nil

    @IBOutlet var textView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text!
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
