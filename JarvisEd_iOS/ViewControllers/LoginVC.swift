//
//  LoginVC.swift
//  JarvisEd_iOS
//  TOP Development
//

import UIKit

class LoginVC: BaseVC, FirebaseProtocol {
    
    /*
     *
     * UI Outlets
     *
     */
    
    @IBOutlet weak var oEmailTF: UITextField!
    @IBOutlet weak var oPasswordTF: UITextField!
    @IBOutlet weak var oQuoteLabel: UILabel!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        
        super.viewDidLoad()
        oQuoteLabel.text = EdQuotes.global.getRandomQuote()
        mFirebaseComm = FirebaseComm.init(fProtocol: self)
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.AttemptLogin) {
            
            print("AttemptLogin success")
            mFirebaseComm?.getUserInfo(email: oEmailTF.text!)
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        if (method == FirebaseComm.FirebaseMethod.getUserInfo) {
            
            print("GetUserInfo success")
            if let user = obj as? JEUser {
                
                print("obj instance of JEUser")
                JEData.global.setCurrentUser(user: user)
                performSegueId(id: BaseVC.SegueId.toCore)
                
            }
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.AttemptLogin) {
            
            createMessageDialog(title: "Invalid Login", message: "Please Try Again")
            
        }
        
    }
    
    
    
    /*
     *
     * UI Actions
     *
     */
    
    @IBAction func aLoginButtonClicked(_ sender: UIButton) {
        
        if (oEmailTF.text!.isEmpty) {
            
            createMessageDialog(title: "Invalid Email", message: "Enter a valid email to continue")
            return
            
        }
        
        if (oPasswordTF.text!.isEmpty) {
            
            createMessageDialog(title: "Invalid Password", message: "Enter a valid password to continue")
            return
            
        }
        
        mFirebaseComm?.attemptLogin(email: oEmailTF.text!, password: oPasswordTF.text!)
        
    }
    
    @IBAction func aSignUpButtonClicked(_ sender: UIButton) {
        
        performSegueId(id: SegueId.toSignUp)
        
    }
    
}
