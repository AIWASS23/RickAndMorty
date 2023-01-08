//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {

    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        primaryView.delegate = self
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}

/*
    RMLocationViewController que herda de UIViewController e implementa os protocolos 
    RMLocationViewViewModelDelegate e RMLocationViewDelegate. A classe RMLocationViewController exibe uma 
    lista de localizações e fornece uma interface para exibir os detalhes de uma localização selecionada.

    A classe tem uma propriedade privada chamada primaryView que é uma instância de RMLocationView e uma 
    propriedade privada chamada viewModel que é uma instância de RMLocationViewViewModel. Ela também tem 
    um método viewDidLoad que é chamado quando a view do controlador é carregada pela primeira vez. Esse 
    método adiciona a primaryView à view do controlador, configura a cor de fundo da view, define o título 
    da view como "Locations" e chama os métodos addSearchButton, addConstraints, e viewModel.fetchLocations().

    O método addSearchButton adiciona um botão de pesquisa à barra de navegação da view. Quando o botão é 
    tocado, o método didTapSearch é chamado. Esse método cria uma nova instância de RMSearchViewController 
    e empurra essa view para a pilha de navegação.O método addConstraints adiciona restrições à primaryView 
    para que ela ocupe toda a tela.

    O método do protocolo rmLocationView(_:didSelect:) é chamado quando uma localização é selecionada na 
    lista de localizações. Ele cria uma nova instância de RMLocationDetailViewController com a localização 
    selecionada e empurra essa view para a pilha de navegação.

    O método do protocolo didFetchInitialLocations é chamado quando a lista inicial de localizações é 
    recuperada pelo viewModel. Esse método configura a primaryView com o viewModel.
*/