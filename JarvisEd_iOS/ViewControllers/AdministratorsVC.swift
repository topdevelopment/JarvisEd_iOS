//
//  AdministratorsVC.swift
//  JarvisEd_iOS
//  TOP Development
//
//

import UIKit

class AdministratorsVC: BaseVC, UITableViewDelegate, UITableViewDataSource, FirebaseProtocol, InfoButtonProtocol, ConfirmDialogProtocol {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oAdminTV: UITableView!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mSelectedAdmin: JEAdmin? = nil
    
    
    
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
            
            mFirebaseComm?.deleteAdmin(email: (JEData.global.getCurrentUser()?.getEmail())!, admin: mSelectedAdmin!)
            
        }
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JEData.global.getAdminList().count
        
    }
    
    // UITableViewDataSource Class Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: AdminTVC.mReuseIdentifier) as? AdminTVC)!
        
        cell.setCurrentAdmin(admin: JEData.global.getAdminList()[indexPath.row], index: indexPath.row)
        cell.setInfoProtocol(infoProtocol: self)
        
        return cell
        
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mSelectedAdmin = JEData.global.getAdminList()[indexPath.row]
        
    }
    
    // UITableViewDelegate Class Method
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        mSelectedAdmin = nil
        
    }
    
    // FirebaseProtocol Protocol Method
    func successResponse(method: FirebaseComm.FirebaseMethod) {
        
        
        
    }
    
    // FirebaseProtocol Protocol Method
    func successObjResponse(method: FirebaseComm.FirebaseMethod, obj: AnyObject) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllAdmins) {
            
            if let admin = obj as? JEAdmin {
                
                JEData.global.addAdminToList(admin: admin)
                oAdminTV.reloadData()
                
            }
            
        }
        
    }
    
    // FirebaseProtocol Protocol Method
    func errorResponse(method: FirebaseComm.FirebaseMethod) {
        
        if (method == FirebaseComm.FirebaseMethod.GetAllAdmins) {
            
            createNetworkErrorDialog(message: "Could not retrieve administrators, please check your connection and try again", retryAction: {
                
                self.mFirebaseComm?.getAllAdmins(email: (JEData.global.getCurrentUser()?.getEmail())!)
                
            })
            
        }
        
    }
    
    // InfoButtonProtocol Protocol Method
    func infoButtonClicked(index: Int) {
        
        
        
    }
    
    
    
    /*
     *
     * UIAction Events
     *
     */
    
    @IBAction func aAddButtonClicked(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func aDeleteButtonClicked(_ sender: UIButton) {
        
        createDialog(dialogProtocol: self, type: DialogType.ConfirmDialog, obj: "This action cannot be undone")
        
    }
    
}
