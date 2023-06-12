//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 08/01/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView"

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    public func startAnimating() {
        spinner.startAnimating()
    }
}

/*
    RMFooterLoadingCollectionReusableView, que é um tipo de "visualização de coleção reciclável"
    para o iOS. Isso é usado para exibir um spinner (indicador de atividade) na parte inferior de uma
    coleção (por exemplo, uma lista de itens) quando mais itens estão sendo carregados.

    A classe tem uma propriedade interna chamada spinner, que é uma instância de UIActivityIndicatorView
    (um componente da interface do usuário fornecido pelo iOS que exibe um spinner). A classe também tem
    uma função chamada startAnimating() que inicia a animação do spinner.

    Quando a classe é inicializada, ela configura a cor de fundo da visualização para o sistema padrão,
    adiciona o spinner como uma subvisualização e define algumas restrições de layout para centralizar o
    spinner na visualização.



*/

