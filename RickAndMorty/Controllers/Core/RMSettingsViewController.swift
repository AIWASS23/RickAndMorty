//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit

final class RMSettingsViewController: UIViewController {

    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }

    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap({
                        return RMSettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    })
                )
            )
        )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)

        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        self.settingsSwiftUIController = settingsSwiftUIController
    }

    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }

        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}

/*
    RMSettingsViewController que herda de UIViewController. A classe RMSettingsViewController exibe uma 
    tela de configurações com uma lista de opções de configuração que o usuário pode selecionar.

    A classe tem uma propriedade privada chamada settingsSwiftUIController que é um UIHostingController 
    que exibe uma instância de RMSettingsView que é construída a partir de um RMSettingsViewViewModel. 
    O RMSettingsViewViewModel contém uma lista de RMSettingsCellViewModel que são usadas para exibir cada 
    opção de configuração na tela.

    O método viewDidLoad é chamado quando a view do controlador é carregada pela primeira vez. Esse método 
    configura a cor de fundo da view, define o título da view como "Settings" e chama o método 
    addSwiftUIController.

    O método addSwiftUIController adiciona o UIHostingController à view do controlador e o configura para 
    ocupar toda a tela. Ele também atribui o controlador atual como o pai do UIHostingController.

    O método handleTap(option:) é chamado quando uma opção de configuração é selecionada pelo usuário. 
    Se a opção de configuração tiver uma URL alvo, ele cria uma nova instância de SFSafariViewController 
    com essa URL e a apresenta. Se a opção de configuração for "Avaliar o aplicativo", ele solicita uma 
    avaliação do aplicativo na App Store usando o SKStoreReviewController.
*/
