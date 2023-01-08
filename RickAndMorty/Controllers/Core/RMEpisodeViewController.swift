//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setUpView()
        addSearchButton()
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setUpView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

/*
    O RMEpisodeViewController que herda de UIViewController e implementa o protocolo 
    RMEpisodeListViewDelegate. A classe RMEpisodeViewController exibe uma lista de episódios e fornece 
    uma interface para exibir os detalhes de um episódio selecionado.

    A classe tem uma propriedade privada chamada episodeListView que é uma instância de RMEpisodeListView. 
    Ela também tem um método viewDidLoad que é chamado quando a view do controlador é carregada pela 
    primeira vez. Esse método configura a cor de fundo da view, define o título da view como "Episodes" 
    e chama os métodos setUpView e addSearchButton.

    O método addSearchButton adiciona um botão de pesquisa à barra de navegação da view. Quando o botão é 
    tocado, o método didTapSearch é chamado. Esse método cria uma nova instância de RMSearchViewController 
    e empurra essa view para a pilha de navegação.

    O método setUpView adiciona a episodeListView à view do controlador e a configura para ocupar toda a 
    tela. Ele também define o controlador atual como o delegate da episodeListView.

    O método do protocolo rmEpisodeListView(_:didSelectEpisode:) é chamado quando um episódio é selecionado 
    na lista de episódios. Ele cria uma nova instância de RMEpisodeDetailViewController com a URL do 
    episódio selecionado e empurra essa view para a pilha de navegação.
*/
