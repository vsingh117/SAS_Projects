proc import datafile='E:\MS_studyProcess\UNCC-Study\TA-docs\Fall-6201\SAS demo\data\wholesale_customers.xls' 
DBMS=xls out = wscust replace; 

proc print data=wscust;run;

proc univariate data=wscust normal plot;
var milk detergents_paper frozen;
run;


data mod_wscust; set wscust;
if milk > 15000 then delete;
if detergents_paper > 10000 then delete; 
if frozen > 8000 then delete; 
run;


proc fastclus data=mod_wscust maxclusters=5 out=clust  MAXITER=20;
var frozen milk detergents_paper  ;
run;

proc freq data=Clust;
   tables region*Cluster;
run;
