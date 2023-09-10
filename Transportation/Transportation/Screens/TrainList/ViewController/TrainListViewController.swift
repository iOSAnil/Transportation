//
//  TrainListViewController.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

final class TrainListViewController: UIViewController, Identifiable {
    private var tableView: UITableView
    private let viewModel: TrainListViewModel
    var subscription: Subscription<TrainListItemViewState>?
    weak var navigationDelegate: TransportNavigationFlowHandler?
    
    private var dataSource = [TrainInformationModel]()
    
    // MARK: Initialization
    init(viewModel: TrainListViewModel) {
        self.viewModel = viewModel
        self.tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }

    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscription = viewModel.publisher?.subscribe(publishImmediately: true, { [weak self] value in
            self?.renderUI(with: value)
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.dispatch(event: .screenAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subscription = nil
        super.viewWillDisappear(animated)
    }
    
    // MARK: Create UI elements on the screen
    private func createUI() {
        self.title = "Trains"
        view.backgroundColor = .systemBackground
      
        tableView = UITableView(delegate: self, dataSource: self)
        tableView.register(cells: [ TrainInformationTableViewCell.self ])
        tableView.embed(in: view, edgeInsets: .zero)
    }
    
    // MARK: Load UI with TrainListItemViewState
    private func renderUI(with viewState: TrainListItemViewState) {
        switch viewState {
        case .loading:
            view.showLoader()
        case let .load(trainModelList):
            view.hideLoader()
            self.dataSource = trainModelList
            tableView.reloadData()
        case let .error(message: message):
            view.hideLoader()
            debugPrint(message)
        }
    }
}

// MARK: UITableViewDataSource
extension TrainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrainInformationTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure = dataSource[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

// MARK: UITableViewDelegate
extension TrainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.dispatch(event: .tubeLineTapped(id: dataSource[indexPath.row].tubeLineId))
    }
}
