//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var Guess: UITextField!
    
    @IBOutlet weak var currentProgress: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView?
    
    var myhangmanGame: Hangman?
    
    var count = 0
    var progressCount = 0
    
    let image1 = UIImage(named: "basic-hangman-img/hangman1.png")
    let image2 = UIImage(named: "basic-hangman-img/hangman2.png")
    let image3 = UIImage(named: "basic-hangman-img/hangman3.png")
    let image4 = UIImage(named: "basic-hangman-img/hangman4.png")
    let image5 = UIImage(named: "basic-hangman-img/hangman5.png")
    let image6 = UIImage(named: "basic-hangman-img/hangman6.png")
    let image7 = UIImage(named: "basic-hangman-img/hangman7.png")
    
    var myArray: NSMutableArray?
    

    @IBAction func guess(sender: UIButton) {
        let mycurrentGuess = Guess!.text
    
        
        
        // Checking for a valid guess
        var contains: Bool = false
        
        for element in myhangmanGame!.possibleLetters {
            if element == mycurrentGuess {
                contains = true
            }
        }
        //
        
    
        
        if (contains == false) {
            invalidGuessAlert()
        }
        
        else {
            let goodGuess: Bool = myhangmanGame!.guessLetter(mycurrentGuess!)
            if (goodGuess) {
                currentProgress!.text = myhangmanGame!.knownString
                var finished: Bool = true
                for (var i=0; i < myhangmanGame!.knownString!.characters.count; i += 1) {
                    if ((myhangmanGame!.knownString! as NSString).substringWithRange(NSMakeRange(i, 1)) == "_") {
                        finished = false
                    }
                }
                if finished {
                    youWonAlert()
                }

            }
            else {
                count = count + 1
                myImageView!.image = myArray![count] as! UIImage
            }
        }
        
        
        
        
        if (count == 6) {
            youLostAlert()
        }
        
        if (Guess!.text == myhangmanGame!.answer) {
            youWonAlert()
        }
        
        

        
    }
                
        
        
        
        
    
    @IBAction func RandomGuess(sender: UIButton) {
        let randomIndex = Int(arc4random_uniform(UInt32(myhangmanGame!.possibleLetters.count)))
        let randomGuess = myhangmanGame!.possibleLetters[randomIndex]
        
        let goodGuess: Bool = myhangmanGame!.guessLetter(randomGuess)
        if (goodGuess) {
            currentProgress!.text = myhangmanGame!.knownString
            var finished: Bool = true
            for (var i=0; i < myhangmanGame!.knownString!.characters.count; i += 1) {
                if ((myhangmanGame!.knownString! as NSString).substringWithRange(NSMakeRange(i, 1)) == "_") {
                    finished = false
                }
            }
            if finished {
                youWonAlert()
            }
            
        }
        else {
            count = count + 1
            myImageView!.image = myArray![count] as! UIImage
        }
        
        
        if (count == 6) {
            youLostAlert()
        }
        
        if (Guess!.text == myhangmanGame!.answer) {
            youWonAlert()
        }
        
        
    }
    
    @IBAction func newGame(sender: UIButton) {
        New()
    }
    
    func New() {
        myhangmanGame!.start()
        Guess.text = "Provide your next answer here"
        currentProgress.text = myhangmanGame?.knownString
        count = 0
        myImageView!.image = image1
    }
    
    
    func invalidGuessAlert() {
        let invalidGuessAlertController: UIAlertController = UIAlertController(title: "Alert", message: "Must choose one valid uppercase letter", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
            // Do nothing here
        }
        invalidGuessAlertController.addAction(cancelAction)
        
        self.presentViewController(invalidGuessAlertController, animated: true, completion: nil)
        
    }
    
    
    
    
    func youLostAlert() {
        let loserAlertController: UIAlertController = UIAlertController(title: "Alert", message: "You have lost. The correct answer is:" + myhangmanGame!.answer, preferredStyle: .Alert)
        
        let newGameAction: UIAlertAction = UIAlertAction(title: "New Game", style: .Cancel) { action -> Void in
            self.New()
        }
        
        loserAlertController.addAction(newGameAction)
        
        self.presentViewController(loserAlertController, animated: true, completion: nil)
    }
    
    
    
    
    
    func youWonAlert() {
        let winnerAlertController: UIAlertController = UIAlertController(title: "Congratulations!", message: "You have Won!!! ", preferredStyle: .Alert)
        
        let newGameAction: UIAlertAction = UIAlertAction(title: "New Game", style: .Cancel) { action -> Void in
            self.viewDidLoad()
        }
        
        winnerAlertController.addAction(newGameAction)
        
        self.presentViewController(winnerAlertController, animated: true, completion: nil)

    }

    
    
    override func viewDidLoad() {
        
        myhangmanGame = Hangman()
        myhangmanGame!.start()
        currentProgress.text = myhangmanGame!.knownString
        myImageView!.image = image1
        
        myArray = NSMutableArray()
        myArray!.addObject(image1!)
        myArray!.addObject(image2!)
        myArray!.addObject(image3!)
        myArray!.addObject(image4!)
        myArray!.addObject(image5!)
        myArray!.addObject(image6!)
        myArray!.addObject(image7!)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

