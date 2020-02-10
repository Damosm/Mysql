A partir du fichier BASE1.txt mis à disposition, créer la base de données dataia_Nancy et la table dataia_Nancy. Répondez ensuite aux questions suivantes :

1)    Selectionner les 10 premières lignes de la table

select  * from dataia_nancy limit 10;

2)    Combien d’individus avons-nous dans la table

select  count(*) from dataia_nancy ;

3)    Combien d’individus distincts avons-nous dans la table

select  distinct count(*)  from dataia_nancy ;

4)    Recoder la variable resilies sachant que 0 correspond à non resiliés et 1 à résilies

alter table dataia_nancy modify resilies  varchar (20);
#######################################################
update dataia_nancy set resilies = (
case resilies 
when 0 then 'résilié'
else 'non résilié'
end);

5)    Combien de non resiliés avons-nous

select resilies, count(resilies) from dataia_Nancy group by resilies;

6)    Quelle est l’ancienneté moyenne des individus avec en décimal, 0 chiffre

select ROUND(avg(anciennete),0) from dataia_nancy;

7)    Afficher le nombre d’individus en fonction de l’ancienneté et du sinistre ; interprétez

select anciennete, sinistre, count(*) from dataia_nancy group by anciennete, sinistre;

8)    Afficher le nombre d’individus en pourcentage en  fonction de l’ancienneté et du sinistre ; interprétez

select anciennete, sinistre, round(count(*) / (select count(*)from dataia_Nancy)*100) as 'pourcent' from dataia_nancy group by anciennete, sinistre;

9) Parmis les non resilies, combien d individus ont un sinistre superieur à la moyenne generale ?

select count(resilies) from dataia_nancy 
where resilies = 1 and  sinistre >= (select avg(sinistre) from dataia_nancy);

10)creer en une seule requete la table "projetA" contenant les variables : resilies, parcours, anciennete et demenagement.
creer aussi en une seule requete la table "projet b" contenant les variables : resilies, parcours, sinistre, devis, revision et satisfaction.

CREATE TABLE `dataia_nancy`.`projetA`(
SELECT resilies,parcours,anciennete,demenagement
FROM dataia_nancy);

CREATE TABLE `dataia_nancy`.`projetB`(
SELECT resilies,parcours,sinistre, devis,revision,satisfaction
FROM dataia_nancy);

11)créer la table projetC à partir des tables projetA et projetB en utilisant dans un premier temps un « join » et dans un deuxieme temps « with ».

ALTER TABLE `dataia_nancy`.`projeta` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (`id`);



CREATE TABLE `dataia_nancy`.`projetC`(
SELECT *
FROM projeta
natural join projetb);

##################################################################################

CREATE TABLE `dataia_nancy`.`dataia_nancy` (
  `resilies` INT NULL,
  `parcours` INT NULL,
  `anciennete` INT NULL,
  `demenagement` INT NULL,
  `sinistre` INT NULL,
  `devis` INT NULL,
  `desequip` INT NULL,
  `revision` INT NULL,
  `satisfaction` INT NULL);

mysql -u root -p --local-infile



SET @@global.local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/utilisateur/Documents/Git/Mysql/base1.txt'
INTO TABLE dataia_nancy
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
;

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

insert into (resilies,parcours,anciennete,demenagement,sinistre,devis,desequip,revision,satisfaction) values
(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3),(0,4,4,2,2,3,2,4,3);

#######################################

#######################################
select count(resilies) as resilies from dataia_Nancy;
###########################################""

CREATE TABLE `dataia_nancy`.`train` (
 ID INT NULL,
 SHIPPING_MODE VARCHAR(30) NULL,
 SHIPPING_PRICE VARCHAR(30) NULL,
 WARRANTIES_FLG VARCHAR(30) NULL,
 WARRANTIES_PRICE VARCHAR(30) NULL,
 CARD_PAYMENT INT NULL,
 COUPON_PAYMENT INT NULL,
 RSP_PAYMENT INT NULL,
 WALLET_PAYMENT INT NULL,
 PRICECLUB_STATUS VARCHAR(30) NULL,
 REGISTRATION_DATE INT NULL,
 PURCHASE_COUNT VARCHAR(30) NULL,
 BUYER_BIRTHDAY_DATE FLOAT NULL,
 BUYER_DEPARTMENT INT NULL,
 BUYING_DATE VARCHAR(30) NULL,
 SELLER_SCORE_COUNT VARCHAR(30) NULL,
 SELLER_SCORE_AVERAGE FLOAT NULL,
 SELLER_COUNTRY VARCHAR(30) NULL,
 SELLER_DEPARTMENT INT NULL,
 PRODUCT_TYPE VARCHAR(30) NULL,
 PRODUCT_FAMILY VARCHAR(30) NULL,
 ITEM_PRICE VARCHAR(30) NULL);

 LOAD DATA LOCAL INFILE 'C:/Users/utilisateur/Documents/Git/Mysql/input_train.csv'
INTO TABLE train
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
ignore 1 lines
;
###############################################
1)    Quel est le mode de livraison le plus courant ?

select SHIPPING_MODE, count(*) as total
from train
group by SHIPPING_MODE 
order by count(*) desc
limit 1;

2)    Combien de ventes y-a-t-il eu par famille de produit ?

select `PRODUCT_FAMILY`, count(*) as total
from train
group by PRODUCT_FAMILY 
order by count(*) desc
;
nombre d articles vendus par famille de produit :

SELECT PRODUCT_FAMILY,
SUM(CASE
        WHEN PURCHASE_COUNT = '50<100' THEN 75
        WHEN PURCHASE_COUNT = '5<20' THEN 12.5
        WHEN PURCHASE_COUNT = '20<50' THEN 35
        WHEN PURCHASE_COUNT = '100<500' THEN 300
        WHEN PURCHASE_COUNT = '>500' THEN 500
        WHEN PURCHASE_COUNT = '<5' THEN 5
    END) AS OSEF
FROM train
GROUP BY PRODUCT_FAMILY
order by count(*) desc;

3)    Quel est l’âge moyen des vendeurs français ?

select  2020-avg(BUYER_BIRTHDAY_DATE) as 'age moyen' from train where `SELLER_COUNTRY` like '%FRANCE%' and BUYER_BIRTHDAY_DATE>1;

4)    Parmi les achats qui ont eu lieu par carte bancaire, combien ont eu lieu en septembre 2017 ?

select sum(CARD_PAYMENT) as total , BUYING_DATE from train where CARD_PAYMENT=1 and BUYING_DATE like'9/2017';

5)    Quel est le nombre moyen d’achat effectué par mode de livraison ?

select SHIPPING_MODE, count(*)/10000 as moyenne
from train
group by SHIPPING_MODE 
order by count(*) desc
;