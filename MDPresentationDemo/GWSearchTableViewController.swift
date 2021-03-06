//
//  GWSearchTableViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/17.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

class GWSearchTableViewController: UITableViewController {
    
    enum DisplayState: CaseIterable {
        case minimum
        case medium
        case maximum
        
        var associatedValue: CGFloat {
            switch self {
            case .minimum:
                return 100
            case .medium:
                return 400
            case .maximum:
                return kScreenHeight - 60
            }
        }
    }
    
    var displayState: DisplayState = .medium
    
    var displayFrame: CGRect {
        return CGRect(x: 0,
                      y: displayState.associatedValue,
                      width: kScreenWidth,
                      height: kScreenHeight)
    }
    
    lazy var handleTool: GWPangestureHandleTool = {
        let tool = GWPangestureHandleTool(self, scrollView: self.tableView)
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let points = DisplayState.allCases.map {
            return $0.associatedValue
        }
        handleTool.stickyPoints = points
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Row \(indexPath.row)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
