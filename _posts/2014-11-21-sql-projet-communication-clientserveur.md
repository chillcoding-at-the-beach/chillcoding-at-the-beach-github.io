---
title: Communication Client/Serveur
categories: coding android tutoriel fr
author: macha
---

Dans le cadre de l'enseignement **SQLite** effectué en
[LP DAM](http://dam.unice.fr/doku.php) (_Licence Professionnelle Développement
  d'Applications Mobiles_), un projet de communication Client/Serveur est à l'honneur.

Pour assoir la base de ce projet, un _serveur de test_ est mis à disposition de _divers potentiels clients_. Il est expérimental et tend à évoluer au fil du temps. D'un côté, le _**Serveur** de test_ est constitué de fichiers PHP placés sur _machada.fr_ et d'une BDD intitulée _**JustDoSport**_. Pour le moment, son rôle est d'ajouter des utilisateurs dans la BDD et de renvoyer leurs identifiants. D'un autre côté, le **_Client_ **est une application mobile, en particulier une app. Android. Cependant, il est attendu divers clients comme une app. IOS, une app. Windows Phone ou encore une app Web. Le but de cet article est d'informer les équipes de développement **_Clientes_** quant à la vie du **_Serveur_**. Son utilité est de permettre à n'importe qui, de faire des _tests de communication_ _http Post_. **Informations liées au Serveur** * Concept de la BDD Actuellement, elle est composé d'une seule table d'utilisateurs. A termes, l'idée est d'enregistrer des préférences ou diverses et variées informations, liées à un utilisateur (via son identifiant: u_id). **Règles de confidentialité** de _**JustDoSport**_ : Les noms des utilisateurs sont publiques, ceci étant, en aucun cas, leurs préférences ou leurs coordonnées seront divulguées à des fins commerciales. * Création et mise à jour de la BDD:

La table USER

contient 2 champs, en particulier, un nom d'utilisateur (u_name) et un identifiant (u_id).
  1.  Création de la table USER : `CREATE TABLE `user` ( `u_id` int(11) NOT NULL AUTO_INCREMENT, `u_name` varchar(10) NOT NULL, PRIMARY KEY (`u_id`),UNIQUE KEY `u_name` (`u_name`))`
  2. Suppression des entrées de la table USER le 24/11/2014 (TRUNCATE TABLE user;)
* Vue de la BDD : Table USER connect_error) { } $sql = "SELECT u_name FROM user"; $result = $conn->query($sql); if ($result->num_rows > 0) { // output data of each row while($row = $result->fetch_assoc()) { echo "user : " . $row["u_name"]. " ; " ; } } else { echo "0 results"; } $conn->close(); ?> *  API http fichier de la requête http POST : _<http://www.machada.fr/JustDoSportDataMobileToServer.php>_ il attend les 2 paires **(table, user)** et **(user,** _freeName_**)**
