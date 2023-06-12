//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

/*
 Este script define uma classe de visualização de guia personalizada chamada RMTabViewController
 que é um subtipo de UITabBarController, um componente de interface do usuário padrão da plataforma iOS.
 A classe sobrescreve o método viewDidLoad da superclasse e chama o método setUpTabs para configurar as guias.

 O método setUpTabs cria quatro visualizações de controlador, uma para cada guia da barra de guias:
 RMCharacterViewController, RMLocationViewController, RMEpisodeViewController e RMSettingsViewController.
 Ele também cria quatro controladores de navegação, um para cada visualização de controlador, e configura
 os itens de guia de cada controlador de navegação com títulos, imagens e tags. Finalmente, ele define
 os controladores de visualização como os controladores de visualização da barra de guias e ativa a
 exibição animada das guias.
*/

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()

        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: charactersVC)
        let nav2 = UINavigationController(rootViewController: locationsVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)

        nav1.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        nav2.tabBarItem = UITabBarItem(
            title: "Locations",
            image: UIImage(systemName: "globe"),
            tag: 2
        )
        nav3.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "tv"),
            tag: 3
        )
        nav4.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 4
        )

        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true
        )
    }
}

