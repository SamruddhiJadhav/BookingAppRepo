//
//  BookingChainViewController.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import BookingUI
import UIKit

protocol BookingChainViewControllerProtocol: AnyObject {
    func updateDealsList(_ sections: [BookingsSection])
    func showErrorMessage(_ viewModel: ErrorViewModel)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

final class BookingChainViewController: UITableViewController {
    var presenter: BookingChainPresenterProtocol?
    private var bookingSections: [BookingsSection]?

    private var dataSource: UITableViewDiffableDataSource<BookingSection, TripCardViewModel>!
    
    private lazy var loadingIndicatorView = LoadingIndicatorView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupLoadingIndicator()
        setupDataSource()
        presenter?.onViewDidLoad()
    }
}

private extension BookingChainViewController {
    func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.backgroundColor = BUI.Color.backgroundBase.uiColor
        tableView.register(
            TripCardViewCell.self,
            forCellReuseIdentifier: TripCardViewCell.reuseIdentifier
        )
        tableView.register(
            BookingChainHeaderView.self,
            forHeaderFooterViewReuseIdentifier: BookingChainHeaderView.reuseIdentifier
        )
    }
    
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "My bookings"
    }
    
    func setupLoadingIndicator() {
        view.addSubview(loadingIndicatorView)
        NSLayoutConstraint.activate([
            loadingIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<BookingSection, TripCardViewModel>(tableView: tableView) { tableView, indexPath, viewModel in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TripCardViewCell.reuseIdentifier) as? TripCardViewCell else {
                return UITableViewCell()
            }
            cell.configure(viewModel)
            return cell
        }

        dataSource.defaultRowAnimation = .fade
    }
}

extension BookingChainViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: BookingChainHeaderView.reuseIdentifier
        ) as? BookingChainHeaderView else {
            return nil
        }

        let snapshot = dataSource.snapshot()
        let sectionIdentifier = snapshot.sectionIdentifiers[section]

        headerView.configure(with: sectionIdentifier.title)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TripCardViewCell,
        let viewModel = bookingSections?[indexPath.section].tripCards[indexPath.row] else {
            return
        }
        cell.fetchImage(viewModel)
    }
}

extension BookingChainViewController: BookingChainViewControllerProtocol {
    func updateDealsList(_ sections: [BookingsSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<BookingSection, TripCardViewModel>()

        self.bookingSections = sections
        for section in sections {
            snapshot.appendSections([section.bookingType])
            snapshot.appendItems(section.tripCards, toSection: section.bookingType)
        }

        DispatchQueue.main.async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    func showErrorMessage(_ viewModel: ErrorViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(viewModel.errorTitle, viewModel.errorMessage, viewModel.action)
        }
    }

    func showAlert(_ title: String, _ message: String, _ action: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: action,
                                      style: .default,
                                      handler: { [weak self] action in
            self?.presenter?.didTapOk()
        }))

        present(alert, animated: true, completion: nil)
    }

    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicatorView.showLoadingIndicator()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicatorView.hideLoadingIndicator()
        }
    }
}
