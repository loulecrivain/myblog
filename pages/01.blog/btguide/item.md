---
title: Guide BitTorrent (fr)
date: 04/14/2018
---

repost à partir de l'ancien blog.

! _nota bene_: cet article est **vieux**


# principe général
Le principe général de BitTorrent va à l'encontre du principe du téléchargement direct. Son but est de créer un cercle vertueux en faisant en sorte que chaque client ayant téléchargé un petit bout du fichier (dans le jargon BitTorrent, cela s'appelle une "pièce") puisse le refiler aux autres clients qui téléchargent le même fichier (on parle "d'essaim"). Ainsi, la machine possédant le fichier originel ne sera pas surchargée, car l'offre (clients partageant des pièces) augmente en même temps que la demande.
  
Voir le petit paragraphe en anglais sur [bittorrent.org](http://www.bittorrent.org/introduction.html) pour une description plus complète et synthétique.

# en pratique
Depuis le client originel et les premières spécifications, BitTorrent a beaucoup évolué. De nombreuses extensions au protocole ont été développées, et l'efficacité générale s'en est trouvée améliorée (au détriment de la simplicité protocolaire toutefois ```;p```). Nous allons détailler dans cette section comment, dans la vraie vie, utiliser BitTorrent. Il est toutefois conseillé de lire la section "Plus en détail" avant de commencer, ne serait-ce que pour comprendre le vocabulaire spécifique.

## les bons liens à tatie géraldine
### clients
Il existe une pléthore de clients implémentant le protocole BitTorrent et un certain nombre de ses extensions. Voici ceux que je connais et que j'ai pu tester à ce jour.
1. [Deluge](http://deluge-torrent.org/), client cross-platform en python utilisant libtorrent.
2. [Transmission](https://transmissionbt.com/), qui fonctionne sur de nombreux UNIX, des systèmes NAS et qui dispose désormais d'un version pour Windows (encore en alpha au moment où j'écris ces lignes).

### recherche
Chercher des lien magnet ou des fichiers torrent sur le Web est un exercice plutôt acrobatique, c'est pourquoi je vous conseille d'utiliser un méta-moteur de recherche (ce sera toujours plus efficace que gogleuh qui va vous présenter plein de pubs et autres sites douteux en premier). Le principe d'un méta-moteur de recherche est d'agir comme un intermédiaire entre vous et les autes moteurs de recherche.


Celui que j'utilise est searx (qui est d'ailleurs un bon méta-moteur, à condition de le paramétrer correctement), car il dispose d'extensions pour utiliser des moteurs de recherche spécialisés dans la recherche de fichiers (ainsi que plein d'autres choses). Sur [l'instance de LQDN](https://searx.laquadrature.net/), cette extension existe mais n'est toutefois pas activée par défaut. Pour l'activer, il faut aller dans preferences, puis engines, puis files, et activer digbt.

Des sites spécialisés peuvent également être utilisés, mais il convient d'être vigilant (voir section suivante).

## mamaaan, y'a des trucs morts dans la mer !
Comme toujours, des petits malins essaient de profiter de ce que vous faites pour vous refiler des merdes qui vont tourner sur votre matériel. Ceci a toujours été valable pour n'importe quoi (les jeux avec des DRM pas-du-tout-intrusifs dedans, les logiciels préinstallés sur Windoze, les barres de recherche trop géniales pour IE, softonic, etc). Le problème, - et c'est malheureusement une constante - c'est que dans le cas du partage de fichier, le nombre de virus et autres embêtements est assez élevé. Distribuer des clients, torrents contaminés ou faire des sites remplis de code malicieux est une activité rentable comme tant d'autres ```:)```.

Nous allons donc détailler ici une série de mesures qui permettent de limiter les dégâts. N'allez pas toutefois penser que BitTorrent-est-dangereux-ohlala: le protocole en soi est fiable. Ce qui est foireux, c'est le reste. Et c'est facile d'éviter quelque chose de discret comme un mammouth (bon d'accord, parfois le mammouth est bien caché, mais quand c'est un gros ```.EXE```, humhum).

### passoire browser
JavaScript, c'est cool, on peut tout faire, on en tartine partout, youpie. Sauf que sur le principe, ça reste du contenu exécutable de provenance inconnue et non sûre, que votre navigateur Web exécute à la volée (en plus). Certes, il y a des sandbox. Mais elles sont faillibles, comme tout programme, et l'isolation n'est d'ailleurs pas totale en particulier _entre les sites_ (coucou [XSS](https://fr.wikipedia.org/wiki/XSS)). JavaScript est donc très utilisé pour contaminer des navigateurs et des systèmes, ou récupérer des informations sensibles (Et pas que sur les sites "bizarres": des publicités sur des sites qui semblent parfaitement légitimes peuvent contenir une payload. Les pubs frauduleuses sont d'ailleurs un bon vecteur de contamination).

Une des solutions est donc de bloquer l'exécution de JavaScript. Il existe pour cela une extension pour Firefox qui est [NoScript](https://noscript.net/), développé par une société d'informatique italienne ([InformAction](http://www.informaction.com/)). Vous pouvez l'installer depuis le gestionnaire d'extensions de Firefox.

! Je n'ai pas de solutions pour les autres navigateurs qui supportent JavaScript.

!! Si vous avec installé des extensions comme FlashPlayer (énooorme gruyère) ou les extensions pour les applets Java, je vous conseille de les désactiver par défaut. Celles-ci augmentent la surface d'attaque du navigateur (qui est déjà bien large).


### un gremlin dans ton colis

Avant de lancer un téléchargement, son contenu tu vérifieras (de nombreuses fonctions permettent d'avoir un preview de l'arborescence du torrent). Si:
- le fichier est un auto-extractible ([SFX](https://en.wikipedia.org/wiki/Self-extracting_archive))
- est compressé ([zip bomb](https://en.wikipedia.org/wiki/Zip_bomb))
- est un exécutable (PE32, ELF, whatever)
- utilise des formats pas safe (style un PDF avec du javascript dedans)

Alors il y a des chances pour que ces fichiers soient craftés pour exécuter autre chose derrière, péter votre système ou déployer des malwares. Ceci est particulièrement vrai pour les cracks.

### botnet-client 2.0
Certains clients sont connus pour contenir des malwares, adwares ou bots. Premièrement, comme avec n'importe quel logiciel, toujours le télécharger sur son site officiel, vérifier les hashs (si le distributeur n'en indique pas, méfiance) et regarder auparavant son historique de sécurité. µTorrent, par exemple, [embarque un mineur de bitcoins et affiche des publicités](https://www.reddit.com/r/technology/comments/2y4lar/popular_torrenting_software_%25C2%25B5torrent_has_included/).

### Xtreme Torrent Searxxx ! No shit I swear
The Pirate Bay est très connu (on ne compte plus le nombre de reborns du site). Pourtant, il y a peu, le magazine _Le Virus Informatique_ a signalé que les pages contenaient des scripts mineurs de cryptomonnaie Monero. Ceci a aussi été dit sur [ce post reddit](https://www.reddit.com/r/SexyCrypto/comments/70kj5v/the_pirate_bay_runs_a_javascript_monero_miner/).

!!! En général, vérifiez la réputation des sites sur lesquels vous vous rendez. Reddit dispose d'un [très bon fil généraliste](https://www.reddit.com/r/torrents/) sur BitTorrent, avec une communeauté active et des réponses pertinentes.

### copyright troll
[Piracy, it's a crime](https://www.youtube.com/watch?v%3DHmZm8vNHBSU). Mais le streaming c'est OK en France, parce que nique la logique.

# Plus en détail
## les hashs et pièces
Dans BitTorrent, ce que l'on partage est découpé en "pièces". Il s'agit de petits bouts du fichier (ou des fichiers) dont la taille est le plus souvent un multiple de deux. La taille de pièce la plus commune est de 1 méga-octet.

Pour chaque pièce, un hash est calculé en utilisant l'algorithme [SHA1](https://fr.wikipedia.org/wiki/SHA1). Pour faire bref, les algorithmes de hash permettent de générer un condensat (petite information) qui identifie de façon unique un contenu. Ce contenu peut être beaucoup plus gros que le condensat. Un changement sur le contenu, aussi-subtil soit-il, modifie complètement le condensat. Un petit exemple:
```sh
$ echo -n coucou | sha1sum -
5ed25af7b1ed23fb00122e13d7f74c4d8262acd8  -
$
```


```sh
$ echo -n Coucou | sha1sum -
b70f7d0e2acef2e0fa1c6f117e3c11e0d7082232  -
$
```

Ceci permet donc d'être sûr que l'on a bien téléchargé correctement chaque pièce.

## le fichier metainfo (ou ```.torrent```)
Les fichiers metainfo sont des fichiers assez petits utilisant le b-encodage comme structure de format (cf [BEP3](http://www.bittorrent.org/beps/bep_0003.html#bencoding)). Leur rôle est de décrire un partage pour un contenu précis. Ils contiennent donc de l'information sur comment le client doit initier le partage, qui doit-il contacter; ainsi que des informations sur le contenu du partage. Ils possèdent plusieurs champs. Nous n'allons en revanche pas détailler ici leur structure.
- ```announce```: Il s'agit de l'url du tracker. Celle-ci peut être de la forme ```udp://tracker.example.com:6881``` ou ```http://tracker.example.com:6881```.
- ```piece length```: nombre d'octets que fait chaque pièce. Toutes les pièces font la même taille, sauf la dernière, qui peut être plus petite que les autres (il n'y a pas de "bourrage" utilisé).
- ```pieces```: tous les hashs pour chaque pièce, les uns à la suite des autres. Les références aux pièces se font conformément à ce champ.
  
Le fichier metainfo possède également d'autres champs (```length``` et ```files```). Ces derniers décrivent la structure de répertoire dans lesquels seront mis les fichiers (car oui, BitTorrent est capable de partager des dossiers. Plutôt pratique, non ?), ou bien le fichier lorsqu'il n'y en a qu'un seul.

De nos jours, les fichiers metainfo tendent à être de plus en plus remplacés par des liens de type "magnet". Il s'agit d'un schéma d'URI spécial décrivant un partage de la même façon qu'un fichier metainfo le ferait. Un lien magnet ressemble à peu près à ceci:

```
magnet:?xt=urn:btih:HASH&dn=NAME&tr=TRACKER&so=0,2,4,6-8
```

Les liens magnets ne contiennent pas toutes les métadonnées (à minima, ils contiennent l'infohash). Le client doit donc se "débrouiller" pour télécharger ces dernières. Pour plus d'explications, voir le [BEP53](http://www.bittorrent.org/beps/bep_0053.html). Bien sûr, seuls les clients BitTorrent sont capables de reconnaître l'URI ```magnet:```, mais vous pouvez paramétrer le gestionnaire de schémas d'URI de votre système ou celui de votre navigateur pour associer les liens ```magnet``` à votre client.

## le tracker

Le rôle du tracker est d'annoncer aux clients souhaitant télécharger le contenu décrit par un metainfo quels sont les autres clients qui participent à l'essaim (i.e, qui sont en train de télécharger le contenu ou qui ont fini de le télécharger). Comme dit plus haut, le fichier metainfo contient l'url d'un tracker, que le client contacte donc, en donnant ses informations au tracker (bin oui, sinon ça ne pourrait pas fonctionner ```:p```). Ces informations sont: le hash du champ ```info``` du fichier metainfo, l'ID du client, son ip, le port sur lequel il écoute, ce qu'il a partagé du contenu jusqu'ici (en taille), ce qu'il a téléchargé du contenu (en taille), ce qui lui reste à télécharger (l'existence de ce champ est liée à la possibilité de résumer un torrent). Le tracker va renvoyer une liste de pairs en guise de réponse, avec:

1. l'ID du pair. Le fonctionnement des IDs sera expliqué plus loin.
2. l'IP du pair.
3. le port sur lequel on peut joindre le pair.

## le client/serveur
Le rôle du client BitTorrent est de télécharger les contenus décrits dans les fichiers metainfo, pièce par pièce (et pas forcément dans un ordre séquentiel, il peut télécharger chaque pièce aléatoirement par exemple, ou télécharger les pièces les plus rares en premier). Il est à noter que chaque client BitTorrent s'identifie auprès des autres par un ID aléatoire généré pour chaque partage.

Pour obtenir le contenu décrit dans le fichier ```.torrent```, il va d'abord contacter le tracker, afin de rentrer dans la liste de pairs et d'obtenir cette liste. Il va ensuite commencer à télécharger les pièces en les demandant aux divers pairs listés par le tracker (pour cela, il doit se connecter aux pairs: cela peut faire beaucoup de connexions simultanées !). Le client fait référence aux pièces par leur numéro d'index (car leurs hashs ne sont pas forcément uniques, pensez à quelqu'un qui télécharge un fichier plein de zéros). Une fois qu'une pièce a été téléchargée et vérifiée par son hash, le client annonce à l'essaim qu'il peut l'envoyer à d'autres clients qui ne l'ont pas encore. Cela signifie que même en ayant partiellement le fichier, il est possible de commencer à le partager à l'essaim.

Un contenu est considéré comme téléchargé lorsque le client a toutes les pièces et qu'elles ont été vérifiées. Le client joue également le rôle de serveur (il a un port d'écoute, comme toutes les applications serveur), et chacun peut lui envoyer des requêtes. Les torrents sont identifiés par le hash de leur champ ```info```. Ce hash est supposé unique et propre au torrent, de par la combinaison des informations du champ ```info```. Dans l'idéal, le client devrait envoyer autant de contenu qu'il n'en télécharge. Cela est toutefois plutôt fastidieux à accomplir lorsque l'on ne dispose que d'une connexion ADSL, dites merci aux telcos !

Le protocole BitTorrent utilise deux protocoles réseau pour la "charge utile": ```TCP```, et ```µTP``` (ce dernier a été initialement développé pour le client µTorrent), qui est un protocole basé sur ```UDP``` et qui implémente un contrôle de congestion basé sur le temps, et se comporte comme ```TCP```. Les clients utilisent également un protocole de "choking" qui fait office de contrôle de congestion, car les contrôles implémentés dans ```TCP``` sont peu efficaces pour des connexions multiples et simultanées. Pour plus de détails, voir le [BEP3](http://www.bittorrent.org/beps/bep_0003.html#bencoding#peer-protocol).

## la table de hashs distribuée (```DHT```)
Les trackers, c'est cool mais ça fait quand même un gros point individuel de défaillance. Si jamais le tracker tombe, plus rien ne fonctionne. C'est moins cool. BitTorrent a beau être essentiellement pair-à-pair, le tracker est un des points centralisés de son architecture, et il est en fait assez contraignant (charge, bande passante, disponibilité...). Pour se passer de ces limitations, on utilise désormais le protocole ```DHT```. Ceci permet à chaque pair de remplir les mêmes fonctions qu'un tracker, mais d'une façon différente, ceci étant dû à la nature distribuée du protocole. Le clients modernes implémentent donc tous des nœuds ```DHT```. ```DHT``` est décrit dans le [BEP05](http://www.bittorrent.org/beps/bep_0005.html), et a été originellement dérivé de Kademlia.

Chaque nœud ```DHT``` possède un ID, puisé dans le même /range/ d'IDs que pour les pairs (2^{0} à 2^{160}). Cet ID est également aléatoire. La "distance logique" entre des IDs est calculée par un ou exclusif (ID_A xor ID_B). La distance entre un infohash et un nœud est calculée de la même façon. Ceci ne représente pas une distance physique, seulement une distance logique (rien à voir avec le réseau). Chaque nœud ```DHT``` maintient une petite table d'IDs classés par "distance", avec les informations de contact. Le nœud a une préférence pour les IDs logiquement proches. Ce mécanisme permet la distribution des informations et des rôles, et la construction autonome d'un système distribué pour les informations. Avec un simple ou exclusif. Oui oui.

La table ```DHT``` est organisée pour préférer un maximum les "bons" nœuds, i.e. ceux qui nous répondent et nous envoient des requêtes toutes les 15 minutes au moins. Elle est également divisée en "buckets", qui peuvent au maximum contenir 8 bons nœuds. Ces "buckets" couvrent chacun un fragment de l'espace d'adressage des IDs (entre 2^{0} et 2^{160}). Il n'y a au départ qu'un seul bucket, mais au fur et à mesure que la table ```DHT``` se remplit, elle est de plus en plus subdivisée en d'autres buckets. Les IDs vont dans le bucket qui peut contenir leur adresse (bucket_minaddr <= ID < bucket_maxaddr).

Le fonctionnement de la découverte de autres nœuds ```DHT``` et des pairs est le suivant: lorsqu'un nœud veut trouver les pairs pour un torrent, il regarde dans sa table ```DHT``` et choisit les nœuds ayant la distance logique la plus proche parraport à l'infohash. Ces nœuds sont ensuite contactés afin de leur demander si ils ne connaîtraient pas des pairs pour le torrent demandé. Dans l'affirmative, le nœud retourne ses informations de contact avec la liste des pairs. Dans la négative, le nœud contacté répond avec l'information de contact des nœuds les plus "proches logiquement" parraport à l'infohash. Le nœud ```DHT``` continue alors à interroger d'autres nœuds à partir des informations qu'il obtient, jusqu'à ce qu'il n'en trouve plus d'autres. La recherche étant finie, les informations de contact associées aux IDs ```DHT``` sont insérées dans la table ```DHT```.

Toutefois, ```DHT``` n'est pas magique non plus: les clients tout juste installés qui n'ont aucun nœud dans leur table et qui essaient de télécharger un torrent sans trackers doivent contacter les nœuds ```DHT``` indiqués dans le fichier metainfo.

## l'échange de pairs (PEX)
PEX (Peer Exchange) est un mécanisme alternatif aux trackers et à ```DHT``` pour les essaims, qui permet, une fois des pairs "démarrés", de découvrir d'autres pairs en en échangeant avec les autres clients. Il est décrit dans le [BEP11](http://www.bittorrent.org/beps/bep_0011.html).

Son rôle est de donner au client une vue plus complète et à jour que ce qu'il pourrait obtenir par d'autres sources, c'est en quelque sorte une couche d'amélioration au-dessus des trackers et de ```DHT```.

Les messages PEX sont une extension pour le protocole d'handshake BitTorrent. Lorsqu'un client communique avec un autre client téléchargeant le même torrent, il lui annonce les pairs qu'il connaît et auquel il est actuellement connecté pour l'essaim du torrent, ce lors du handshake.

# Ressources
## bittorrent.org
   Vous voulez vous manger un mur de texte en anglais ? Lisez la [spécification actuelle du protocole BitTorrent](http://www.bittorrent.org/beps/bep_0003.html) que j'ai dû me taper en entier (plus plein d'autres specs, mais ça valait le coup, j'ai compris des choses pendant que j'expliquais ```:p```)

