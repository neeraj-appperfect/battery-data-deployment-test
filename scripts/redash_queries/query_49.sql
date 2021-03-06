/*
Name: Capacity Decay
Data source: 1
Created By: admin
Last Update At: 2021-07-02T17:18:35.149Z
*/

SELECT
   key || ': ' || r.cell_id as series,
   r.cycle_index,
   r.test_time,
   value
FROM (SELECT cell_id, trunc(cycle_index,0) as cycle_index, test_time, json_build_object('ah_d', TRUNC(ah_d,3)) AS line 
FROM cycle_stats
where cell_id IN ({{cell_id}}) and ah_eff<1.1) as r
JOIN LATERAL json_each_text(r.line) ON (key ~ '[ah]_[d]')
where cast(value as numeric)!=0
GROUP by r.cell_id, r.cycle_index,  r.test_time, json_each_text.key, json_each_text.value
order by r.cell_id,r.cycle_index, key   