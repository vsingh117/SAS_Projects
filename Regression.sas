proc import datafile="E:\MS_studyProcess\UNCC-Study\TA-docs\Fall-6201\Airfoil.xlsx"
DBMS=xlsx out=airfoil replace;

proc print data=airfoil(obs=10);run;


proc surveyselect data=airfoil
samprate=0.8
out=sample
outall method=srs;
run;

proc print data=sample;run;

data train;
set sample;
if(selected=1) then output;
run;


proc print data=train;run;

data test;
set sample;
if(selected=0) then output;
run;


proc print data=test;run;


proc univariate data=train normal plot;
var Frequency Angle Chord_length Velocity thickness Sound_level;
run;

proc reg data=train;
model Sound_level = Frequency Angle Chord_length Velocity thickness /tol vif colin;
plot r.*p;
run;


data mod_test; set test; 
y_bar = 132.35191 + (-0.00129 * Frequency) + (-0.39951*Angle) + (-34.71085*Chord_length) + (0.10210 * Velocity) + (-138.56415 * thickness);
Predicted_err = ((Sound_level -y_bar)**2); run;

proc print data=mod_test;run;


proc means data=mod_test Mean;
var Predicted_err;run;




