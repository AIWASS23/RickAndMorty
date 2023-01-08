//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
        addSearchButton()
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

/*
    O RMCharacterViewController que herda de UIViewController e implementa o protocolo 
    RMCharacterListViewDelegate. A classe RMCharacterViewController exibe uma lista de personagens e 
    fornece uma interface para exibir os detalhes de um personagem selecionado.

    A classe tem uma propriedade privada chamada characterListView que é uma instância de 
    RMCharacterListView. Ela também tem um método viewDidLoad que é chamado quando a view do controlador 
    é carregada pela primeira vez. Esse método configura a cor de fundo da view, define o título da view 
    como "Characters" e chama os métodos setUpView e addSearchButton.

    O método addSearchButton adiciona um botão de pesquisa à barra de navegação da view. Quando o botão é 
    tocado, o método didTapSearch é chamado. Esse método cria uma nova instância de RMSearchViewController 
    e empurra essa view para a pilha de navegação.

    O método setUpView adiciona a characterListView à view do controlador e a configura para ocupar toda a 
    tela. Ele também define o controlador atual como o delegate da characterListView.

    O método do protocolo rmCharacterListView(_:didSelectCharacter:) é chamado quando um personagem é 
    selecionado na lista de personagens. Ele cria uma nova instância de RMCharacterDetailViewController 
    com o personagem selecionado e empurra essa view para a pilha de navegação.
*/

