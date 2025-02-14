//
//  BookingChainPresenter.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

protocol BookingChainPresenterProtocol {
    func onViewDidLoad()
    func didTapOk()
}

final class BookingChainPresenter: BookingChainPresenterProtocol {
    private weak var view: BookingChainViewControllerProtocol?
    private let interactor: BookingChainInteractorProtocol
    private let datasourceBuilder: BookingChainDataSourceBuilderProtocol
    
    init(
        view: BookingChainViewControllerProtocol,
        interactor: BookingChainInteractorProtocol,
        datasourceBuilder: BookingChainDataSourceBuilderProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.datasourceBuilder = datasourceBuilder
    }
    
    func onViewDidLoad() {
        view?.showLoadingIndicator()
        interactor.fetchBookings(userId: 8984747) { [weak self] chainList in
            guard let self = self else {
                return
            }
            let sections = self.datasourceBuilder.bookingsSection(chainList)
            self.view?.hideLoadingIndicator()
            self.view?.updateDealsList(sections)
        } onError: { [weak self] errorMessage in
            guard let self = self else {
                return
            }
            let viewModel = self.datasourceBuilder.errorViewModel(errorMessage)
            self.view?.showErrorMessage(viewModel)
            self.view?.hideLoadingIndicator()
        }
    }
    
    func didTapOk() {}
}
