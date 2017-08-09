# Annexe - Base de Données Client

L'**architecture Client Serveur** est caractérisée par une répartition des programmes ou tâches entre processus client et processus serveur. **Client : **le processus qui adresse à un serveur une requête correspondant à une demande de service spécifique. **Serveur :** un processus à l'écoute d'une demande d e service en provenance d'un client. Client et Serveur communiquent sur un réseau.

* * *

## Serveur

  * offre des services classiques d'accès à une BDD (recherche, mise à jour, confidentialité, intégrité, traitement de transactions, reprise après panne)
  * execute des requêtes SQL, procédures stockées pour le compte du client
  * basés sur des SGBD relationnels

* * *

## Middleware

Le middleware est un ou ensemble de logiciel(s) du milieu qui assure les dialogues entre clients et serveurs souvent hétérogènes. Il est construit au dessus d'un protocole de transport afin de permettre l'échange de requête-réponses associées entre client et serveur de manière transparente.

* * *

## Système ouvert

Un système ouvert est un système dont les interfaces obéissent à des standards internationaux établis au sein de structures accessibles à tous. Exemples de standards : ISO, ANSI, CCITT, IEE

* * *

## API

  * bibliothèque permettant de développer des applications client/serveur.
  * programmes clients envoient leurs requêtes par des appels à des fonctions contenues dans l'API.
