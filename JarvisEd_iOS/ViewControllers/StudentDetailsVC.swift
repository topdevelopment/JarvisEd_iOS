//
//  StudentDetailsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class StudentDetailsVC: BaseVC, UITableViewDelegate, UITableViewDataSource, FirebaseProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oStudentNameLabel: UILabel!
    @IBOutlet weak var oStudentReportsTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedStudent: JEStudent? = nil
    private var mStudentReportList:[JEReport] = []
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        
        super.viewDidLoad()
        if (mSelectedStudent != nil) {
            oStudentNameLabel.text = mSelectedStudent!.getFullName()
        }
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mStudentReportList.count
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportTVC.mReuseIdentifier) as! ReportTVC
        
        cell.setCurrentReport(report: mStudentReportList[indexPath.row])
        
        return cell
        
    }
    
    public func setSelectedStudent(student:JEStudent) {
        
        mSelectedStudent = student
        
    }
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        
        
    }
    
    // FirebaseProtocol Protocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aBackButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func aDeleteStudentButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
}
