import UIKit

class LoadView: UIViewController {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var progressView:UIProgressView!
    @IBOutlet var button:UIButton!
    
    @IBOutlet var textView:UITextView!
    
    
   
    //AYYYYYYY
    var braille = "⠝"
    
    //populated from segue
    var lang:String = ""
    var mess:String = ""
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        
        
        
        
        
        if(lang == "braille"){
            
            print("braille trans")
            
            brailleConfig(message: mess)
        } else {
        }
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    
  
    
          
        print(tempBrailleString)
        //self.performSegue(withIdentifier: "toShow", sender: tempBrailleString!)

        
        
        
        
        
    }
    
    //MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destination = segue.destination as! TranslateView
        destination.text = sender as? String
        
        
    }
    
    
    
}
