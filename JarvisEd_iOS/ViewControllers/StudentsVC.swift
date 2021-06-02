//
//  StudentsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class StudentsVC: BaseVC, UITableViewDelegate, UITableViewDataSource, FirebaseProtocol, InfoButtonProtocol, ConfirmDialogProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oStudentsTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedStudent: JEStudent? = nil
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        
        super.viewDidLoad()
        mFirebaseComm = FirebaseComm(fProtocol: self)
        mFirebaseComm?.getAllStudents(email: JEData.global.getCurrentUser()!.getEmail())
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // ConfirmDialogProtocol Protocol Method
    func confirmResponse(confirm: Bool) {
        
        if (confirm) {
            
            mFirebaseComm?.deleteStudent(email: (JEData.global.getCurrentUser()?.getEmail())!, student: mSelectedStudent!)
            
        }
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JEData.global.getStudentList().count
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: StudentTVC.mReuseIdentifier) as? StudentTVC)!
        
        cell.setCurrentStudent(student: JEData.global.getStudentList()[indexPath.row], index: indexPath.row)
        cell.setInfoProtocol(infoProtocol: self)
        
        return cell
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mSelectedStudent = JEData.global.getStudentList()[indexPath.row]
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        mSelectedStudent = nil
        
    }
    
    // FirebaseProtocol Class Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.DeleteStudent) {
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    // FirebaseProtocol Class Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllStudents) {
            
            if let student = obj as? JEStudent {
                
                JEData.global.addStudentToList(student: student)
                oStudentsTV.reloadData()
                
            }
            
        }
        
    }
    
    // FirebaseProtocol Class Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        print("error occurred")
        if (method == FirebaseComm.FirebaseMethod.GetAllStudents) {
            print("method == GetAllStudents")
            
            createNetworkErrorDialog(message: "Could not retrieve students, please check your connection and try again", retryAction: {
                
                self.mFirebaseComm?.getAllStudents(email: (JEData.global.getCurrentUser()?.getEmail())!)
                
            })
            
        } else if (method == FirebaseComm.FirebaseMethod.DeleteStudent) {
            
            createNetworkErrorDialog(message: "Could not delete student", retryAction: {
                
                self.mFirebaseComm?.deleteStudent(email: (JEData.global.getCurrentUser()?.getEmail())!, student: self.mSelectedStudent!)
                
            })
            
        }
        
    }
    
    // InfoButtonProtocol Protocol Method
    func infoButtonClicked(index: Int) {
        
        performSegueId(id: BaseVC.SegueId.toStudentDetails, obj: JEData.global.getStudentList()[index])
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aAddButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func aEditButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func aDeleteButtonClicked(_ sender: UIButton) {
        
        if (mSelectedStudent != nil) {
            
            createDialog(dialogProtocol: self, type: DialogType.ConfirmDialog, obj: nil)
            
        } else {
            
            createDialog(dialogProtocol: self, type: DialogType.ErrorDialog, obj: "")
            
        }
        
    }
    
}
