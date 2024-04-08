-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: Meriem Taha                        Votre DA: 2242698
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
SELECT COLUMN_NAME, DATA_TYPE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'OUTILS_EMPRUNT'

SELECT COLUMN_NAME, DATA_TYPE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'OUTILS_USAGER';

SELECT COLUMN_NAME, DATA_TYPE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'OUTILS_OUTIL';

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(prenom, ' ', nom_famille) as Nom_Complet
FROM OUTILS_USAGER;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
select DISTINCT ville
FROM OUTILS_USAGER
order by ville;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM OUTILS_OUTIL
order by nom, code_outil;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT num_emprunt AS numero_demprunt
from OUTILS_EMPRUNT
WHERE date_retour IS NULL;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT *
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < TO_DATE ('2014-01-01')
-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT nom,code_outil
FROM OUTILS_OUTIL
WHERE fabricant = 'Stanley';
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT nom, fabricant
FROM OUTILS_OUTIL
WHERE annee BETWEEN 2006 AND 2008;
-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT CODE_OUTIL, nom
FROM OUTILS_OUTIL
WHERE caracteristiques != '20 volt' AND NOT 'NULL';

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) 
FROM OUTILS_OUTIL
WHERE FABRICANT != 'Makita';
-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(U.prenom, ' ', U.nom_famille) AS Nom_Complet,
  E.num_emprunt,
  E.code_outil,
  E.Date_emprunt,
  E.date_retour 
FROM OUTILS_USAGE U
JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER
WHERE U.VILLE IN ('vancouver', 'regina');

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT O.nom, O.code_outil
FROM OUTILS_EMPRUNT E ON O.code_outil = E.code_outil
WHERE E.date_retour IS NULL;
-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT NOM_FAMILLE, COURRIEL 
FROM OUTILS_USAGERWHERE NUM_USAGER NOT IN (SELECT NUM_USAGER FROM OUTILS_EMPRUNT);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT O.CODE_OUTIL, O.NOM, O.PRIX
FROM OUTILS_OUTIL O
LEFT OUTER JOIN OUTILS_EMPRUNT E ON O.CODE_OUTIL = E.CODE_OUTIL
WHERE E.NUM_EMPRUNT IS NULL
-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT NOM, PRIX
FROM OUTILS_OUTIL
WHERE FABRICANT = 'Makita' AND PRIX > (SELECT AVG(PRIX) FROM OUTILS_OUTIL);

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT
     U.NOM_FAMILLE,
     U.PRENOM,
     U.ADRESSE,
     E.CODE_OUTIL,
     O.NOM
FROM
     OUTILS_USAGER U
INNER JOIN
    OUTILS EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER
INNER JOIN
    OUTILS_OUTIL O ON E.CODE_OUTIL = O.CODE_OUTIL
WHERE
    E.DATE_EMPRUNT > '2014-01-01'
ORDER BY
    U.NOM_FAMILLE;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT 
    O.NOM,
    O.PRIX
FROM 
    OUTILS_OUTIL O
JOIN 
    OUTILS_EMPRUNT E ON O.CODE_OUTIL = E.CODE_OUTIL
GROUP BY 
    O.CODE_OUTIL, O.NOM, O.PRIX
HAVING 
    COUNT(*) > 1;
-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6
SELECT U.NOM_FAMILLE, U.ADRESSE, U.VILLE
FROM OUTILS_USAGER U
INNER JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER;
--  Une jointure

SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER 
WHERE NUM_USAGER IN (SELECT NUM_USAGER FROM OUTILS_EMRPUNT);
--  IN
SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER U
WHERE EXITS (SELECT 1 FROM OUTILS_EMPRUNT E WHERE E.NUM_USAGER = U.NUM_USAGER);

--  EXISTS

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT  AS MARQUE, AVG(PRIX) AS PRIX_MOYEN
FROM OUTILS_OUTIL
GROUP BY FABRICANT;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT U.VILLE, SUM(O.PRIX) AS SOMME_DU_PRIX
FROM OUTILS_USAGER U 
JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER
JOIN OUTILS_OUTIL O ON E.CODE_OUTIL = O.CODE_OUTIL
GROUP BY U.VILLE
ORDER BY SOMME_DU_PRIX DESC;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('01', 'outil','fabricant', 'caracteristiques', 2024, 99.99);
-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('02', 'deuxieme_outil', 'deuxieme_fabricant','caracteristique', 2024, 99,99);
-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM OUTILS_OUTIL
WHERE CODE_OUTIL IN ('01', '02');
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);