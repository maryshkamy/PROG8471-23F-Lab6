//
//  TableViewController.swift
//  Lab6MarianaRiosSilveiraCarvalho
//
//  Created by Mariana Rios Silveira Carvalho on 2023-10-14.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Private Properties
    private let viewModel: ViewModelProtocol = ViewModel()

    // MARK: - @IBOutlets
    @IBOutlet weak var add: UIBarButtonItem!

    // MARK: - UITableViewController Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.saveData()
    }

    // MARK: - @IBActions Buttons
    @IBAction func didTapAddBarButton(_ sender: UIBarButtonItem) {
        self.createUIAlert()
    }

    // MARK - Private Functions
    private func setup() {
        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func loadData() {
        self.viewModel.loadData()
        self.tableView.reloadData()
    }

    private func createUIAlert() {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Write an item"
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned alert] _ in
            self.viewModel.add(item: alert.textFields![0].text)
            self.tableView.reloadData()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSoure.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.dataSoure[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
