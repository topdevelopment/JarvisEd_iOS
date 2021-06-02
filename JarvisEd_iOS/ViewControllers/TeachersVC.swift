//
//  TeachersVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class TeachersVC: BaseVC, UITableViewDelegate, UITableViewDataSource, FirebaseProtocol, InfoButtonProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oTeachersTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedTeacher: JETeacher? = nil
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        
        super.viewDidLoad()
        mFirebaseComm = FirebaseComm(fProtocol: self)
        mFirebaseComm?.getAllTeachers(email: JEData.global.getCurrentUser()!.getEmail())
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JEData.global.getTeacherList().count
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: TeacherTVC.mReuseIdentifier) as? TeacherTVC)!
        
        cell.setCurrentTeacher(teacher: JEData.global.getTeacherList()[indexPath.row], index: indexPath.row)
        cell.setInfoProtocol(infoProtocol: self)
        
        return cell
        
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mSelectedTeacher = JEData.global.getTeacherList()[indexPath.row]
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        mSelectedTeacher = nil
        
    }
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.DeleteTeacher) {
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllTeachers) {
            
            if let teacher = obj as? JETeacher {
                
                JEData.global.addTeacherToList(teacher: teacher)
                oTeachersTV.reloadData()
                
            }
            
        }
        
    }
    
    // FirebaseProtocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllTeachers) {
            
            createNetworkErrorDialog(message: "Could not retrieve teachers, please check your connection and try again", retryAction: {
                
                self.mFirebaseComm?.getAllTeachers(email: (JEData.global.getCurrentUser()?.getEmail())!)
                
            })
            
        } else if (method == FirebaseComm.FirebaseMethod.DeleteTeacher) {
            
            createNetworkErrorDialog(message: "Could not delete teacher, please try again!", retryAction: {
                
                self.mFirebaseComm?.deleteTeacher(email: (JEData.global.getCurrentUser()?.getEmail())!, teacher: self.mSelectedTeacher!)
                
            })
            
        }
        
    }
    
    // InfoButtonProtocol Protocol Method
    func infoButtonClicked(index: Int) {
        
        performSegueId(id: BaseVC.SegueId.toStudentDetails, obj: JEData.global.getTeacherList()[index])
        
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
        
        
        
    }
    
}
