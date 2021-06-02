//
//  ReportTVC.swift
//  JarvisEd_iOS
//  TOP Development
//

import UIKit

class ReportTVC: UITableViewCell {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oReportTitleLabel: UILabel!
    @IBOutlet weak var oReportTypeLabel: UILabel!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    public static let mReuseIdentifier = "reportCell"
    
    
    
    /*
     *
     * Class Methods
     *
     */

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setCurrentReport(report:JEReport) {
        
        oReportTitleLabel.text = report.getId()
        oReportTypeLabel.text = report.getReportType().rawValue
        
    }

}
