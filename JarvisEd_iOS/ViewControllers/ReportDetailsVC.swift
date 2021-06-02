//
//
//  ReportDetailsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class ReportDetailsVC: UIViewController {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedReport:JEReport? = nil
    
    
    
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
    
    public func setSelectedReport(report:JEReport) {
        
        mSelectedReport = report
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aMenuButtonClicked(_ sender: UIBarButtonItem) {
    }

}
