//
//  ViewController.swift
//  Alan's Dice Game
//
//  Created by Alan Yao on 2019/4/3.
//  Copyright © 2019 Alan Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var Stake: UILabel!
    @IBOutlet weak var Round: UILabel!
    @IBOutlet weak var TotalMoney: UILabel!
    @IBOutlet weak var Dice_User: UIImageView!
    @IBOutlet weak var Dice_COM: UIImageView!
    
    var totalMoney: Int = 100
    var round: Int = 0
    var num_Com: Int = 0
    var num_User: Int = 0
    var stake: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setBackground()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 100
        resetGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setBackground(){
        let background = UIImage(named: "Background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    func resetGame() {
        totalMoney = 100
        stake = 1
        TotalMoney.text = "\(totalMoney)"
        round = 0
        Round.text = "\(round)"
        Stake.text = "1"
        stepper.value = Double(1)
        slider.value = Float(1)
        Dice_COM.image = UIImage(named: "Roll")
        Dice_User.image = UIImage(named: "Roll")
        
    }
    @IBAction func StartOver(_ sender: UIButton) {
        resetGame()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        //let currentValue = Int(sender.value)
        stepper.value = Double(Float(sender.value))
        //Stake.text = "\(currentValue)"
        Stake.text = Int(sender.value).description
        stake = Int(Int(sender.value).description)!
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        slider.value = Float(sender.value)
        Stake.text = Int(sender.value).description
        stake = Int(Int(sender.value).description)!
    }
    
    
    @IBAction func Roll(_ sender: UIButton) {
        func realRoll() {
            round += 1
            Round.text = "\(round)"
            num_Com = Int(arc4random_uniform(6) + 1)
            num_User = Int(arc4random_uniform(6) + 1)
            print(num_Com)
            print(num_User)
            Dice_COM.image = UIImage(named: "Dice\(num_Com)")
            Dice_User.image = UIImage(named: "Dice\(num_User)")
            
            if num_Com > num_User {
                totalMoney -= Int(Stake.text!)!
                TotalMoney.text = "\(totalMoney)"
                if totalMoney <= 0 {
                    let alert = UIAlertController(title: "You become to a pauper!", message: "Please press 'I'm an idiot' to start over the game", preferredStyle: .alert)
                    let reset = UIAlertAction(title: "I'm an idiot", style: .default) {(action) in
                        self.resetGame()
                    }
                    alert.addAction(reset)
                    self.present(alert, animated: true)
                }
                else {
                    let alert = UIAlertController(title: "You lost!", message: "Please press 'It's Okay' to continue the game", preferredStyle: .alert)
                    let lose = UIAlertAction(title: "It's Okay", style: .default) {(action) in
                    }
                    alert.addAction(lose)
                    self.present(alert, animated: true)
                }
            }
            else if num_Com < num_User {
                totalMoney += Int(Stake.text!)!
                TotalMoney.text = "\(totalMoney)"
                let alert = UIAlertController(title: "You won!", message: "Please press 'I'm the best' to continue the game", preferredStyle: .alert)
                let win = UIAlertAction(title: "I'm the best", style: .default) {(action) in
                }
                alert.addAction(win)
                self.present(alert, animated: true)
            }
            else {
                let alert = UIAlertController(title: "It's a tie!", message: "Please press 'Come On!' to continue the game", preferredStyle: .alert)
                let tie = UIAlertAction(title: "Come On!", style: .default) {(action) in
                }
                alert.addAction(tie)
                self.present(alert, animated: true)
            }
        }
        
        let moneyForAlert: Int = totalMoney - stake
        if moneyForAlert < 0 {
            let alert = UIAlertController(title: "Insufficient Money", message: "Please press 'WHAT?!' to change the stake number", preferredStyle: .alert)
            let insufficient = UIAlertAction(title: "WHAT?!", style: .default) {(action) in
            }
            alert.addAction(insufficient)
            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Are u sure???", message: "You'll only have \(moneyForAlert) left if you lose", preferredStyle: .alert)
            let Yes = UIAlertAction(title: "Yes",
                                    style: .default) {(action) in
                                        realRoll()
            }
            let No = UIAlertAction(title: "No",
                                   style: .default) {(action) in
            }
            alert.addAction(No)
            alert.addAction(Yes)
            
            self.present(alert, animated: true)
            
        }
    }
}


