//
//  TeacherDetailsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class TeacherDetailsVC: BaseVC, UITableViewDataSource, UITableViewDelegate, FirebaseProtocol, ConfirmDialogProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oTeacherNameLabel: UILabel!
    @IBOutlet weak var oTeacherReportsTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedTeacher:JETeacher? = nil
    private var mTeacherReportList:[JEReport] = []
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // ConfirmDialogProtocol Protocol Method
    func confirmResponse(confirm: Bool) {
        
        if (confirm) {
            
            mFirebaseComm?.deleteTeacher(email: (JEData.global.getCurrentUser()?.getEmail())!, teacher: mSelectedTeacher!)
            
        }
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mTeacherReportList.count
        
    }
    
    // UITableViewDataSourceClass Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTVC.mReuseIdentifier) as! ReportTVC
        
        cell.setCurrentReport(report: mTeacherReportList[indexPath.row])
        
        return cell
        
    }
    
    public func setSelectedTeacher(teacher:JETeacher) {
        
        mSelectedTeacher = teacher
        oTeacherNameLabel.text = teacher.getFullName()
        
    }
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.DeleteTeacher) {
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        
        
    }
    
    // FirebaseProtocol Protocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.DeleteTeacher) {
            
            createNetworkErrorDialog(message: "Could not delete Teacher, please try again!", retryAction: {
                
                self.mFirebaseComm?.deleteTeacher(email: (JEData.global.getCurrentUser()?.getEmail())!, teacher: self.mSelectedTeacher!)
                
            })
            
        }
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aBackButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func aDeleteTeacherButtonClicked(_ sender: UIButton) {
        
        createDialog(dialogProtocol: self, type: DialogType.ConfirmDialog, obj: nil)
        
    }
    
}
