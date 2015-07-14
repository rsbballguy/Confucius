//
//  ViewController.swift
//  sudokusolver
//
//  Created by Rahul Sundararaman on 7/6/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var myView: UIView!
    @IBOutlet var myTextField: UITextView!
    var arrayOfTextFields:[UITextField] = []
    var arraycount = 0
    var ccount = 0
    var ds:[[Int]] = [[]]
    var tempp:[[Int]] = [[]]
    var label:UILabel = UILabel()
    var padding: CGFloat = 1.0
    var dimensions: CGFloat = 1.0
    var step: CGFloat = 1.0
    var endpoint: CGFloat = 1.0
    var vWidth: CGFloat = 1.0
    var imageSize: CGSize = CGSize()
    var imageView: UIImageView = UIImageView()
    var lightordark = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var swiftColor = UIColor(red: 0.71, green: 0.87, blue: 1, alpha: 1)
        self.view.backgroundColor = swiftColor
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        scrollView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        setupGestureRecognizer()
        vWidth = self.view.bounds.width
        
        #if DEBUG
            println("\(vWidth)")
        #endif
        
        
        padding = floor(vWidth/4.75)
        dimensions = floor(vWidth/18.75)
        step = floor(vWidth/75)+dimensions
        endpoint = (vWidth-padding)
        //Draw rectangles and fill
        imageSize = CGSize(width: (vWidth-(padding*2)) , height: vWidth-(padding*2))
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: padding, y: padding), size: imageSize))
        myView.addSubview(imageView)
        var image = drawCustomImage(imageSize)
        imageView.image = image
        
        var startx = padding+(3*step)
        var starty = padding
        
        imageSize = CGSize(width: ((step*3)-(step-dimensions)) , height: ((step*9)-(step-dimensions)))
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: startx, y: starty), size: imageSize))
        myView.addSubview(imageView)
        image = drawCustomImage(imageSize)
        imageView.image = image
        
        imageSize = CGSize(width: ((step*9)-((step-dimensions))) , height: ((step*3)-(step-dimensions)))
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: starty, y: startx), size: imageSize))
        myView.addSubview(imageView)
        image = drawCustomImage(imageSize)
        imageView.image = image
        
        imageSize = CGSize(width: ((step*3)+(step-dimensions)) , height: ((step*3)+(step-dimensions)))
        
        #if DEBUG
            println((step*3)-(step-dimensions))
            println(((step*3)-(step-dimensions)))
            println("\(startx)   \(starty)")
        #endif
        
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: ((starty+(step*3))-(step-dimensions)), y: (starty+step*3)-(step-dimensions)), size: imageSize))
        myView.addSubview(imageView)
        image = drawCustomImage(imageSize)
        imageView.image = image

        //Start other stuff
        var cc = 0;
        
        #if DEBUG
            println("padding:\(padding)")
            println("dimensions:\(dimensions)")
            println("step:\(step)")
            println("endpoint:\(endpoint)")
        #endif
        
        label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        var xx: CGFloat = 1.0
        var yy: CGFloat = 1.0
        for(var a = padding; a<endpoint; a+=step){
            for(var b=padding; b<endpoint; b+=step){
                xx = CGFloat(a)
                yy = CGFloat(b)
                 var myTextField: UITextField = UITextField(frame: CGRect(x: xx, y: yy, width: dimensions, height: dimensions))
                
                myTextField.text = ""
                myTextField.borderStyle = UITextBorderStyle.Line
                myTextField.keyboardType = UIKeyboardType.NumberPad
                self.arrayOfTextFields.append(myTextField)
                myView.addSubview(myTextField)
                myTextField.delegate = self
            }
        }
        var xbutton = floor(vWidth/2)-(6*dimensions)
        
        #if DEBUG
            println("\(xbutton)")
        #endif
        
        let ybutton = yy+(2*dimensions)
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(xbutton, ybutton, dimensions*5, floor(dimensions*2.5))
        button.setTitle("Solve", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        xbutton = floor(vWidth/2)+dimensions
        let clear   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        clear.frame = CGRectMake(xbutton, ybutton, dimensions*5, floor(dimensions*2.5))
        clear.setTitle("Clear", forState: UIControlState.Normal)
        clear.addTarget(self, action: "buttonClear:", forControlEvents: UIControlEvents.TouchUpInside)
        
        myView.addSubview(clear)
        myView.addSubview(button)
        label.center = CGPointMake(((vWidth/2)), ((step*9)+padding+(2*(step-dimensions))))
        label.textAlignment = NSTextAlignment.Center
        label.text = "IMPOSSIBLE"
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        view.addSubview(scrollView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        ccount=0
        label.hidden = true
        var x = 0
        var y = 0
        var arrayOfInts:[Int] = []
        var arrayOfArrays:[[Int]] = []
        var count = 0
        for textField in arrayOfTextFields{
            if(x == 9 || count==80){
                if(count == 80){
                    if(textField.text == ""){
                        arrayOfInts+=[0]
                    }
                    else{
                        let aaa:Int = textField.text.toInt()!
                        arrayOfInts+=[aaa]
                    }
                }
                arrayOfArrays += [arrayOfInts]
                arrayOfInts = []
                x=0
            }
            if(textField.text == ""){
                arrayOfInts+=[0]
            }
            else{
                let aaa:Int = textField.text.toInt()!
                arrayOfInts += [aaa]
            }
            x++
            count++
        }
        
        
        #if DEBUG
            println(arrayOfArrays)
        #endif
        
        var puzzle:[[Int]]=arrayOfArrays

        var a = fillSudoku(puzzle, row: 0, col: 0)
       
        #if DEBUG
            println(tempp)
        #endif
        
        x = 0
        y = 0
        //Fill in texfield
        if(tempp != [[]]){
            for textField in arrayOfTextFields{
                if(x == 8){
                    textField.text="\(tempp[y][x])"
                    y++
                    x = 0
                }
                else{
                    textField.text="\(tempp[y][x])"
                    x++
                }
                
                if textField.text == "0"{
                    textField.text = ""
                }
                
            }
        }
        else{
            label.hidden = false
        }
        
        tempp = [[]]
    }
    func buttonClear(sender:UIButton!)
    {
        for textField in arrayOfTextFields{
            textField.text=""
        }
        label.hidden=true
    }
    func isAvailable(puzzle: [[Int]], row: Int, col: Int, num: Int)->Int{
        var i: Int
        var j: Int
        for(i=0; i<9; i++){
            if((puzzle[row][i]==num) || (puzzle[i][col]==num)){
                return 0
            }
        }
        var rowStart:Int = (row/3)*3
        var colStart:Int = (col/3)*3
        
        for(var i=rowStart; i<(rowStart+3); i++){
            for(j=colStart; j<(colStart+3); j++){
                if(puzzle[i][j]==num){
                    return 0
                }
            }
        }
        return 1
    }
    func fillSudoku(puzzle: [[Int]], row: Int, col: Int)->Int{
        if(ccount > 100000){
            #if DEBUG
                println("Impossible!")
            #endif
            myView.addSubview(label)
            label.hidden = false
            return 0
        }
        var i:Int
        ccount++
        tempp = puzzle

        if(row<9 && col<9){
            var ttx = tempp[row][col] as Int
            if(ttx != 0){
                if((col+1)<9){
                    return fillSudoku(tempp, row: row, col: col+1)
                }
                else if((row+1)<9){
                    return fillSudoku(tempp, row: row+1, col: 0)
                }
                else{
                    return 1
                }
            }
            else{
                for(i=0; i<9; i++){
                    if(isAvailable(tempp, row: row, col: col, num: i+1)==1){
                        tempp[row][col]=i+1
                        if((col+1)<9){
                            if(fillSudoku(tempp, row: row, col: col+1)==1){
                                return 1
                            }
                            else{
                                tempp[row][col]=0
                            }
                        }
                        else if((row+1)<9){
                            if(fillSudoku(tempp, row: row+1, col: 0)==1){
                                return 1
                            }
                            else{
                                tempp[row][col]=0
                            }
                        }
                        else{
                            return 1
                        }
                    }
                }
            }
            
            ds = tempp
            return 0
        }
        else{
            return 1
        }
    }
    func drawCustomImage(size: CGSize) -> UIImage {
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        var swiftColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        if(lightordark == 0 || lightordark == 3){
            CGContextSetStrokeColorWithColor(context,swiftColor.CGColor)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetFillColorWithColor(context, swiftColor.CGColor)
            lightordark = 1
        }
        else{
            swiftColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1)
            CGContextSetStrokeColorWithColor(context,swiftColor.CGColor)
            CGContextSetLineWidth(context, 2.0)
            CGContextSetFillColorWithColor(context, swiftColor.CGColor)
            lightordark++
        }
        CGContextStrokeRect(context, bounds)
        CGContextFillRect(context, bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func DismissKeyboard(){
        self.view.endEditing(true)
    }
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        myView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return myView
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let numbers = "123456789"
        if numbers.rangeOfString(string) != nil{
    
            var newTextField: UITextField?
            
            if(textField.text != "" && string != ""){
                textField.text = ""
            }
            
            
            var i = find(arrayOfTextFields, textField)
            var tempps = 0
            if(i > 71){
                tempps = i! - 71
                if(i==80){
                    tempps = 0
                }
            }
            else{
                tempps = i! + 9
            }
            newTextField = arrayOfTextFields[tempps]
            textField.text = string
            textField.endEditing(true)
            
            
            if (newTextField == nil){
                return true
            }
            else{
                newTextField!.becomeFirstResponder()
                return false
            }
        }
        else{
            
            textField.text = ""
            return false
        }
    }

}

