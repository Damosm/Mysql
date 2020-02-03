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

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/dataia_nancy/BASE1.txt'
INTO TABLE dataia_Nancy
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
