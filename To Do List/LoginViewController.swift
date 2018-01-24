//
//  LoginViewController.swift
//  To Do List
//
//  Created by Joshua Fredrickson on 10/27/17.
//  Copyright © 2017 Joshua Fredrickson. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return button pressed")
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: ACTIONS
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("attempt login")
        
        guard let email = emailTextField.text else { return }
        if email == "" {
            print("Empty email")
            messageAlert(title: "Oops", message: "You forgot to enter your email address", from: self)
        }
        guard let password = passwordTextField.text else { return }
        if password == "" {
            print("Empty password")
            messageAlert(title: "Oops", message: "You forgot to enter your password", from: self)
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil {
                print("Sign in successful")
                // seque?
                //performSegue(withIdentifier: loginToList, sender: nil)
                // or
                self.dismiss(animated: true, completion: {
                    print("login dismissed")
                }) // dismiss push modally segue
                // self.navigationController?.popViewController(animated: true) // dismiss push segue
            } else {
                print("Login failed: \(error?.localizedDescription ?? "Unknown error")")
                messageAlert(title: "Login Failure", message: error?.localizedDescription ?? "Unknown error", from: self)
            }
        }
    }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("starting signup")
        
        let alert = UIAlertController(title: "Sign Up", message: "create a new account", preferredStyle: .alert)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let email = alert.textFields![0].text else { return }
            if email == "" {
                print("Empty email")
                messageAlert(title: "Oops", message: "You forgot to enter your email address", from: self)
            }
            guard let password = alert.textFields![1].text else { return }
            if password == "" {
                print("Empty password")
                messageAlert(title: "Oops", message: "You forgot to enter your password", from: self)
            }
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: email, password: password)
                    print("sign up successful")
                    messageAlert(title: "Welcome", message: "Your account has been created.", from: self)
                    // prepare segue???
                    // dismiss?
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Sign-up failed: \(error?.localizedDescription ?? "Unknown error")")
                    messageAlert(title: "Sign-Up Failed", message: error?.localizedDescription ?? "Unknown error", from: self)
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
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


