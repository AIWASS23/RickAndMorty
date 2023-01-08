//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    private let viewModel: RMCharacterDetailViewViewModel
    private let detailView: RMCharacterDetailView

    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstraints()

        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }

    @objc
    private func didTapShare() {
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifer,
                for: indexPath
            ) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .information:
            break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = RMEpisodeDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

/*
    RMCharacterDetailViewController que herda de UIViewController. Essa classe é usada para exibir detalhes 
    de um personagem específico de uma série de televisão ou quadrinhos. A classe tem uma propriedade 
    privada chamada viewModel que é um RMCharacterDetailViewViewModel e uma propriedade privada chamada 
    detailView que é uma instância de RMCharacterDetailView.

    A classe implementa os protocolos UICollectionViewDelegate e UICollectionViewDataSource para 
    fornecer os dados e configurar a apresentação de células em uma coleção de visualização que é exibida 
    na tela.

    O método viewDidLoad é chamado quando a view do controlador é carregada pela primeira vez. Ele 
    configura a cor de fundo da view, define o título da view como o título do personagem, adiciona a 
    detailView à view do controlador e adiciona um botão de compartilhamento à barra de navegação. 
    Também chama o método addConstraints para adicionar restrições de layout à detailView e configura a 
    coleção de visualização para usar o RMCharacterDetailViewController como seu delegado e fonte de dados.

    O método didTapShare é chamado quando o botão de compartilhamento é tocado pelo usuário. Atualmente, 
    ele não faz nada, mas pode ser usado para compartilhar informações sobre o personagem com outras pessoas.

    O método addConstraints adiciona restrições de layout à detailView para que ela preencha toda a área 
    segura da view do controlador.

    Os métodos numberOfSections, numberOfItemsInSection e cellForItemAt são implementações do protocolo 
    UICollectionViewDataSource e são usados para fornecer os dados e configurar a apresentação de células 
    na coleção de visualização. O método didSelectItemAt é uma implementação do protocolo 
    UICollectionViewDelegate e é chamado quando o usuário toca em uma célula da coleção de visualização. 
    Ele abre um controlador de visualização de detalhes para um episódio específico se a seção selecionada 
    for de episódios.
*/
