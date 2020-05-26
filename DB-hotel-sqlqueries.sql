/******************************

SQL SERIES
Creare, utilizzando phpMyAdmin, un nuovo database hotel.

*******************************/

/* 
    eseguire le seguenti queries: 
*/

/* Seleziona tutti gli ospiti che sono stati identificati con la carta di identità */
SELECT `name`, `lastname`, `document_type` 
FROM `ospiti`
WHERE `document_type` = 'CI';

/* Seleziona tutti gli ospiti che sono nati dopo il 1988 */
SELECT `name`, `lastname`, `date_of_birth` 
FROM `ospiti`
WHERE `date_of_birth` > '1989-01-01';

/* Seleziona tutti gli ospiti che hanno più di 20 anni (al momento dell’esecuzione della query) */
SELECT `name`, `lastname`, `date_of_birth` 
FROM `ospiti`
WHERE `date_of_birth` < '2000-01-01';

/* Seleziona tutti gli ospiti il cui nome inizia con la D */
SELECT `name`, `lastname`
FROM `ospiti`
WHERE `name` LIKE 'd%';

/* Calcola il totale degli ordini accepted */
SELECT COUNT(`id`) AS `pagamenti_accettati`, `status` 
FROM `pagamenti`
WHERE `status` = 'accepted';

/* Qual è il prezzo massimo pagato? */
SELECT `id`, `status`, `price` 
FROM `pagamenti`
WHERE `status` = 'accepted'
ORDER BY `price` DESC
LIMIT 1;

/* Seleziona gli ospiti riconosciuti con patente e nati nel 1975 */
SELECT `name`, `lastname`, `date_of_birth`, `document_type` 
FROM `ospiti`
WHERE `document_type` = 'Driver License'
AND `date_of_birth` BETWEEN '1975-01-01' AND '1975-12-31';

/* Quanti posti letto ha l’hotel in totale? */
SELECT SUM(`beds`) AS `totale_posti_letto` 
FROM `stanze`;


