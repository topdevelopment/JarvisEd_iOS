//
//  ReportsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class ReportsVC: BaseVC, UITableViewDelegate, UITableViewDataSource, FirebaseProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oReportsTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedReport: JEReport? = nil
    
    
    
    /*
     *
     * Lifecycle Methods
     *
     */

    override func viewDidLoad() {
        
        super.viewDidLoad()
        mFirebaseComm = FirebaseComm(fProtocol: self)
        mFirebaseComm?.getAllReports(email: JEData.global.getCurrentUser()!.getEmail())
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllReports) {
            
            if let report = obj as? JEReport {
                
                JEData.global.addReportToList(report: report)
                oReportsTV.reloadData()
                
            }
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        print("error occurred")
        if (method == FirebaseComm.FirebaseMethod.GetAllReports) {
            print("method == GetAllStudents")
            
            createNetworkErrorDialog(message: "Could not retrieve reports, please check your connection and try again", retryAction: {
                
                self.mFirebaseComm?.getAllReports(email: (JEData.global.getCurrentUser()?.getEmail())!)
                
            })
            
        }
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JEData.global.getReportList().count
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: ReportTVC.mReuseIdentifier) as? ReportTVC)!
        
        cell.setCurrentReport(report: JEData.global.getReportList()[indexPath.row])
        
        return cell
        
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mSelectedReport = JEData.global.getReportList()[indexPath.row]
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        mSelectedReport = nil
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aAddReportButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func aAddReportCommentButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
}
