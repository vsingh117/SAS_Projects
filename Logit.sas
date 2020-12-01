data logit;
set "E:\MS_studyProcess\UNCC-Study\TA-docs\Fall-6201\SAS demo\data\hsb2";
honcomp = (write >= 60);
run;

proc print data=logit(obs=10);run;

proc logistic data=logit descending;
model honcomp = female read science;
run;
