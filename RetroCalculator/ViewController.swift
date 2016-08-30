//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Chiranth Bangalore Sathyaprakash on 8/21/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    
    var currentOperation = Operation.empty
    
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var btnSound:AVAudioPlayer!
    
    enum Operation:String {
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Multiply = "*"
        case empty = "empty"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.pathForResource("btn", ofType:"wav") // path to file which is in main bundle
        let soundURL = URL(fileURLWithPath: path!) // initialize URL with file path
        
        do { //like try catch block
            try btnSound = AVAudioPlayer(contentsOf: soundURL) // Audioplayer with contents of given URL
            btnSound.prepareToPlay() //get ready to play
        } catch let err as NSError {
            print(err.debugDescription)         }
            }
    
    //this action is applicable to each number
    @IBAction func numberPressed(sender:UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)" // append the tag of clicked number to this string
        outputLabel.text = runningNumber // then assign it to output label
    }
    
    @IBAction func onDividePressed(sender:AnyObject){
        processOperation(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender:AnyObject){
        processOperation(operation: Operation.Multiply)
    }
    @IBAction func onSubtractPressed(sender:AnyObject){
        processOperation(operation: Operation.Subtract)
    }
    @IBAction func onAddPressed(sender:AnyObject){
        processOperation(operation: Operation.Add)
    }
    @IBAction func onEqualPressed(sender:AnyObject){
        processOperation(operation: currentOperation)
    }
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        playSound()
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.empty
        outputLabel.text = "0"
        runningNumber = ""
    }
    
    func playSound(){
        if(btnSound.isPlaying) {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    //func accepts only operation which is of type Operation
    func processOperation(operation:Operation){
        
        playSound()
        
        if(currentOperation != Operation.empty){
            if(runningNumber != ""){
                rightValStr = runningNumber
                runningNumber = ""
                
                if(currentOperation == Operation.Multiply){
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                }
                else if(currentOperation == Operation.Divide){
                 result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                else if(currentOperation == Operation.Add){
                     result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                else if(currentOperation == Operation.Subtract){
                     result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            currentOperation = operation
        }else{
            //Mark:operator pressed for first time
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

