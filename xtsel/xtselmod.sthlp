{smcl}
{* First Version July 23 2020}{...}
{* This Version Nov 11 2022}{...}
{viewerdialog xtselmod "dialog xtselmod"}{...}
{vieweralsosee "[XT] xtselvar" "help xtselvar"}{...}
{vieweralsosee "[XT] xtoos_t" "help xtoos_t"}{...}
{vieweralsosee "[XT] xtoos_i" "help xtoos_i"}{...}
{vieweralsosee "[XT] xtoos_bin_t" "help xtoos_bin_t"}{...}
{vieweralsosee "[XT] xtoos_bin_i" "help xtoos_bin_i"}{...}
{vieweralsosee "tuples" "help tuples"}{...}

{hline}
Help for {hi:xtselmod}
{hline}

{title:Description}

{p}{cmd:xtselmod} helps us to select the best specification between all possible combinations of a defined set of explanatory variables. 
It is closely related to the command {cmd:xtselvar} and relies heavily on the command {cmd:tuples}. Given {it:n} possible explanatory variables, 
the procedure estimates {it:2^n - 1} different specifications, one per each possible combination. Then for each one of them, the procedure estimates 
a set of five statistical criteria (Adj. R2, AIC, BIC, U-Theil in time-series, U-Theil in a cross-individual dimension), ranks all specifications 
according to each criterion and generates one ranking per criterion. It also computes a composite ranking summarizing all five criteria.  
It finally sorts all specifications according to the selected ranking, which by default is the composite ranking. 

{p}{cmd:xtselmod} allows to choose weights for each one of the five criteria used to compute the composite ranking. It also allows to rank the specifications according to a specific criterion of preference. 
For instance, if the primary objective of the estimation is to obtain the most accurate prediction of the dependent variable, the user could choose to rank the specifications according only to their forecasting ability, 
i.e. according to the estimated U-Theil in its time-series dimension.{p_end}

{cmd:xtselmod} adjust the command {cmd:tuples} so that it allows time series operators like lags, leads and differences. Importantly, it also 
allows to choose and use the {opt conditionals()} option of the command {cmd:tuples}, using the same structure and syntax.

{p}The out-of-sample evaluation of each candidate specification performed by {cmd:xtselmod} is based on the commands {cmd:xtoos_t} and {cmd:xtoos_i} which need to be installed in Stata to be able to execute the procedure.{p_end}

{p}{cmd:xtselmod} allows to choose different estimation methods including some dynamic methodologies and could also be used in a dataset with only time-series observations.
In the case the specification includes lags of the dependent variable, the procedure is able to automatically generate dynamic forecasts for the out-of-sample evaluation performance.{p_end}

{p}In the case of the out-of-sample evaluation in a time-series dimension, {cmd:xtselmod} allows to choose a specific horizon {it:h} at which to evaluate the forecasting performance 
of the model including the candidate specification. It also allows to estimate the forecasting performance from horizon {it:t+1} until {it:t+h}.{p_end}

{p}{cmd:xtselmod} displays the results of the analysis in different ways. If the user chooses to display the results of each estimation for each specification
it could also create a log file that saves all the results. Otherwise the user can choose to execute the command quietly and then the procedure just displays a final summary 
through a table that shows all the five statistics estimated for each specification, the ranking of each specification according to each criterion, and the composite ranking. 

{p}The table of results is displayed ordered by the criterion selected by the user. The user can also choose to save the final results in an excel file. {p_end}

{title:Comparing particular specifications}

{p}{cmd:xtselmod} also allows to compare and rank up to 10 particular specifications.  This option could be useful when the user wants to compare some particular 
specifications that are difficult to handle through the option conditionals, for instance when they involve interactions betwen different variables 
or various lags of the same one. {p_end}

{p}This option does not make use of the command {cmd:tuples} and do not find a combination from a set of variables, it just directly compares and rank the literal specifications 
introduced by the user.{p_end}


{title:Use of PCA to construct composite control variables}

{p}{cmd:xtselmod} allows to generate a number of principal components (through PCA) for one or more groups of variables (topics) so that these components
can be used as fixed control variables in each regression in order to avoid or reduce the omitted variables problem.

{p}This option could be specially useful in the case that there is a too large number of possible control variables that cannot be included altogether in the regression.
Given that testing all possible combinations of all the variables might be unfeasible, it could be convenient, for instance, to group them 
into a smaller set of principal components that act as uncorrelated control variables.

{p}Similarly, it could also be useful to perform an initial selection of variables when all of the possible predictors could be classified within smaller groups of similar/related variables. 
In such case the user can create one or more components from each thematic group of variables. Then, one could be able to select the best combination of predictors from within each group, 
while using as control variables the components from the rest of groups.

{p}This strategy might help us to avoid the bias from omitting the control variables from all other groups different than the group in which the selection is being made.
The main components of each group are correlated with all the variables from each topic, and therefore, they are useful as a proxies for all of them, reducing the effect of their omission.{p_end}

{title:Proceedings USA Stata Conference 2020} 

https://www.stata.com/meeting/us20/slides/us20_Ugarte-Ruiz.pdf


{title:Syntax}

{p 4 8 2}Note: {cmd:xtselvar} requires package {cmd:xtoos} to be installed. See help {help xtoos} or click on {stata "ssc install xtoos"} to install.{p_end}
{p 4 8 2}Note: {cmd:xtselvar} requires package {cmd:matsort} to be installed. See help {help matsort} or click on {stata "ssc install matsort"} to install.{p_end}

{cmd:xtselmod} {depvar} [{indepvars}] [{it:if}] [{it:in}], {opt *ind:ate(string)} {opt *cd:ate(string)} {opt *k:smpl(integer)} 
	[{opt cond:itionals(string)}] [{opt fix:ed(varlist)}] [{opt m:et(string)}] [{opt mc:omp(string)}] [{opt ev:alopt(varname)}] 
	[{opt fe}] [{opt xbu}] [{opt dum}] [{opt opar}] [{opt lags(numlist)}] [{opt qui}] [{opt log(string)}] [{opt exc(string)}] [{opt she:et(string)}] 
	[{opt ord(string)}] [{opt down}] [{opt wei:ghts(numlist)}] [{opt hor(integer)}] [{opt uph:or}]  
	[{opt spec1(varlist)}] [{opt spec2(varlist)}] ... [{opt spec10(varlist)}]
	[{it:model_options}]


{synoptset}{...}
{marker Options}{...}
{synopthdr:Options}
{synoptline}
{synopt:{opt *ind:ate()}}It is always required. It specifies the last date (time-period) included in the estimation sample in the first step of the recursive procedure, 
i.e. it defines the date at which the performace evaluation starts. It allows Yearly, Quarterly and Monthly dates, or integer numbers, only. Quarterly and Monthly dates should be written as 1990q1 or 1990m1.{p_end}

{synopt:{opt *cd:ate()}}It is always required. It specifies the date at which the evaluation performance ends, i.e. the current date or the date at which the sample ends.  
It allows Yearly, Quarterly and Monthly dates, or integer numbers, only. Quarterly and Monthly dates should be written as 1990q1 or 1990m1.{p_end}

{synopt:{opt *k:smpl()}}It is always required. It specifies the size {it:k} of each partition or (non-random) subsample, i.e. the number of individuals 
in each partition that is excluded from each (in)sample estimation, and for which the out-of-sample prediction performance is evaluated in the cross-individuals dimension. 
The size {it:k} automatically determines the number of subsamples.{p_end}

{synopt:{opt cond:itionals()}}specifies conditional statements to eliminate possible tuples according to the rule(s) specified.  
conditionals() accepts thelogicals & for intersections or "and" statements, | for unions or "or" statements, 
() for binding statements and giving statements priority,and ! for complements or "not" statements. For further details, see help for command {cmd:tuples}.{p_end}

{synopt:{opt fix:ed()}}Specifies a list of variables that will remain fixed in the specification.{p_end}

{synopt:{opt m:et()}}Specifies the estimation method. The default is {cmd:xtreg} when using panel data and {cmd:reg} when using time-series data.{p_end}

{synopt:{opt mc:omp()}}Specifies the estimation method for the AR1 model used as a comparison and for estimating the U-Theil, when an AR1 is preferred to a "naive" prediction. 
The AR1 could be estimated by dynamic panel methods such as {cmd:xtabond} or {cmd:xtdpdsys}, or simply by {cmd:xtreg} or {cmd:reg}.{p_end}

{synopt:{opt ev:alopt()}}Specifies a particular individual or group of individuals for which the prediction performance is evaluated. 
The particular individual or group must be defined by a dummy variable equal to one for those individuals.{p_end}

{synopt:{opt fe}}Estimates using Fixed-Effects (within) estimator.{p_end}

{synopt:{opt xbu}}Specifies that the prediction including the fixed or random component should be used.{p_end}

{synopt:{opt dum}}Estimates including one dummy variable per individual in the specification and in the prediction.{p_end}

{synopt:{opt opar}}Specifies that the contribution of the dummy variables per individual should not be included in the prediction. 
It can only be used together with the option {opt dum}.{p_end}

{synopt:{opt lags()}}Specifies the number of lags of the dependent variable that must be included the specification, the default is zero lags.
This option should be used when using a dynamic panel methods such as {cmd:xtabond} or {cmd:xtdpdsys}.  If other estimation method is being used,
the command {cmd:xtoos_t} also allows to write down the desired lagged dependent variables terms simply as other explanatory variables. {p_end}

{synopt:{opt qui}}Specifies that the output of each regression should not be displayed and should be estimated quietly instead. 
When this option is activated only the final table with the summary of all the regression's outputs will be displayed.{p_end}

{synopt:{opt log()}}Specifies a name for a log file in which the output of every regression will be saved.{p_end}

{synopt:{opt exc()}}Specifies a name for an Excel file in which the final table with the summary of all the regression's outputs will be saved.  When this
option is activated a name for the sheet must also be provided.{p_end}

{synopt:{opt she:et()}}Specifies the name of the working sheet of Excel in which the final table with the summary of all the regression's outputs will be saved.  
This option is compulsory when the option {opt exc} is activated.{p_end}

{synopt:{opt ord()}}Specifies the statistical criterion according to which the summary of results must be ordered. The five criterion that are estimated are 
(in parenthesis the name that must be introduced in this option): Adjusted R-squared (R2_ad), 
Akaike (AIC), Bayesian Information Criteria (BIC), U-Theil in time-series dimension (Uth_TS) and U-Theil in cross-section dimension (Uth_CS).{p_end}

{synopt:{opt down}}Specifies if the results should be ordered descendingly. If this option is not activated the results will be ordered 
ascendingly according to the specified statistical criterion.{p_end}

{synopt:{opt wei:ghts()}}Specifies weights for each one of the five statistical criteria used to construct the final ranking. The specified weights 
must be numbers between zero and one, and the sum of the five weights must add up to one.{p_end}

{synopt:{opt h:or()}}Defines a specific forecasting horizon at which the out-of-sample exercise in its time-series dimension must be evaluated.{p_end}

{synopt:{opt uph:or}}Specifies that the evaluation of the model in its time-series dimension must be evaluated exactly between horizon {it:t+1} and 
the forecasting horizon specified in the option {opt h:or()}.{p_end}

{synopt:{opt spec#()}}Defines a particular specification to be evaluated and compared in specification number #. The procedures allows a maximum 
number of 10 particular specifications. Every specification should be written down using one separate option {opt spec#()} with its respective number, 
and it always has to start with spec1: spec1(x1 c.x1#c.x2 x3) spec2(c.x1#c.x2) spec3(x1 c.x1#c.x2 c.x2#c.x3) spec4(x1 x2 c.x3#c.x3) spec5(x1 x2 x3).{p_end}

{synopt:{opt gr:oups()}}Specifies the number of groups of variables for which a composite component will be generated. The procedures allows a maximum number of 10 groups.{p_end}

{synopt:{opt pca#()}}Specifies the variables that compose the group number #. The procedure allows a maximum number of 10 groups. 
If the option {opt groups} is set equal to five, then you must also write down five lists specifying the five different groups of variables, e.g.: pca1(var1 var2) pca2(var3 var4)
pca3(var5 var6) pca4(var7 var8) pca5(var9 var10).{p_end}

{synopt:{opt ncomp()}}Specifies the number of principal components that will be generated for each group of variables.
The default is one component per group, and the maximum number of components is equal to the number of variables inside each group.{p_end}


{synopt:{it:model_options}}Specifies any other estimation options specific to the method used and not defined elsewhere.{p_end}
{synoptline}

{marker Examples}{...}

{title:Example 1. Basics}

Use of {cmd:xtselmod} to classify the best specifications based on the set of variables x1, x2, x3, x4 and x5 (32 models). 

The dates at which the time-series out-of-sample evaluation starts and end must be specified ({opt ind:ate()} and {opt end:ate()}), 
the same as the number of individuals left-out at each partition in the cross-section out-of-sample evaluation (option {opt k:sample()}). 
(For further details, see help for command {cmd:xtoos}):

{p 4 8 2}{cmd:. sysuse panelexample, clear}{p_end}
{p 4 8 2}{cmd:. xtset id t}{p_end}
{p 4 8 2}{cmd:. xtselmod y x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100)}{p_end}
{p 4 8 2}{cmd:. xtselmod y x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100)} qui{p_end}

{title:Example 2. Fixed Control Variables}

If we want that a variable remains fixed in the specification, for instance variable x5, we should used the option {opt fix:ed()}: 

{p 4 8 2}{cmd:. xtselmod y x1 x2 x3 x4, indate(2015) cdate(2020) ksmpl(100) fixed(x5)}{p_end}

{title:Example 3. Restrictions on the combination of variables, option conditionals}

We can also keep variable x5 always fixed in the specification, using the option {opt cond:itionals()}. (For further details, see help for command {cmd:tuples}): 

{p 4 8 2}{cmd:. xtselmod y x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) conditionals(5)}{p_end}

{title:Example 4. More on conditionals}

The option {opt cond:itionals()} also allow to impose more complicated restrictions, such as variables x1 and x2 should always go together:

{p 4 8 2}{cmd:. xtselmod y x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) conditionals(!(1&!2) !(2&!1))}{p_end}

{title:Example 5. Saving results in a log file}

If we want to show each variable results and saving them in a log file named "results", we should use the option {opt log()}: 

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) log(results)}{p_end}

{title:Example 6. Saving results in an excel file}

If we do not want to show each variable results, and we want to save the final summary table in an excel file named "results" 
and the worksheet named "results1", we should use the options {opt qui} and {opt exc()} together with the option {opt she:et()}. 
Options {opt exc()} and {opt she:et()} must be used together:

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) qui exc(results) sheet(results1)}{p_end}

{title:Example 7. Changing weights of the total ranking}

If we want to give null weights to the criteria adjusted R2, AIC and BIC, and equal weights to the criteria U-Theils in time-series 
and cross-section dimensions, we should use the option {opt wei:ghts()}. The given weights should be between 0 and 1: 

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) wei(0 0 0 0.5 0.5) }{p_end}

{title:Example 8. Changing the ranking order}

If we want to order the final summary according to the R-squared in a descending order, we should use the options {opt ord()} and {opt down}:. 

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) ord(R2_ad) down}{p_end}

{title:Example 9. Defining a specific prediction horizon for the performance evaluation}

If we want to specify an exact horizon at which the time-series out-of-sample performance should be evaluated, we should use the option {opt hor()}:

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) hor(3)}{p_end}

{title:Example 10. Defining an interval for the horizon}

If instead of an exact horizon, we want to evaluate the time-series out-of-sample performance between horizons 1 and 3, we should used options 
{opt h:or()} and {opt uph:or} together. 

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) hor(3) uphor}{p_end}

{title:Example 11. Comparing particular specifications (user defined)}

If we want to compare, for instance, 3 particular specifications without combining them up, we should use options {opt spec1()} up to {opt spec3()}. 
If we would want to compare ten specifications, which is the maximum in this type of options, we should use options {opt spec1()} up to {opt spec10()}. 
Inside each one of the parenthesis we should write down each specification we want to try. 

{p 4 8 2}{cmd:. xtselmod y, indate(2015) cdate(2020) ksmpl(100) spec1(x1 c.x1#c.x2 x3) spec2(c.x1#c.x2 x2 x3) spec3(x1 c.x1#c.x2 c.x2#c.x3))}{p_end}

{p 4 8 2}{cmd:. xtselmod y, indate(2015) cdate(2020) ksmpl(100) spec1(x1 c.x1#c.x2 x3 x4) spec2(c.x1#c.x2 x2 x3 x4) spec3(x1 c.x1#c.x2 c.x2#c.x3 x4)}{p_end}

Alternatively, we can only write down the part of each specification that is different from the other ones, and include in the option {opt fix:ed()} 
the common parts of the specification that remains constant in all the cases, for instance:

{p 4 8 2}{cmd:. xtselmod y, indate(2015) cdate(2020) ksmpl(100) spec1(x1 c.x1#c.x2 x3) spec2(c.x1#c.x2 x2 x3) spec3(x1 c.x1#c.x2 c.x2#c.x3) fix(x4 x5)}{p_end}

{title:Example 12. Creating principal components as control variables from different sets of variables}

If we want to create three principal components from three group of variables with 20 variables each, e.g. groups z2 and z3: z2_1, z2_2...z2_20 
and z3_1, z3_2...z3_20, we should use the options {opt groups()} and options {opt pca1()}...{opt pca3()}.  

The option {opt groups()} defines how many groups of variables are and thus how many principal components should be estimated 
and included in the specification. The options {opt pca1()}... to {opt pca#groups()} should list the variables within each group.  

There should be as many lists as groups of variables.

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, indate(2015) cdate(2020) ksmpl(100) groups(3) pca1(z1*) pca2(z2*) pca3(z3*)}{p_end}

{title:Example 13. Creating principal components as control variables from one set of variables}

We can also generate various principal components from just one large group of variables, for instance if we do not have 
an a priori classifications of the predictors. 

In such case we can create, for example, 6 components from all possible variables, i.e all variables whose name starts with z, 
using also the option {opt ncomp()}. 

Additionally, we specify only one group in option {opt groups()} and list all variables z* in the option {opt pca1()}:

{p 4 8 2}{cmd:. xtselmod y x1 x1 x2 x3 x4 x5, ind(2015) cd(2020) o(100) k(100) r(0) qui groups(1) pca1(z*) ncomp(6)}{p_end}


{title:Author}

Alfonso Ugarte-Ruiz
alfonso.ugarte@bbva.com


{title:References}

. Joseph N. Luchman & Daniel Klein & Nicholas J. Cox, 2006. "TUPLES: Stata module for selecting all possible tuples from a list", 
Statistical Software Components S456797, Boston College Department of Economics, revised 17 May 2020.
. Alfonso Ugarte-Ruiz, 2019. "XTOOS: Stata module for evaluating the out-of-sample prediction performance of panel-data models," 
Statistical Software Components S458710, Boston College Department of Economics, revised 09 Jun 2020.
