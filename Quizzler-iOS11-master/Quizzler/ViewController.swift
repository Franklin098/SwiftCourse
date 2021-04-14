//
//  ViewController.swift
//  Quizzler
//
// Code by Franklin098

import UIKit
import iosMath
import RichTextView

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber:Int = 0
    var score:Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!

    @IBOutlet weak var viewNueva: UIView!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: RichTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nextQuestion()
        
        let label:MTMathUILabel = MTMathUILabel()
        
        label.latex = "hola esto es x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}"
        
        label.sizeToFit()
        
        let richTextView = RichTextView(
            input: "Test : \n [math]x^n  \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}[/math]",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
            textColor: UIColor.black,
            isSelectable: false,
            isEditable: false,
            latexTextBaselineOffset: 0,
            interactiveTextColor: UIColor.blue,
            textViewDelegate: nil,
            frame: CGRect.init(x: 0, y: 0, width: view1.frame.width, height: view1.frame.height),
            completion: nil
        )
        
        richTextView.sizeToFit()
        
        view2.update(
            input: "Test : \n [math]x^n  \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}[/math]",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
            textColor: UIColor.black,
            latexTextBaselineOffset: 0,
            interactiveTextColor: UIColor.blue,
            completion: nil
        )
    

        view1.tag = 2
        viewNueva.tag = 55
        
        
        view1.addSubview(richTextView)
        
        print(iosMathVersionNumber)
        
        
        view1.isUserInteractionEnabled = true
        
        richTextView.isUserInteractionEnabled = true
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.clickLabel(_:)))
        
        tapgesture.numberOfTapsRequired = 1
        
        viewNueva.isUserInteractionEnabled = true
        
        richTextView.addGestureRecognizer(tapgesture)
        
        //viewNueva.addGestureRecognizer(tapgesture)
    }
    
    
    @objc func clickLabel(_ sender:UITapGestureRecognizer){
        print("CLICKKKK \( sender.view!.tag)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func answerPressed(_ sender: AnyObject) {
        pickedAnswer = sender.tag == 1
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    func updateUI() {
        scoreLabel.text = "Score : \(score)"
        progressLabel.text = "\(questionNumber + 1 ) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    
    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the question, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
        }
    }
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.list[questionNumber].answer {
            ProgressHUD.showSuccess("Correct")
        }else{
            ProgressHUD.showError("Wrong !")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
