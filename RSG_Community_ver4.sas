ods listing;
ods html close;
ods graphics off;


TITLE1 'RSG Project';
OPTIONS linesize = 120;
LIBNAME rsg  'C:\Users\cqpsa\Dropbox (ASU)\RSG Data\RSG\RSG Data';

RUN;

proc import out= Questionnaire_RSG
 datafile = 'C:\Users\cqpsa\Dropbox (ASU)\RSG Data\RSG\qq1_c.sav'
 DBMS=SAV REPLACE;
 RUN;

 proc datasets lib=work nolist nodetails;
 contents data=Questionnaire_RSG;
 run;

 proc sort data = Questionnaire_RSG;
 by id;
 run;

 data Questionnaire_RSG;

 	set Questionnaire_RSG;
	format _all_;
run;

proc import out= Diary_RSG
 datafile = 'C:\Users\cqpsa\Dropbox (ASU)\RSG Data\RSG\Diary_Computed_vF_2013_0217_1_IVRDayEd - Copy.sav'
 DBMS=SAV REPLACE;
 RUN;

 proc datasets lib=work nolist nodetails;
 contents data=Diary_RSG;
 run;

 proc sort data = Diary_RSG;
 by id;
 run;

 data Diary_RSG;

 	set Diary_RSG;
	format _all_;
run;

proc import out= GIS_Data
 datafile = 'C:\Users\cqpsa\Dropbox (ASU)\RSG Data\RSG\GIS all_merge_data_09042012 NO ADDR.xlsx'
 DBMS=xlsx REPLACE;
 RUN;

 proc datasets lib=work nolist nodetails;
 contents data=GIS_Data;
 run;

 proc sort data = GIS_Data;
 by id;
 run;

 data GIS_Data;

 	set GIS_Data;
	format _all_;
run;


data Questionnaire_qq1_tot;
merge Diary_RSG GIS_Data Questionnaire_RSG ;

by id;
run;

PROC FREQ DATA = Questionnaire_qq1_tot;
	TABLES id;
RUN;





proc freq data = rsg;
tables id;
run;






*MEans and sd of neighborhod variables*;

data qq1_tot; set Questionnaire_RSG;

neighyears = mean(neig_yrs);
ownandrent = mean(ownrent);
address = mean(add_yrs);
education = mean (edu);
run;

proc means data = qq1_tot;

var neighyears ownandrent address edu;
run;
*  The SAS System          14:16 Thursday, July 9, 2020  32

                                       The MEANS Procedure

 Variable    Label                                   N          Mean       Std Dev       Minimum
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
 neighyears                                        727    10.8762036     9.5576299             0
 ownandrent                                        777     0.7580438     0.4285438             0
 address                                           720     9.5236111     8.6670446             0
 edu         highest level of education completed  775     6.4206452     1.7823676     1.0000000
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

                 Variable    Label                                      Maximum
                 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                 neighyears                                          57.0000000
                 ownandrent                                           1.0000000
                 address                                             57.0000000
                 edu         highest level of education completed     9.0000000
                 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ



;

data qq1_tot2; set qq1_tot;

if ownrent EQ 0 then rent = 1;
if ownrent EQ 1 then rent = 0;
run;

proc freq data = qq1_tot2;

tables rent;

run;
* The SAS System          14:16 Thursday, July 9, 2020  34

                                       The FREQ Procedure

                                                     Cumulative    Cumulative
                    rent    Frequency     Percent     Frequency      Percent
                    ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                       0         589       75.80           589        75.80
                       1         188       24.20           777       100.00

                                      Frequency Missing = 5


;


data qq1_tot1; set qq1_tot;
if edu EQ 1 then eduyr = 3;
if edu EQ 2 then eduyr = 6;
if edu EQ 3 then eduyr = 8;
if edu EQ 4 then eduyr = 12;
if edu EQ 5 then eduyr = 11;
if edu EQ 6 then eduyr = 14;
if edu EQ 7 then eduyr = 16;
if edu EQ 8 then eduyr = 17;
if edu EQ 9 then eduyr = 18;
run;

proc means data = qq1_tot1;
var eduyr;
run;
*   The SAS System          14:16 Thursday, July 9, 2020  33

                                       The MEANS Procedure

                                    Analysis Variable : eduyr

                 N            Mean         Std Dev         Minimum         Maximum
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
               775      14.5225806       2.9075672       3.0000000      18.0000000
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ


;

**neighborhood disorder**;

data qq1_tot; set Questionnaire_qq1_tot;

percvdneighdistot = mean(pnd);
run;

**Evaluating descriptives of subjective indicators of neighborhood;


**collective efficacy;
data qq1_tot; set qq1_tot;

collecteff = mean(ces);
run;
**community involvement & trust;


data qq1_tot; set qq1_tot;

comminvolvementtrust = mean(trust1, trust2, trust3, trust4, trust5, trust6);
run;

**Adaptive coping urban crime;

data qq1_tot; set qq1_tot;

adaptcoping  = mean(ac);
run;

**measure of social ties**;
data qq1_tot; set qq1_tot;
social = mean(mst);
run;


**measure of sense of community**;
data qq1_tot; set qq1_tot;
sensecomm = mean(sci);
run;


proc means data = qq1_tot;

var   percvdneighdistot collecteff comminvolvementtrust adaptcoping social sensecomm ;

run;

** The MEANS Procedure





                                                   The MEANS Procedure

              Variable                   N            Mean         Std Dev         Minimum         Maximum
              ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
              percvdneighdistot       7153       1.7201918       0.5955666       1.0000000       4.0000000
              collecteff              7107       3.7042423       0.7953327       1.0000000       5.0000000
              comminvolvementtrust    7184       2.6737681       0.5865004       0.6666667       4.0000000
              adaptcoping             7187       3.1491330       0.5933259       1.0000000       4.0000000
              social                  7141       9.8143117       3.0744218       1.0000000      16.0000000
              sensecomm               7112      12.9160574       3.1682063       2.0000000      20.0000000
              ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

;



;

proc freq data = qq1_tot;
tables neighbrhdrtng neighbrhdimpact  percvdneighdistot sensecomm collecteff comminvolvement comminvolvementtrust socialties adaptcoping;
run;



proc corr data = qq1_tot;

var  neighbrhdrtng neighbrhdimpact  percvdneighdistot sensecomm collecteff comminvolvement comminvolvementtrust socialties adaptcoping;

run;

**                           neighbrhdrtng  neighbrhdimpact  percvdneighdistot  sensecomm  collecteff

  percvdneighdistot           0.48894         -0.25516            1.00000   -0.32137    -0.48891
                               <.0001           <.0001                        <.0001      <.0001
                                 7151             7116               7153       7079        7106

  sensecomm                  -0.42744          0.34826           -0.32137    1.00000     0.60165
                               <.0001           <.0001             <.0001                 <.0001
                                 7110             7075               7079       7112        7033

  collecteff                 -0.56206          0.32554           -0.48891    0.60165     1.00000
                               <.0001           <.0001             <.0001     <.0001
                                 7105             7071               7106       7033        7107

  comminvolvement            -0.22982          0.33293           -0.01053    0.32476     0.31799
                               <.0001           <.0001             0.3733     <.0001      <.0001
                                 7142             7108               7144       7070        7097

  comminvolvementtrust       -0.32158          0.20333           -0.12558    0.32541     0.42605
                               <.0001           <.0001             <.0001     <.0001      <.0001
                                 7182             7147               7152       7110        7105

  socialties                 -0.36944          0.33515           -0.19600    0.63683     0.57636
                               <.0001           <.0001             <.0001     <.0001      <.0001
                                 7139             7105               7107       7066        7107

  adaptcoping                -0.51982          0.21690           -0.52580    0.30839     0.43055
                               <.0001           <.0001             <.0001     <.0001      <.0001
                                 7185             7150               7153       7112        7107

                                Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                        comminvolvement     comminvolvementtrust     socialties     adaptcoping

  percvdneighdistot            -0.01053                 -0.12558       -0.19600        -0.52580
                                 0.3733                   <.0001         <.0001          <.0001
                                   7144                     7152           7107            7153

  sensecomm                     0.32476                  0.32541        0.63683         0.30839
                                 <.0001                   <.0001         <.0001          <.0001
                                   7070                     7110           7066            7112

  collecteff                    0.31799                  0.42605        0.57636         0.43055
                                 <.0001                   <.0001         <.0001          <.0001
                                   7097                     7105           7107            7107

  ;


**Evaluating descriptives of income inequality, greenness, percent renter and unemployment**;
data qq1_tot; set qq1_tot;

Incineq = mean(GINI);
Vegind = mean(NDVI);
Percrent = mean (p_renter);
Unemploy = mean (p_unemploy);
run;






proc means data = qq1_tot;

var Incineq Vegind  Percrent Unemploy ;

run;

**  The MEANS Procedure

         Variable       N            Mean         Std Dev         Minimum         Maximum
         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
         Incineq     7247       0.3975115       0.0697995       0.2410000       0.5930000
         Vegind      7247       0.1943857       0.0658978       0.0354897       0.5695230
         Res5yrs     7247      40.2360930      12.7745818      15.2580000      82.5329000
         Percrent    7247      31.1813164      24.3530805       2.1000000      99.6000000
         Unemploy    7247       7.2378363       4.2781687               0      20.8000000
         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

**;


proc freq data = qq1_tot;
tables Incineq Vegind  Percrent Unemploy ;
run;



proc corr data = qq1_tot;

var  Incineq Vegind Percrent Unemploy ;

run;
**   Pearson Correlation Coefficients, N = 7247
                                    Prob > |r| under H0: Rho=0

                         Incineq        Vegind       Res5yrs      Percrent      Unemploy

          Incineq        1.00000      -0.00865       0.03879       0.27114       0.08476
                                        0.4617        0.0010        <.0001        <.0001

          Vegind        -0.00865       1.00000      -0.16819      -0.21178      -0.05940
                          0.4617                      <.0001        <.0001        <.0001

          Res5yrs        0.03879      -0.16819       1.00000       0.65138       0.60231
                          0.0010        <.0001                      <.0001        <.0001

          Percrent       0.27114      -0.21178       0.65138       1.00000       0.40763
                          <.0001        <.0001        <.0001                      <.0001

          Unemploy       0.08476      -0.05940       0.60231       0.40763       1.00000
                          <.0001        <.0001        <.0001        <.0001


;

 



**Measure of well-being (Positive affect)**;
data qq1_tot; set qq1_tot;
paff = mean(paff);

proc means data = qq1_tot;
var paff;
run;

** The MEANS Procedure

                                  Analysis Variable : PosAffect

                  N            Mean         Std Dev         Minimum         Maximum
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
               5091       3.0859454       0.9730629       1.0000000       5.0000000
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
;

**Measure of well-being (Negative Affect)**;
data qq1_tot; set qq1_tot;
naff = mean(naff);

proc means data = qq1_tot;
var naff;
run;
**The MEANS Procedure

                                  Analysis Variable : NegAffect

                  N            Mean         Std Dev         Minimum         Maximum
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
               5091       1.2439843       0.4550549       1.0000000       4.9000000
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
;








proc corr data = qq1_tot;

var  Incineq Vegind Percrent Unemploy NegAffect PosAffect ;

run;

** Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                                                                                Neg         Pos
                Incineq      Vegind     Res5yrs    Percrent    Unemploy      Affect      Affect

  Incineq       1.00000    -0.00865     0.03879     0.27114     0.08476    -0.01736     0.10853
                             0.4617      0.0010      <.0001      <.0001      0.2158      <.0001
                   7247        7247        7247        7247        7247        5086        5086

  Vegind       -0.00865     1.00000    -0.16819    -0.21178    -0.05940    -0.06967     0.01771
                 0.4617                  <.0001      <.0001      <.0001      <.0001      0.2066
                   7247        7247        7247        7247        7247        5086        5086

  Res5yrs       0.03879    -0.16819     1.00000     0.65138     0.60231     0.03787    -0.04460
                 0.0010      <.0001                  <.0001      <.0001      0.0069      0.0015
                   7247        7247        7247        7247        7247        5086        5086

  Percrent      0.27114    -0.21178     0.65138     1.00000     0.40763     0.02532    -0.01570
                 <.0001      <.0001      <.0001                  <.0001      0.0710      0.2630
                   7247        7247        7247        7247        7247        5086        5086

  Unemploy      0.08476    -0.05940     0.60231     0.40763     1.00000     0.06199    -0.01973
                 <.0001      <.0001      <.0001      <.0001                  <.0001      0.1595
                   7247        7247        7247        7247        7247        5086        5086

  NegAffect    -0.01736    -0.06967     0.03787     0.02532     0.06199     1.00000    -0.23727
                 0.2158      <.0001      0.0069      0.0710      <.0001                  <.0001
                   5086        5086        5086        5086        5086        5091        5091

  PosAffect     0.10853     0.01771    -0.04460    -0.01570    -0.01973    -0.23727     1.00000
                 <.0001      0.2066      0.0015      0.2630      0.1595      <.0001
                   5086        5086        5086        5086        5086        5091        5091



**;




**Include demographic variables**;

data qq1_tot; set qq1_tot;
age = mean(age);
gender = mean(gender);
edu = mean(edu);
marital = mean(relat);
empstat = mean(emply1a);
indvincome = mean (income);
run;

proc means data  =  qq1_tot;
var age gender edu marital empstat indvincome;
run;
**         The MEANS Procedure

  
                                                                 The MEANS Procedure

              Variable      Label                                      N            Mean         Std Dev         Minimum         Maximum
              ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
              age           age                                     7188      53.2799110       7.4761233      40.0000000      65.0000000
              gender        gender                                  7135       0.4576034       0.4982342               0       1.0000000
              edu           highest level of education completed    7150       6.3948252       1.8643465       1.0000000       9.0000000
              marital                                               7071       2.6916985       2.0923482       1.0000000       6.0000000
              empstat                                               7013       0.6620562       0.4733444               0       2.0000000
              indvincome                                            6973       6.2400688       2.9258900       1.0000000      14.0000000





**;


 data rsg.long;
 set qq1_tot;
 run;






**Centering variables of interest to evaluate regression analytics**;
data qq1_tot; set qq1_tot;

Incineqc = Incineq - 0.3975115;

Vegindc = Vegind -  0.1943857;

Percrentc = Percrent - 31.1813164;

Unemployc = Unemploy - 7.2378363;



/*Creation of variables for whether or not a stressful or positive event occurred. 
For example, strsevtb indicates the categories that a stressful event occurred, with 0 being no stressful event. 
This new variable, stressevent, indicates whether or not a stressor occurred, independent of the source
*/;
IF strsevtb = 0 THEN stressevent = 0;
IF strsevtb GE 1 THEN stressevent = 1;

IF pastcat = 0 THEN positiveevent = 0;
IF pastcat GE 1 THEN positiveevent = 1;


RUN;





data rsg.long;
 set qq1_tot;
 run;

PROC FREQ DATA = qq1_tot;
	TABLES stressevent positiveevent;
RUN;

* stressevent    Frequency     Percent     Frequency      Percent
                ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                          0        2031       39.93          2031        39.93
                          1        3056       60.07          5087       100.00

                                    Frequency Missing = 2190


                                                         Cumulative    Cumulative
               positiveevent    Frequency     Percent     Frequency      Percent
               ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                           0        1084       21.35          1084        21.35
                           1        3994       78.65          5078       100.00


;


proc means data = qq1_tot;

var stressevent;

run;


*  Analysis Variable : stressevent

                 N            Mean         Std Dev         Minimum         Maximum
              ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
              5087       0.6007470       0.4897930               0       1.0000000
              ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ


;


PROC MEANS DATA = qq1_tot;
WHERE PosAffect GE 1;
	VAR Incineq Vegind Percrent Unemploy  disorderc  collecteff  comminvolvementtrust  adaptcoping;
RUN;
*   The MEANS Procedure

   Variable                   N            Mean         Std Dev         Minimum         Maximum
   ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
   Incineq                 5086       0.3940914       0.0684051       0.2410000       0.5930000
   Vegind                  5086       0.1939609       0.0669206       0.0726055       0.4370970
   Res5yrs                 5086      40.8469165      12.7781420      15.2580000      82.5329000
   Percrent                5086      31.1325796      23.7800515       2.1000000      96.3000000
   Unemploy                5086       7.2475226       4.2816570               0      20.8000000
   percvdneighdistot       5054       2.0110485       0.3988199       1.2000000       3.4000000
   sensecomm               5023       2.5988851       0.5923856       1.2000000       4.0000000
   collecteff              5026       3.6981795       0.8059687       1.3333333       5.0000000
   comminvolvement         5054       2.2262079       0.6118879               0       3.5714286
   comminvolvementtrust    5083       2.6679028       0.5783763       1.0000000       4.0000000
   socialties              5055       9.7224530       3.1269031       1.0000000      16.0000000
   adaptcoping             5083       3.1550041       0.5739319       1.0000000       4.0000000
   ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ



;

PROC MEANS DATA = qq1_tot;
WHERE NegAffect GE 1;
	VAR Incineq Vegind Res5yrs Percrent Unemploy  percvdneighdistot sensecomm collecteff comminvolvement comminvolvementtrust socialties adaptcoping;
RUN;



**   The MEANS Procedure

   Variable                   N            Mean         Std Dev         Minimum         Maximum
   ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
   Incineq                 5086       0.3940914       0.0684051       0.2410000       0.5930000
   Vegind                  5086       0.1939609       0.0669206       0.0726055       0.4370970
   Res5yrs                 5086      40.8469165      12.7781420      15.2580000      82.5329000
   Percrent                5086      31.1325796      23.7800515       2.1000000      96.3000000
   Unemploy                5086       7.2475226       4.2816570               0      20.8000000
   percvdneighdistot       5054       2.0110485       0.3988199       1.2000000       3.4000000
   sensecomm               5023       2.5988851       0.5923856       1.2000000       4.0000000
   collecteff              5026       3.6981795       0.8059687       1.3333333       5.0000000
   comminvolvement         5054       2.2262079       0.6118879               0       3.5714286
   comminvolvementtrust    5083       2.6679028       0.5783763       1.0000000       4.0000000
   socialties              5055       9.7224530       3.1269031       1.0000000      16.0000000
   adaptcoping             5083       3.1550041       0.5739319       1.0000000       4.0000000
   ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ



;








DATA qq1_tot; SET qq1_tot;
incomec = incineq -       0.3940914 ;
greenc  = vegind  -       0.1939609 ;
efficacyc = collecteff - 3.6981795;
involvetrustc = comminvolvementtrust - 2.6679028;
adaptc = adaptcoping -  3.1550041;
percrentc = Percrent - 31.1325796;
unemployc = Unemploy - 7.2475226;
agec = age - 53.2799110;
genderc = gender - 0.4576034; 
maritalc = marital  - 2.6916985;
empstatc = empstat -    0.6620562;
educ = edu -  6.3948252 ;
indvincomec = indvincome - 6.2400688;
RUN;

proc corr data = qq1_tot;

var incomec greenc percrentc unemployc efficacyc involvetrustc adaptc agec educ genderc paff naff;

run;
*  Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                    incomec      greenc    Percrentc    Unemployc    efficacyc    involvetrustc

  incomec           1.00000    -0.00865      0.27114      0.08476      0.05255          0.12272
                                 0.4617       <.0001       <.0001       <.0001           <.0001
                       7247        7247         7247         7247         7107             7184

  greenc           -0.00865     1.00000     -0.21178     -0.05940      0.04631         -0.08885
                     0.4617                   <.0001       <.0001       <.0001           <.0001
                       7247        7247         7247         7247         7107             7184

                                Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                                  adaptc          agec          educ       genderc

               incomec          -0.00948       0.14410       0.12190      -0.10170
                                  0.4219        <.0001        <.0001        <.0001
                                    7187          7188          7150          7135

               greenc            0.02867       0.02341       0.04522       0.03965
                                  0.0151        0.0472        0.0001        0.0008
                                    7187          7188          7150          7135

                                         The SAS System            09:04 Friday, June 7, 2019  18

                                       The CORR Procedure

                                Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                    incomec      greenc    Percrentc    Unemployc    efficacyc    involvetrustc

  Percrentc         0.27114    -0.21178      1.00000      0.40763     -0.24882         -0.05956
                     <.0001      <.0001                    <.0001       <.0001           <.0001
                       7247        7247         7247         7247         7107             7184

  Unemployc         0.08476    -0.05940      0.40763      1.00000     -0.41485         -0.19901
                     <.0001      <.0001       <.0001                    <.0001           <.0001
                       7247        7247         7247         7247         7107             7184

  efficacyc         0.05255     0.04631     -0.24882     -0.41485      1.00000          0.42605
                     <.0001      <.0001       <.0001       <.0001                        <.0001
                       7107        7107         7107         7107         7107             7105

  involvetrustc     0.12272    -0.08885     -0.05956     -0.19901      0.42605          1.00000
                     <.0001      <.0001       <.0001       <.0001       <.0001
                       7184        7184         7184         7184         7105             7184

  adaptc           -0.00948     0.02867     -0.26594     -0.33448      0.43055          0.26462
                     0.4219      0.0151       <.0001       <.0001       <.0001           <.0001
                       7187        7187         7187         7187         7107             7184

  agec              0.14410     0.02341     -0.02999      0.09491      0.01535         -0.02104
                     <.0001      0.0472       0.0110       <.0001       0.1957           0.0745
                       7188        7188         7188         7188         7106             7183

  educ              0.12190     0.04522     -0.06412     -0.06436      0.21094          0.26466
                     <.0001      0.0001       <.0001       <.0001       <.0001           <.0001
                       7150        7150         7150         7150         7068             7145

  genderc          -0.10170     0.03965     -0.00504     -0.04659     -0.13857         -0.07694
                     <.0001      0.0008       0.6701       <.0001       <.0001           <.0001
                       7135        7135         7135         7135         7053             7130

                                Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                                  adaptc          agec          educ       genderc

               Percrentc        -0.26594      -0.02999      -0.06412      -0.00504
                                  <.0001        0.0110        <.0001        0.6701
                                    7187          7188          7150          7135

                                         The SAS System            09:04 Friday, June 7, 2019  19

                                       The CORR Procedure

                                Pearson Correlation Coefficients
                                   Prob > |r| under H0: Rho=0
                                     Number of Observations

                                  adaptc          agec          educ       genderc

               Unemployc        -0.33448       0.09491      -0.06436      -0.04659
                                  <.0001        <.0001        <.0001        <.0001
                                    7187          7188          7150          7135

               efficacyc         0.43055       0.01535       0.21094      -0.13857
                                  <.0001        0.1957        <.0001        <.0001
                                    7107          7106          7068          7053

               involvetrustc     0.26462      -0.02104       0.26466      -0.07694
                                  <.0001        0.0745        <.0001        <.0001
                                    7184          7183          7145          7130

               adaptc            1.00000       0.06129       0.08442       0.19572
                                                <.0001        <.0001        <.0001
                                    7187          7186          7148          7133

               agec              0.06129       1.00000       0.15788       0.03569
                                  <.0001                      <.0001        0.0026
                                    7186          7188          7150          7135

               educ              0.08442       0.15788       1.00000      -0.08756
                                  <.0001        <.0001                      <.0001
                                    7148          7150          7150          7097

               genderc           0.19572       0.03569      -0.08756       1.00000
                                  <.0001        0.0026        <.0001
                                    7133          7135          7097          7135




;

PROC GLIMMIX DATA = qq1_tot METHOD = QUAD (QPOINTS=21) NOCLPRINT;
CLASS id;
MODEL stressevent(DESC) = incomec greenc percrentc unemployc  efficacyc  involvetrustc adaptc / SOLUTION DIST=BINARY LINK=LOGIT;
RANDOM INTERCEPT / SUBJECT = id;
RUN;
*         
       Convergence criterion (GCONV=1E-8) satisfied.


                                         Fit Statistics

                              -2 Log Likelihood            5335.45
                              AIC  (smaller is better)     5353.45
                              AICC (smaller is better)     5353.49
                              BIC  (smaller is better)     5382.58
                              CAIC (smaller is better)     5391.58
                              HQIC (smaller is better)     5365.25


                          Fit Statistics for Conditional Distribution

                         -2 log L(stressevent | r. effects)     4749.88
                         Pearson Chi-Square                     4286.89
                         Pearson Chi-Square / DF                   0.85


                                 Covariance Parameter Estimates

                                                              Standard
                          Cov Parm     Subject    Estimate       Error

                          Intercept    id           2.7758      0.3756

                                         The SAS System            09:04 Friday, June 7, 2019  22

                                      The GLIMMIX Procedure

                                   Solutions for Fixed Effects

                                           Standard
              Effect           Estimate       Error       DF    t Value    Pr > |t|

              Intercept          0.5734      0.1315      183       4.36      <.0001
              incomec           -0.2211      1.9499     4831      -0.11      0.9097
              greenc            -2.3358      2.0716     4831      -1.13      0.2596
              Percrentc        -0.00515    0.006519     4831      -0.79      0.4295
              Unemployc         0.02702     0.03793     4831       0.71      0.4762
              efficacyc        -0.08779      0.2065     4831      -0.43      0.6707
              involvetrustc      0.1622      0.2563     4831       0.63      0.5268
              adaptc            -0.5013      0.2546     4831      -1.97      0.0490





   
;


PROC GLIMMIX DATA = qq1_tot METHOD = QUAD (QPOINTS=21) NOCLPRINT;
CLASS id;
MODEL stressevent(DESC) =  incomec greenc percrentc unemployc  efficacyc  involvetrustc adaptc agec educ genderc indvincomec / SOLUTION DIST=BINARY LINK=LOGIT;
RANDOM INTERCEPT / SUBJECT = id;
RUN;

*
                          Convergence criterion (GCONV=1E-8) satisfied.


                                                                    Fit Statistics

                                                         -2 Log Likelihood            5047.98
                                                         AIC  (smaller is better)     5073.98
                                                         AICC (smaller is better)     5074.05
                                                         BIC  (smaller is better)     5115.56
                                                         CAIC (smaller is better)     5128.56
                                                         HQIC (smaller is better)     5090.83


                                                     Fit Statistics for Conditional Distribution

                                                    -2 log L(stressevent | r. effects)     4496.01
                                                    Pearson Chi-Square                     4098.95
                                                    Pearson Chi-Square / DF                   0.85



                                         The GLIMMIX Procedure

                                                            Covariance Parameter Estimates

                                                                                         Standard
                                                     Cov Parm     Subject    Estimate       Error

                                                     Intercept    id           2.6607      0.3719


                                                             Solutions for Fixed Effects

                                                                     Standard
                                        Effect           Estimate       Error       DF    t Value    Pr > |t|

                                        Intercept          0.5895      0.1322      170       4.46      <.0001
                                        incomec           -0.2218      1.9937     4631      -0.11      0.9114
                                        greenc            -1.9198      2.0923     4631      -0.92      0.3589
                                        Percrentc        -0.00467    0.006653     4631      -0.70      0.4832
                                        Unemployc         0.04230     0.03902     4631       1.08      0.2784
                                        efficacyc         -0.1314      0.2125     4631      -0.62      0.5365
                                        involvetrustc     0.06053      0.2610     4631       0.23      0.8166
                                        adaptc            -0.5043      0.2642     4631      -1.91      0.0563
                                        agec             -0.03486     0.01843     4631      -1.89      0.0586
                                        educ               0.2131     0.08122     4631       2.62      0.0087
                                        genderc            0.2073      0.2813     4631       0.74      0.4613
                                        indvincomec      0.005988     0.05522     4631       0.11      0.9136







;
PROC GLIMMIX DATA = qq1_tot METHOD = QUAD (QPOINTS=21) NOCLPRINT;
CLASS id;
MODEL positiveevent(DESC) =  incomec greenc percrentc unemployc  efficacyc  involvetrustc adaptc/ SOLUTION DIST=BINARY LINK=LOGIT;
RANDOM INTERCEPT / SUBJECT = id;
RUN;

**          
                                  
                         Convergence criterion (GCONV=1E-8) satisfied.


                                         Fit Statistics

                              -2 Log Likelihood            3696.12
                              AIC  (smaller is better)     3714.12
                              AICC (smaller is better)     3714.15
                              BIC  (smaller is better)     3743.25
                              CAIC (smaller is better)     3752.25
                              HQIC (smaller is better)     3725.92


                          Fit Statistics for Conditional Distribution

                        -2 log L(positiveevent | r. effects)     3167.47
                        Pearson Chi-Square                       3561.18
                        Pearson Chi-Square / DF                     0.71


                                 Covariance Parameter Estimates

                                                              Standard
                          Cov Parm     Subject    Estimate       Error

                          Intercept    id           4.5200      0.6916

                                         The SAS System          14:52 Thursday, June 6, 2019  24

                                      The GLIMMIX Procedure

                                   Solutions for Fixed Effects

                                           Standard
              Effect           Estimate       Error       DF    t Value    Pr > |t|

              Intercept          2.1945      0.1823      183      12.04      <.0001
              incomec           -1.4603      2.6608     4822      -0.55      0.5832
              greenc             0.1880      2.7185     4822       0.07      0.9449
              Percrentc        0.004407    0.008718     4822       0.51      0.6132
              Unemployc        -0.02427     0.04952     4822      -0.49      0.6242
              efficacyc          0.1656      0.2724     4822       0.61      0.5433
              involvetrustc      1.1866      0.3422     4822       3.47      0.0005
              adaptc            -0.1526      0.3257     4822      -0.47      0.6395




 
;


PROC GLIMMIX DATA = qq1_tot METHOD = QUAD (QPOINTS=21) NOCLPRINT;
CLASS id;
MODEL positiveevent(DESC) =   incomec greenc percrentc unemployc  efficacyc  involvetrustc adaptc agec educ genderc indvincomec / SOLUTION DIST=BINARY LINK=LOGIT;
RANDOM INTERCEPT / SUBJECT = id;
RUN;
* 
                         Convergence criterion (GCONV=1E-8) satisfied.

  Covariance Parameter Estimates

                                                                                         Standard
                                                     Cov Parm     Subject    Estimate       Error

                                                     Intercept    id           4.3495      0.6863


                                                             Solutions for Fixed Effects

                                                                     Standard
                                        Effect           Estimate       Error       DF    t Value    Pr > |t|

                                        Intercept          2.2665      0.1855      170      12.22      <.0001
                                        incomec           -3.6024      2.7372     4623      -1.32      0.1882
                                        greenc            -0.8404      2.7603     4623      -0.30      0.7608
                                        Percrentc        0.009516    0.009003     4623       1.06      0.2905
                                        Unemployc        -0.03136     0.05131     4623      -0.61      0.5411
                                        efficacyc        0.005284      0.2809     4623       0.02      0.9850
                                        involvetrustc      1.1398      0.3495     4623       3.26      0.0011

                                                                       GSA Omar                                     14:32 Tuesday, August 27, 2019  23

                                                                The GLIMMIX Procedure

                                                             Solutions for Fixed Effects

                                                                     Standard
                                        Effect           Estimate       Error       DF    t Value    Pr > |t|

                                        adaptc           -0.03990      0.3399     4623      -0.12      0.9066
                                        agec              0.01850     0.02447     4623       0.76      0.4497
                                        educ               0.2223      0.1063     4623       2.09      0.0365
                                        genderc          -0.04296      0.3740     4623      -0.11      0.9086
                                        indvincomec       0.06391     0.07362     4623       0.87      0.3854





;



***Use this for final analysis**;

PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL paff =  incomec greenc   efficacyc unemployc percrentc involvetrustc  adaptc disorderc  stressevent positiveevent agec  genderc indvincomec

				  incomec*stressevent greenc*stressevent unemployc*stressevent percrentc*stressevent 
                  efficacyc*stressevent  involvetrustc*stressevent  adaptc*stressevent disorderc*stressevent
                  

				  incomec*positiveevent greenc*positiveevent unemployc*positiveevent 
percrentc*positiveevent  efficacyc*positiveevent  involvetrustc*positiveevent  adaptc*positiveevent disorderc*positiveevent
                 

                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept stressevent positiveevent / SUBJECT=id TYPE=UN;
RUN;
*   


  Convergence criteria met.

                                                                       GSA Omar                                     14:32 Tuesday, August 27, 2019  25

                                                                 The Mixed Procedure

                                                            Covariance Parameter Estimates

                                                                              Standard         Z
                                          Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                          UN(1,1)      id           0.5671     0.07650      7.41      <.0001
                                          UN(2,1)      id         0.002174     0.02387      0.09      0.9274
                                          UN(2,2)      id          0.05794     0.01352      4.28      <.0001
                                          UN(3,1)      id         -0.07452     0.03424     -2.18      0.0295
                                          UN(3,2)      id         -0.03659     0.01343     -2.72      0.0065
                                          UN(3,3)      id          0.09718     0.02410      4.03      <.0001
                                          Residual                  0.2661    0.005693     46.74      <.0001


                                                                   Fit Statistics

                                                        -2 Log Likelihood              8126.2
                                                        AIC (Smaller is Better)        8202.2
                                                        AICC (Smaller is Better)       8202.8
                                                        BIC (Smaller is Better)        8323.7


                                                           Null Model Likelihood Ratio Test

                                                             DF    Chi-Square      Pr > ChiSq

                                                              6       4315.51          <.0001


                                                             Solution for Fixed Effects

                                                                         Standard
                                     Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                     Intercept                 2.9856     0.08905     167      33.53      <.0001
                                     incomec                   0.2283      1.0030     167       0.23      0.8202
                                     greenc                    0.6014      1.0030     167       0.60      0.5496
                                     efficacyc               -0.02718      0.1063     167      -0.26      0.7985
                                     Unemployc                0.01147     0.01868     167       0.61      0.5401
                                     Percrentc               0.005433    0.003448     167       1.58      0.1170
                                     involvetrustc             0.3753      0.1290     167       2.91      0.0041
                                     adaptc                   0.01005      0.1307     167       0.08      0.9388
                                     disorderc                -0.2108      0.2206     167      -0.96      0.3406
                                     stressevent              -0.1838     0.04256    4594      -4.32      <.0001
                                     positiveevent             0.4122     0.05688    4594       7.25      <.0001
                                     agec                     0.01578    0.007626     167       2.07      0.0401
                                     educ                    -0.02155     0.03353     167      -0.64      0.5213
                                     genderc                   0.1941      0.1163     167       1.67      0.0968
                                     indvincomec             -0.01132     0.02274     167      -0.50      0.6191
                                     incomec*stressevent      -0.7821      0.4085    4594      -1.91      0.0556

                                                                       GSA Omar                                     14:32 Tuesday, August 27, 2019  26

                                                                 The Mixed Procedure

                                                             Solution for Fixed Effects

                                                                         Standard
                                     Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                     greenc*stressevent       -0.3170      0.4385    4594      -0.72      0.4697
                                     Unemployc*stresseven    0.001812    0.008474    4594       0.21      0.8307
                                     Percrentc*stresseven    -0.00071    0.001521    4594      -0.47      0.6388
                                     efficacyc*stresseven     0.08146     0.04820    4594       1.69      0.0911
                                     involvetr*stresseven    -0.07856     0.05636    4594      -1.39      0.1635
                                     adaptc*stressevent       0.02607     0.06478    4594       0.40      0.6874
                                     disorderc*stresseven     0.08129      0.1091    4594       0.75      0.4561
                                     incomec*positiveeven      0.8804      0.6303    4594       1.40      0.1625
                                     greenc*positiveevent     0.07898      0.5777    4594       0.14      0.8913
                                     Unemployc*positiveev    -0.00008     0.01097    4594      -0.01      0.9940
                                     Percrentc*positiveev    -0.00216    0.002199    4594      -0.98      0.3251
                                     efficacyc*positiveev    -0.01270     0.06350    4594      -0.20      0.8414
                                     involvetr*positiveev     0.03339     0.07745    4594       0.43      0.6664
                                     adaptc*positiveevent     0.01883     0.07915    4594       0.24      0.8120
                                     disorderc*positiveev    -0.08951      0.1420    4594      -0.63      0.5283










;



**Stressors only**;
PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL paff =  incomec greenc   efficacyc unemployc percrentc involvetrustc  adaptc  stressevent  agec educ genderc indvincomec

				  incomec*stressevent greenc*stressevent unemployc*stressevent percrentc*stressevent 
                  efficacyc*stressevent  involvetrustc*stressevent  adaptc*stressevent
                  

				 
                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept stressevent / SUBJECT=id TYPE=UN;
RUN;
* Iteration History

                   Iteration    Evaluations        -2 Log Like       Criterion

                           0              1     13194.04474948
                           1              2      8750.00893606      0.12978990
                           2              1      8722.89164414      0.03205307
                           3              1      8716.03241986      0.00380258
                           4              1      8715.26308660      0.00009882
                           5              1      8715.24437297      0.00000010
                           6              1      8715.24435482      0.00000000


                                   Convergence criteria met.



                                         The SAS System         08:50 Thursday, June 27, 2019  17

                                       The Mixed Procedure

                                 Covariance Parameter Estimates

                                                   Standard         Z
               Cov Parm     Subject    Estimate       Error     Value        Pr Z

               UN(1,1)      id           0.5681     0.06486      8.76      <.0001
               UN(2,1)      id         -0.06412     0.02530     -2.53      0.0113
               UN(2,2)      id          0.08595     0.01671      5.14      <.0001
               Residual                  0.2885    0.006006     48.04      <.0001


                                         Fit Statistics

                              -2 Log Likelihood              8715.2
                              AIC (Smaller is Better)        8761.2
                              AICC (Smaller is Better)       8761.5
                              BIC (Smaller is Better)        8835.4


                                Null Model Likelihood Ratio Test

                                  DF    Chi-Square      Pr > ChiSq

                                   3       4478.80          <.0001


                                   Solution for Fixed Effects

                                               Standard
           Effect                  Estimate       Error      DF    t Value    Pr > |t|

           Intercept                 3.1960     0.05863     174      54.51      <.0001
           incomec                   0.8936      0.8878     174       1.01      0.3156
           greenc                    0.6240      0.9212     174       0.68      0.4990
           efficacyc                0.03107     0.09337     174       0.33      0.7397
           Unemployc                0.01026     0.01715     174       0.60      0.5506
           Percrentc               0.001888    0.002943     174       0.64      0.5220
           involvetrustc             0.3952      0.1169     174       3.38      0.0009
           adaptc                   0.07001      0.1157     174       0.61      0.5459
           stressevent              -0.1302     0.03141    4751      -4.14      <.0001
           agec                     0.01959    0.007640     174       2.56      0.0112
           educ                    0.003717     0.03150     174       0.12      0.9062
           genderc                   0.1730      0.1162     174       1.49      0.1383
           incomec*stressevent      -0.8581      0.4577    4751      -1.87      0.0609
           greenc*stressevent       -0.3527      0.4882    4751      -0.72      0.4701
           Unemployc*stresseven    0.001646    0.009347    4751       0.18      0.8603
           Percrentc*stresseven    -0.00010    0.001553    4751      -0.07      0.9482
           efficacyc*stresseven     0.03530     0.04873    4751       0.72      0.4689
           involvetr*stresseven    -0.07805     0.06221    4751      -1.25      0.2097
           adaptc*stressevent      -0.00002     0.06445    4751      -0.00      0.9998



;



**Positive only**;
PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL paff =  incomec greenc   efficacyc unemployc percrentc involvetrustc  adaptc  positiveevent agec educ genderc indvincomec

				  
                 

				  incomec*positiveevent greenc*positiveevent unemployc*positiveevent percrentc*positiveevent
efficacyc*positiveevent  involvetrustc*positiveevent  adaptc*positiveevent
                 

                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept  positiveevent / SUBJECT=id TYPE=UN;
RUN;


*     
                                        Iteration History

                   Iteration    Evaluations        -2 Log Like       Criterion

                           0              1     13083.86900095
                           1              2      8652.09694114      9.32773193
                           2              1      8596.53746523      9.60984870
                           3              1      8561.94424091      0.23885374
                           4              2      8544.10678308      0.01053599
                           5              1      8540.83759515      0.00112192
                           6              1      8540.51625059      0.00001742
                           7              1      8540.51155784      0.00000000


                                   Convergence criteria met.



                                         The SAS System         08:50 Thursday, June 27, 2019  22

                                       The Mixed Procedure

                                 Covariance Parameter Estimates

                                                   Standard         Z
               Cov Parm     Subject    Estimate       Error     Value        Pr Z

               UN(1,1)      id           0.6089     0.07772      7.83      <.0001
               UN(2,1)      id         -0.09369     0.03613     -2.59      0.0095
               UN(2,2)      id           0.1052     0.02476      4.25      <.0001
               Residual                  0.2804    0.005833     48.08      <.0001


                                         Fit Statistics

                              -2 Log Likelihood              8540.5
                              AIC (Smaller is Better)        8586.5
                              AICC (Smaller is Better)       8586.7
                              BIC (Smaller is Better)        8660.7


                                Null Model Likelihood Ratio Test

                                  DF    Chi-Square      Pr > ChiSq

                                   3       4543.36          <.0001


                                   Solution for Fixed Effects

                                               Standard
           Effect                  Estimate       Error      DF    t Value    Pr > |t|

           Intercept                 2.8067     0.06520     174      43.05      <.0001
           incomec                  -0.3728      1.0161     174      -0.37      0.7141
           greenc                    0.4011      1.0013     174       0.40      0.6892
           efficacyc                0.02824      0.1023     174       0.28      0.7827
           Unemployc                0.01211     0.01855     174       0.65      0.5149
           Percrentc               0.004077    0.003263     174       1.25      0.2131
           involvetrustc             0.2805      0.1283     174       2.19      0.0301
           adaptc                   0.05254      0.1218     174       0.43      0.6667
           positiveevent             0.3939     0.04055    4744       9.71      <.0001
           agec                     0.02006    0.007666     174       2.62      0.0096
           educ                    -0.00742     0.03166     174      -0.23      0.8151
           genderc                   0.1615      0.1167     174       1.38      0.1681
           incomec*positiveeven      0.9674      0.6462    4744       1.50      0.1344
           greenc*positiveevent    -0.01513      0.5887    4744      -0.03      0.9795
           Unemployc*positiveev    0.001467     0.01114    4744       0.13      0.8953
           Percrentc*positiveev    -0.00293    0.002014    4744      -1.45      0.1460
           efficacyc*positiveev     0.03256     0.06043    4744       0.54      0.5901
           involvetr*positiveev     0.02542     0.07783    4744       0.33      0.7440
           adaptc*positiveevent     0.04410     0.07287    4744       0.61      0.5451



;








**Combined neg affect**;
PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL naff =  incomec greenc    efficacyc unemployc percrentc involvetrustc  adaptc disorderc  stressevent positiveevent agec educ genderc indvincomec

				  incomec*stressevent greenc*stressevent unemployc*stressevent percrentc*stressevent
efficacyc*stressevent  involvetrustc*stressevent  adaptc*stressevent disorderc*stressevent
				 

				  incomec*positiveevent greenc*positiveevent unemployc*positiveevent
percrentc*positiveevent  efficacyc*positiveevent  involvetrustc*positiveevent  adaptc*positiveevent disorderc*positiveevent
                  



                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept stressevent positiveevent / SUBJECT=id TYPE=UN;
RUN;





*   

**  Convergence criteria met.

                                                                       GSA Omar                                     14:32 Tuesday, August 27, 2019  28

                                                                 The Mixed Procedure

                                                            Covariance Parameter Estimates

                                                                              Standard         Z
                                          Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                          UN(1,1)      id          0.07791     0.01170      6.66      <.0001
                                          UN(2,1)      id          0.02864    0.004180      6.85      <.0001
                                          UN(2,2)      id         0.008589    0.002814      3.05      0.0011
                                          UN(3,1)      id         -0.01465    0.005394     -2.72      0.0066
                                          UN(3,2)      id         -0.00169    0.002229     -0.76      0.4487
                                          UN(3,3)      id         0.007164    0.003871      1.85      0.0321
                                          Residual                 0.08497    0.001817     46.77      <.0001


                                                                   Fit Statistics

                                                        -2 Log Likelihood              2383.5
                                                        AIC (Smaller is Better)        2459.5
                                                        AICC (Smaller is Better)       2460.1
                                                        BIC (Smaller is Better)        2581.1


                                                           Null Model Likelihood Ratio Test

                                                             DF    Chi-Square      Pr > ChiSq

                                                              6       3156.82          <.0001


                                                             Solution for Fixed Effects

                                                                         Standard
                                     Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                     Intercept                 1.1639     0.03517     167      33.09      <.0001
                                     incomec                   0.4886      0.4016     167       1.22      0.2254
                                     greenc                   -0.5480      0.3921     167      -1.40      0.1641
                                     efficacyc                0.01306     0.04178     167       0.31      0.7550
                                     Unemployc               -0.00669    0.007280     167      -0.92      0.3593
                                     Percrentc               -0.00117    0.001377     167      -0.85      0.3960
                                     involvetrustc           -0.08085     0.05076     167      -1.59      0.1131
                                     adaptc                  -0.08073     0.05128     167      -1.57      0.1173
                                     disorderc                 0.1266     0.08680     167       1.46      0.1467
                                     stressevent               0.1922     0.01880    4594      10.22      <.0001
                                     positiveevent           -0.04195     0.02346    4594      -1.79      0.0738
                                     agec                    -0.00140    0.002552     167      -0.55      0.5852
                                     educ                     0.01264     0.01092     167       1.16      0.2488
                                     genderc                   0.1044     0.04003     167       2.61      0.0099
                                     indvincomec             -0.01020    0.007840     167      -1.30      0.1949
                                     incomec*stressevent       0.1852      0.1819    4594       1.02      0.3086

                                                                       GSA Omar                                     14:32 Tuesday, August 27, 2019  29

                                                                 The Mixed Procedure

                                                             Solution for Fixed Effects

                                                                         Standard
                                     Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                     greenc*stressevent       -0.3592      0.1943    4594      -1.85      0.0646
                                     Unemployc*stresseven    0.006207    0.003710    4594       1.67      0.0944
                                     Percrentc*stresseven    -0.00148    0.000671    4594      -2.21      0.0270
                                     efficacyc*stresseven    0.009676     0.02115    4594       0.46      0.6473
                                     involvetr*stresseven    -0.00758     0.02486    4594      -0.30      0.7604
                                     adaptc*stressevent      -0.03812     0.02810    4594      -1.36      0.1750
                                     disorderc*stresseven    -0.05544     0.04749    4594      -1.17      0.2431
                                     incomec*positiveeven     -0.3636      0.2645    4594      -1.37      0.1692
                                     greenc*positiveevent      0.4278      0.2373    4594       1.80      0.0715
                                     Unemployc*positiveev    0.002346    0.004448    4594       0.53      0.5980
                                     Percrentc*positiveev    0.000868    0.000918    4594       0.95      0.3442
                                     efficacyc*positiveev    -0.00302     0.02588    4594      -0.12      0.9070
                                     involvetr*positiveev     0.01702     0.03199    4594       0.53      0.5947
                                     adaptc*positiveevent    -0.02040     0.03215    4594      -0.63      0.5257
                                     disorderc*positiveev    -0.07835     0.05740    4594      -1.36      0.1723




;

**Stressors only*;
PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL naff =  incomec greenc    efficacyc unemployc percrentc involvetrustc  adaptc  stressevent  agec educ genderc

				  incomec*stressevent greenc*stressevent unemployc*stressevent percrentc*stressevent  efficacyc*stressevent  involvetrustc*stressevent  adaptc*stressevent
				 

				

                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept stressevent / SUBJECT=id TYPE=UN;
RUN;
*

                                        Iteration History

                   Iteration    Evaluations        -2 Log Like       Criterion

                           0              1      5717.50056575
                           1              2      2512.05135994     44.14809336
                           2              3      2480.14692819       .
                           3              1      2470.17012726      0.00388937
                           4              1      2454.02087350      0.00120715
                           5              1      2449.24614483      0.00018481
                           6              1      2448.56389130      0.00000732
                           7              1      2448.53891490      0.00000001
                           8              1      2448.53886674      0.00000000


                                   Convergence criteria met.



                                         The SAS System         08:50 Thursday, June 27, 2019  24

                                       The Mixed Procedure

                                 Covariance Parameter Estimates

                                                   Standard         Z
               Cov Parm     Subject    Estimate       Error     Value        Pr Z

               UN(1,1)      id          0.05917    0.007758      7.63      <.0001
               UN(2,1)      id          0.02638    0.003488      7.56      <.0001
               UN(2,2)      id          0.01020    0.002931      3.48      0.0003
               Residual                 0.08509    0.001769     48.10      <.0001


                                         Fit Statistics

                              -2 Log Likelihood              2448.5
                              AIC (Smaller is Better)        2494.5
                              AICC (Smaller is Better)       2494.8
                              BIC (Smaller is Better)        2568.7


                                Null Model Likelihood Ratio Test

                                  DF    Chi-Square      Pr > ChiSq

                                   3       3268.96          <.0001


                                   Solution for Fixed Effects

                                               Standard
           Effect                  Estimate       Error      DF    t Value    Pr > |t|

           Intercept                 1.1468     0.01960     174      58.49      <.0001
           incomec                   0.1196      0.2968     174       0.40      0.6875
           greenc                   -0.3535      0.3058     174      -1.16      0.2493
           efficacyc               -0.00878     0.03124     174      -0.28      0.7790
           Unemployc               -0.00288    0.005705     174      -0.51      0.6139
           Percrentc               -0.00010    0.000983     174      -0.10      0.9166
           involvetrustc           -0.06912     0.03898     174      -1.77      0.0779
           adaptc                   -0.1162     0.03912     174      -2.97      0.0034
           stressevent               0.1745     0.01286    4751      13.57      <.0001
           agec                    -0.00087    0.002536     174      -0.34      0.7323
           educ                     0.01374     0.01027     174       1.34      0.1824
           genderc                   0.1155     0.03928     174       2.94      0.0037
           incomec*stressevent       0.1642      0.1873    4751       0.88      0.3809
           greenc*stressevent       -0.2945      0.1997    4751      -1.48      0.1402
           Unemployc*stresseven    0.005876    0.003778    4751       1.56      0.1199
           Percrentc*stresseven    -0.00149    0.000635    4751      -2.35      0.0187
           efficacyc*stresseven     0.02401     0.01990    4751       1.21      0.2277
           involvetr*stresseven    -0.00581     0.02508    4751      -0.23      0.8168
           adaptc*stressevent      -0.02111     0.02621    4751      -0.81      0.4206



;




**Positive only*;
PROC MIXED DATA=qq1_tot NOCLPRINT COVTEST MAXITER=100 METHOD=ML;
    CLASS id;
    MODEL naff =  incomec greenc    efficacyc unemployc percrentc involvetrustc  adaptc   positiveevent agec educ genderc

				
				 

				  incomec*positiveevent greenc*positiveevent unemployc*positiveevent percrentc*positiveevent
efficacyc*positiveevent  involvetrustc*positiveevent  adaptc*positiveevent
                  



                /SOLUTION DDFM=bw NOTEST CHISQ;
    RANDOM intercept  positiveevent / SUBJECT=id TYPE=UN;
RUN;

*  Iteration History

                   Iteration    Evaluations        -2 Log Like       Criterion

                           0              1      5934.77827423
                           1              2      2939.43153410      0.95638467
                           2              1      2842.75825801      2.55019061
                           3              1      2789.65157309      0.51164285
                           4              1      2785.62909425      0.09026986
                           5              2      2760.38914155      0.00585450
                           6              2      2751.51237179      0.00015698
                           7              1      2750.97116829      0.00000372
                           8              1      2750.95919735      0.00000000


                                   Convergence criteria met.



                                         The SAS System         08:50 Thursday, June 27, 2019  29

                                       The Mixed Procedure

                                 Covariance Parameter Estimates

                                                   Standard         Z
               Cov Parm     Subject    Estimate       Error     Value        Pr Z

               UN(1,1)      id           0.1380     0.01733      7.96      <.0001
               UN(2,1)      id         -0.02159    0.006986     -3.09      0.0020
               UN(2,2)      id         0.009923    0.004340      2.29      0.0111
               Residual                 0.08937    0.001857     48.12      <.0001


                                         Fit Statistics

                              -2 Log Likelihood              2751.0
                              AIC (Smaller is Better)        2797.0
                              AICC (Smaller is Better)       2797.2
                              BIC (Smaller is Better)        2871.2


                                Null Model Likelihood Ratio Test

                                  DF    Chi-Square      Pr > ChiSq

                                   3       3183.82          <.0001


                                   Solution for Fixed Effects

                                               Standard
           Effect                  Estimate       Error      DF    t Value    Pr > |t|

           Intercept                 1.2967     0.03096     174      41.88      <.0001
           incomec                   0.6276      0.4812     174       1.30      0.1939
           greenc                   -0.9500      0.4771     174      -1.99      0.0480
           efficacyc               -0.00276     0.04881     174      -0.06      0.9549
           Unemployc               0.001841    0.008811     174       0.21      0.8347
           Percrentc               -0.00141    0.001547     174      -0.91      0.3625
           involvetrustc           -0.07324     0.06087     174      -1.20      0.2305
           adaptc                   -0.1308     0.05830     174      -2.24      0.0261
           positiveevent           -0.04966     0.01728    4744      -2.87      0.0041
           agec                    -0.00295    0.003452     174      -0.86      0.3935
           educ                     0.01460     0.01431     174       1.02      0.3092
           genderc                   0.1053     0.05266     174       2.00      0.0471
           incomec*positiveeven     -0.4588      0.2799    4744      -1.64      0.1012
           greenc*positiveevent      0.4329      0.2498    4744       1.73      0.0833
           Unemployc*positiveev    0.000382    0.004733    4744       0.08      0.9357
           Percrentc*positiveev    0.000229    0.000853    4744       0.27      0.7887
           efficacyc*positiveev    0.005442     0.02583    4744       0.21      0.8332
           involvetr*positiveev     0.01253     0.03307    4744       0.38      0.7047
           adaptc*positiveevent    -0.00990     0.03101    4744      -0.32      0.7495




;













