/******************************

SQL SERIES 2
Creare, utilizzando phpMyAdmin, un nuovo database hotel.

*******************************/

/* 
    Sempre utilizzando phpMyAdmin, come fatto per l’esercizio di ieri eseguire le seguenti queries: 
*/


/* Come si chiamano gli ospiti che hanno fatto più di due prenotazioni? */
SELECT COUNT(`prenotazioni_has_ospiti`.`ospite_id`) AS `tot_bookings`, `prenotazioni_has_ospiti`.`ospite_id`, `ospiti`.`name`, `ospiti`.`lastname`
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`
GROUP BY `prenotazioni_has_ospiti`.`ospite_id`
HAVING COUNT(`ospite_id`) > 2;

/* Stampare tutti gli ospiti per ogni prenotazione */
SELECT `prenotazioni_has_ospiti`.`id`, `prenotazioni_has_ospiti`.`prenotazione_id`, `prenotazioni_has_ospiti`.`ospite_id`, `ospiti`.`name`, `ospiti`.`lastname` 
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`;

/* Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018 */
SELECT `pagamenti`.`id` AS `id_pagamenti`, `paganti`.`id` AS `id_paganti`, `pagamenti`.`price`,`paganti`.`name`, `paganti`.`lastname` 
FROM `pagamenti`
INNER JOIN `paganti`
ON `pagamenti`.`pagante_id` = `paganti`.`id`
WHERE `pagamenti`.`created_at` BETWEEN '2018-05-01' AND '2018-05-31';

/* Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano */
SELECT SUM(`pagamenti`.`price`) AS `Tot_pagamenti`,`stanze`.`floor`
FROM `prenotazioni`
INNER JOIN `stanze`
ON `stanze`.`id` = `prenotazioni`.`stanza_id` AND  `stanze`.`floor` = 1
INNER JOIN `pagamenti`
ON `pagamenti`.`prenotazione_id` = `prenotazioni`.`id`;

/* Le stanze sono state tutte prenotate almeno una volta? 
(Visualizzare le stanze non ancora prenotate) */
SELECT `stanze`.`id`, `stanze`.`room_number`
FROM `stanze`
LEFT JOIN `prenotazioni`
ON `stanza_id` = `stanze`.`id`  
WHERE `prenotazioni`.`id` IS NULL;

/* 
    BONUS | GROUP BY
*/

/* Conta gli ospiti raggruppandoli per anno di nascita */
SELECT COUNT(`ospiti`.`id`) AS `id_ospite`, YEAR(`ospiti`.`date_of_birth`)  AS `date_of_birth`
FROM `ospiti`
GROUP BY YEAR(`ospiti`.`date_of_birth`) ASC

/* Somma i prezzi dei pagamenti raggruppandoli per status */
SELECT SUM(`pagamenti`.`price`) AS `Tot_pagamenti`, `pagamenti`.`status`
FROM `pagamenti`  
GROUP BY `pagamenti`.`status` ASC

/* Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni? */
SELECT COUNT(`prenotazioni_has_ospiti`.`ospite_id`) AS `tot_prenotazioni`, `prenotazioni_has_ospiti`.`ospite_id`
FROM `prenotazioni_has_ospiti`  
GROUP BY `prenotazioni_has_ospiti`.`ospite_id` ASC
ORDER BY COUNT(`prenotazioni_has_ospiti`.`ospite_id`) DESC
LIMIT 1