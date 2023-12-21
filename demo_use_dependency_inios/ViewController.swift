//
//  ViewController.swift
//  demo_use_dependency_inios
//
//  Created by Purva Joshi on 19/12/23.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    
    //MARK:- Variable Declarationtion
    let channel: String = "com.souvikbiswas.tipsy/result"
    var convertedString: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction
    @IBAction func onPressShowFlutterPackage(_ sender: UIButton){
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue("Sent message. Kindly Check.", forKey: "message")
        jsonObject.setValue("1", forKey: "count")
        do {
            let billData =  try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            convertedString = String(data: billData, encoding: String.Encoding.utf8)
        } catch let myJSONError {
            print(myJSONError)
        }
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutteviewcontroller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let resultDataChannel = FlutterMethodChannel(name: channel, binaryMessenger: flutteviewcontroller.binaryMessenger)
        resultDataChannel.invokeMethod("getCalculatedResult", arguments: convertedString)
        present(flutteviewcontroller, animated: true, completion: nil)
    }
    
}

