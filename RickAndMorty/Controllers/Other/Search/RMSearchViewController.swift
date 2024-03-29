//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMSearchViewController: UIViewController {
    struct Config {
        enum `Type` {
            case character 
            case episode 
            case location 

            var endpoint: RMEndpoint {
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }

            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }

        let type: `Type`
    }

    private let viewModel: RMSearchViewViewModel
    private let searchView: RMSearchView

    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search",
            style: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
        searchView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchView.presentKeyboard()
    }

    @objc
    private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }

    func rmSearchView(_ searchView: RMSearchView, didSelectLocation location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func rmSearchView(_ searchView: RMSearchView, didSelectCharacter character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func rmSearchView(_ searchView: RMSearchView, didSelectEpisode episode: RMEpisode) {
        let vc = RMEpisodeDetailViewController(url: URL(string: episode.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

/*
    A classe RMSearchViewController possui uma estrutura aninhada chamada Config que define um tipo 
    enumerado chamado Tipos. Cada caso desse tipo enumerado corresponde a um dos três tipos de busca 
    possíveis: "personagem", "episódio" ou "local". A classe RMSearchViewController também possui uma 
    propriedade chamada viewModel, que é uma instância de uma classe chamada RMSearchViewViewModel, e uma 
    propriedade chamada searchView, que é uma instância de uma classe chamada RMSearchView.

    A classe RMSearchViewController tem um inicializador que aceita um parâmetro de configuração do tipo 
    Config, que é usado para inicializar a propriedade viewModel e a propriedade searchView. A classe 
    também tem uma função chamada viewDidLoad, que é executada quando a visualização é carregada pela 
    primeira vez. Nessa função, o título da visualização é definido com base no tipo de busca especificado 
    na configuração, e a visualização é adicionada à hierarquia de visualização da classe. Além disso, 
    um botão de "pesquisa" é adicionado à barra de navegação e o delegate da propriedade searchView é 
    definido como a própria classe RMSearchViewController.

    A classe RMSearchViewController também implementa o protocolo RMSearchViewDelegate, que possui uma 
    função chamada rmSearchView(_:didSelectOption:). Essa função é chamada quando uma opção é selecionada 
    na visualização de pesquisa. Quando isso acontece, uma nova visualização é criada e exibida modalmente.
*/
