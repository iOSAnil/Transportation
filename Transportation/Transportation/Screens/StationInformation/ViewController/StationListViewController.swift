//
//  StationListViewController.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

final class StationListViewController: UIViewController {
    private var tableView: UITableView
    private var subscription: Subscription<StationListViewState>?
    private var dataSource: [StationItemViewState] = []
    
    private let viewModel: StationListViewModel
    
// MARK: Initialization
    init(viewModel: StationListViewModel) {
        self.viewModel = viewModel
        self.dataSource = []
        tableView = UITableView.autoLayout()
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
        subscription = viewModel.publisher.subscribe(publishImmediately: true, { [weak self] viewState in
            self?.renderUI(with: viewState)
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.dispatch(event: .screenAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subscription?.stop()
        subscription = nil
        super.viewWillDisappear(animated)
    }
    

// MARK: Create UI elements on the screen
    private func createUI() {
        view.backgroundColor = .systemBackground
        self.title = StringConstant.station.localized()
        
        tableView.accessibilityIdentifier = AppConstant.AccessibilityIdentifier.stationListTableView.value
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cells: [ StationInformationTableViewCell.self ])
        tableView.embed(in: view, edgeInsets: .zero)
        
        addCustomBackButton(action: #selector(backButtonTapped))
    }
    

// MARK: Load UI with StationListViewState
    private func renderUI(with viewState: StationListViewState) {
        switch viewState {
        case .loading:
            view.showLoader()
        case let .load(model):
            view.hideLoader()
            self.dataSource = model.items
            self.title = model.lineName
            tableView.reloadData()
        case let .error(message: message):
            view.hideLoader()
            viewModel.dispatch(event: .errorReceived(message))
        }
    }
    
    @objc private func backButtonTapped() {
        viewModel.dispatch(event: .backButtonTapped)
    }
}

// MARK: UITableViewDataSource
extension StationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StationInformationTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
