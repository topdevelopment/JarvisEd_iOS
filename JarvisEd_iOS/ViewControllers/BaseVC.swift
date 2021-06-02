//
//  BaseVC.swift
//  JarvisEd_iOS
//  TOP Development
//

import UIKit

class BaseVC: UIViewController {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedStudent: JEStudent? = nil
    private var mSelectedTeacher: JETeacher? = nil
    private var mSelectedReport: JEReport? = nil
    var mFirebaseComm: FirebaseComm? = nil
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == SegueId.toStudentDetails.rawValue) {
            
            if let student = mSelectedStudent {
                let destination = segue.destination as! StudentDetailsVC
                destination.setSelectedStudent(student: student)
            }
            
        } else if (segue.identifier == SegueId.toTeacherDetails.rawValue) {
            
            if let teacher = mSelectedTeacher {
                let destination = segue.destination as! TeacherDetailsVC
                destination.setSelectedTeacher(teacher: teacher)
            }
            
        } else if (segue.identifier == SegueId.toReportDetails.rawValue) {
            
            if let report = mSelectedReport {
                let destination = segue.destination as! ReportDetailsVC
                destination.setSelectedReport(report: report)
            }
            
        }
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func performSegueId(id: SegueId) {
        
        performSegue(withIdentifier: id.rawValue, sender: nil)
        
    }
    
    public func performSegueId(id: SegueId, obj: AnyObject) {
        
        if (id == SegueId.toStudentDetails) {
            
            if let student = obj as? JEStudent {
                
                mSelectedStudent = student
                performSegue(withIdentifier: id.rawValue, sender: nil)
                
            }
            
        } else if (id == SegueId.toTeacherDetails) {
            
            if let teacher = obj as? JETeacher {
                
                mSelectedTeacher = teacher
                performSegue(withIdentifier: id.rawValue, sender: nil)
                
            }
            
        } else if (id == SegueId.toReportDetails) {
            
            if let report = obj as? JEReport {
                
                mSelectedReport = report
                performSegue(withIdentifier: id.rawValue, sender: nil)
                
            }
            
        }
        
    }
    
    public func createMessageDialog(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    public func createNetworkErrorDialog(message:String, retryAction:@escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {_ in
            
            retryAction()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    public func createDialog(dialogProtocol:DialogProtocol, type:DialogType, obj:AnyObject?) {
        
        // ConfirmDialog
        if (type == DialogType.ConfirmDialog) {
            
            // contains valid protocol type
            if let confirmDialogProtocol = dialogProtocol as? ConfirmDialogProtocol {
                
                // contains message
                if let message = obj as? String {
                    
                    let alert = UIAlertController(title: "Are You Sure?", message: message, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
                        _ in
                        
                        
                        
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    self.present(alert, animated: true)
                   
                // does not contain message
                } else {
                    
                    let alert = UIAlertController(title: "Are You Sure?", message: "", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {
                        _ in
                        
                        
                        
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    self.present(alert, animated: true)
                    
                }
               
            // does not contain valid protocol type
            } else {
                
                createDialog(dialogProtocol: dialogProtocol, type: DialogType.ErrorDialog, obj: nil)
                
            }
            
        // ErrorDialog
        } else if (type == DialogType.ErrorDialog) {
            
            let alert = UIAlertController(title: "Error Occurred", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        // CreateStudent
        } else if (type == DialogType.CreateStudent) {
            
            // contains valid protocol
            if let callback = dialogProtocol as? CreateStudentProtocol {
                
                let alert = UIAlertController(title: "Create Student", message: "Enter Student Name", preferredStyle: .alert)
                alert.addTextField(configurationHandler: {
                    textfield in
                    textfield.placeholder = "Student Name"
                    textfield.keyboardType = .default
                })
                alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {
                    _ in
                    
                    if let tf = alert.textFields?.first {
                        
                        callback.studentCreated(fullName: tf.text!)
                        
                    }
                    
                }))
                
            } else {
                
                createDialog(dialogProtocol: dialogProtocol, type: DialogType.ErrorDialog, obj: nil)
                
            }
            
        // CreateTeacher
        } else if (type == DialogType.CreateTeacher) {
            
            // contains valid protocol
            if let callback = dialogProtocol as? CreateTeacherProtocol {
                
                let alert = UIAlertController(title: "Create Teacher", message: "Enter Teacher Name", preferredStyle: .alert)
                alert.addTextField(configurationHandler: {
                    textfield in
                    textfield.placeholder = "Teacher Name"
                    textfield.keyboardType = .default
                })
                alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {
                    _ in
                    
                    if let tf = alert.textFields?.first {
                        
                        callback.teacherCreated(fullName: tf.text!)
                        
                    }
                    
                }))
                
            } else {
                
                createDialog(dialogProtocol: dialogProtocol, type: DialogType.ErrorDialog, obj: nil)
                
            }
            
        // CreateAdmin
        } else if (type == DialogType.CreateAdmin) {
            
            // contains valid protocol
            if let callback = dialogProtocol as? CreateAdminProtocol {
                
                let alert = UIAlertController(title: "Create Admin", message: "Enter Admin Name", preferredStyle: .alert)
                alert.addTextField(configurationHandler: {
                    textfield in
                    textfield.placeholder = "Admin Name"
                    textfield.keyboardType = .default
                })
                alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {
                    _ in
                    
                    if let tf = alert.textFields?.first {
                        
                        callback.adminCreated(fullName: tf.text!)
                        
                    }
                    
                }))
                
            } else {
                
                createDialog(dialogProtocol: dialogProtocol, type: DialogType.ErrorDialog, obj: nil)
                
            }
            
        }
        
    }
    
    
    
    /*
     *
     * Enum: SegueId
     *
     */
    
    public enum SegueId : String {
        
        case toLogin, toSignUp, toCore, toStudentDetails, toTeacherDetails, toReportDetails
        
    }

}
