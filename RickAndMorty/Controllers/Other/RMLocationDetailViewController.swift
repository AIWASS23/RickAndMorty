//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMLocationDetailViewController: UIViewController, RMLocationDetailViewViewModelDelegate, RMLocationDetailViewDelegate {

    private let viewModel: RMLocationDetailViewViewModel
    private let detailView = RMLocationDetailView()

    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

        viewModel.delegate = self
        viewModel.fetchLocationData()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc
    private func didTapShare() {

    }

    func rmEpisodeDetailView(
        _ detailView: RMLocationDetailView,
        didSelect character: RMCharacter
    ) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

/*
    RMLocationDetailViewController, que é uma subclasse de UIViewController da biblioteca de interface de 
    usuário UIKit. A classe RMLocationDetailViewController também implementa os protocolos 
    RMLocationDetailViewViewModelDelegate e RMLocationDetailViewDelegate.

    A classe RMLocationDetailViewController possui uma propriedade chamada viewModel, que é uma instância 
    de uma classe chamada RMLocationDetailViewViewModel, e uma propriedade chamada detailView, que é uma 
    instância da classe RMLocationDetailView. Ela tem um inicializador que aceita um parâmetro de 
    localização do tipo RMLocation e usa esse parâmetro para inicializar a propriedade viewModel.

    A classe RMLocationDetailViewController tem uma função chamada viewDidLoad, que é executada quando a 
    visualização é carregada pela primeira vez. Nessa função, a visualização é adicionada à hierarquia de 
    visualização da classe e o delegate da propriedade detailView é definido como a própria classe 
    RMLocationDetailViewController. Além disso, um botão de "ação" é adicionado à barra de navegação e o 
    delegate da propriedade viewModel é definido como a própria classe RMLocationDetailViewController. 
    A função fetchLocationData é chamada para buscar os detalhes da localização.

    A classe RMLocationDetailViewController implementa duas funções do protocolo 
    RMLocationDetailViewDelegate. A primeira delas, rmEpisodeDetailView(_:didSelect:), é chamada quando 
    um personagem é selecionado na visualização de detalhes da localização. Quando isso acontece, uma nova 
    visualização é criada e empurrada para a pilha de navegação da visualização atual. A segunda função do 
    protocolo, didFetchLocationDetails, é chamada quando os detalhes da localização são buscados com sucesso. 
    Nessa função, a visualização é configurada com os detalhes da localização usando a propriedade viewModel.
*/