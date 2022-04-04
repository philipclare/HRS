log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/scale indicator bivariate.smcl", replace

/**********************************************/
/* Syntax File 7                              */
/* Bivariate analysis - Scale >=6 Indicator   */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

mi estimate, cmdok esampvaryok dots: melogit f1scalelonely_ind c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) ///
(f0: _b[2.gender]) (f1: _b[2.gender] + 1*_b[wave] + 1*_b[2.gender#wave]) ///
(f2: _b[2.gender] + 2*_b[wave] + 2*_b[2.gender#wave]) (f3: _b[2.gender] + 3*_b[wave] + 3*_b[2.gender#wave]) ///
(f4: _b[2.gender] + 4*_b[wave] + 4*_b[2.gender#wave]) (f5: _b[2.gender] + 5*_b[wave] + 5*_b[2.gender#wave]) ///
(f6: _b[2.gender] + 6*_b[wave] + 6*_b[2.gender#wave]) (f7: _b[2.gender] + 7*_b[wave] + 7*_b[2.gender#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.gender#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind i.gender##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) ///
(b0: _b[1.ethnicity]) (b1: _b[1.ethnicity] + 1*_b[wave] + 1*_b[1.ethnicity#wave]) ///
(b2: _b[1.ethnicity] + 2*_b[wave] + 2*_b[1.ethnicity#wave]) (b3: _b[1.ethnicity] + 3*_b[wave] + 3*_b[1.ethnicity#wave]) ///
(b4: _b[1.ethnicity] + 4*_b[wave] + 4*_b[1.ethnicity#wave]) (b5: _b[1.ethnicity] + 5*_b[wave] + 5*_b[1.ethnicity#wave]) ///
(b6: _b[1.ethnicity] + 6*_b[wave] + 6*_b[1.ethnicity#wave]) (b7: _b[1.ethnicity] + 7*_b[wave] + 7*_b[1.ethnicity#wave]) ///
(h0: _b[2.ethnicity]) (h1: _b[2.ethnicity] + 1*_b[wave] + 1*_b[2.ethnicity#wave]) ///
(h2: _b[2.ethnicity] + 2*_b[wave] + 2*_b[2.ethnicity#wave]) (h3: _b[2.ethnicity] + 3*_b[wave] + 3*_b[2.ethnicity#wave]) ///
(h4: _b[2.ethnicity] + 4*_b[wave] + 4*_b[2.ethnicity#wave]) (h5: _b[2.ethnicity] + 5*_b[wave] + 5*_b[2.ethnicity#wave]) ///
(h6: _b[2.ethnicity] + 6*_b[wave] + 6*_b[2.ethnicity#wave]) (h7: _b[2.ethnicity] + 7*_b[wave] + 7*_b[2.ethnicity#wave]) ///
(o0: _b[3.ethnicity]) (o1: _b[3.ethnicity] + 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
(o2: _b[3.ethnicity] + 2*_b[wave] + 2*_b[3.ethnicity#wave]) (o3: _b[3.ethnicity] + 3*_b[wave] + 3*_b[3.ethnicity#wave]) ///
(o4: _b[3.ethnicity] + 4*_b[wave] + 4*_b[3.ethnicity#wave]) (o5: _b[3.ethnicity] + 5*_b[wave] + 5*_b[3.ethnicity#wave]) ///
(o6: _b[3.ethnicity] + 6*_b[wave] + 6*_b[3.ethnicity#wave]) (o7: _b[3.ethnicity] + 7*_b[wave] + 7*_b[3.ethnicity#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.ethnicity#wave]) (slope3: 1*_b[wave] + 1*_b[2.ethnicity#wave]) (slope4: 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind i.ethnicity##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) ///
(n0: _b[1.caucasian]) (n1: _b[1.caucasian] + 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
(n2: _b[1.caucasian] + 2*_b[wave] + 2*_b[1.caucasian#wave]) (n3: _b[1.caucasian] + 3*_b[wave] + 3*_b[1.caucasian#wave]) ///
(n4: _b[1.caucasian] + 4*_b[wave] + 4*_b[1.caucasian#wave]) (n5: _b[1.caucasian] + 5*_b[wave] + 5*_b[1.caucasian#wave]) ///
(n6: _b[1.caucasian] + 6*_b[wave] + 6*_b[1.caucasian#wave]) (n7: _b[1.caucasian] + 7*_b[wave] + 7*_b[1.caucasian#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind i.caucasian##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (bb1: 1*_b[wave]) (bb2: 2*_b[wave]) (bb3: 3*_b[wave]) (bb4: 4*_b[wave]) (bb5: 5*_b[wave]) ///
(bb6: 6*_b[wave]) (bb7: 7*_b[wave]) ///
(si0: _b[2.cohort]) (si1: _b[2.cohort] + 1*_b[wave] + 1*_b[2.cohort#wave]) ///
(si2: _b[2.cohort] + 2*_b[wave] + 2*_b[2.cohort#wave]) (si3: _b[2.cohort] + 3*_b[wave] + 3*_b[2.cohort#wave]) ///
(si4: _b[2.cohort] + 4*_b[wave] + 4*_b[2.cohort#wave]) (si5: _b[2.cohort] + 5*_b[wave] + 5*_b[2.cohort#wave]) ///
(si6: _b[2.cohort] + 6*_b[wave] + 6*_b[2.cohort#wave]) (si7: _b[2.cohort] + 7*_b[wave] + 7*_b[2.cohort#wave]) ///
(bb0: _b[1.cohort]) (gi1: _b[1.cohort] + 1*_b[wave] + 1*_b[1.cohort#wave]) ///
(gi2: _b[1.cohort] + 2*_b[wave] + 2*_b[1.cohort#wave]) (gi3: _b[1.cohort] + 3*_b[wave] + 3*_b[1.cohort#wave]) ///
(gi4: _b[1.cohort] + 4*_b[wave] + 4*_b[1.cohort#wave]) (gi5: _b[1.cohort] + 5*_b[wave] + 5*_b[1.cohort#wave]) ///
(gi6: _b[1.cohort] + 6*_b[wave] + 6*_b[1.cohort#wave]) (gi7: _b[1.cohort] + 7*_b[wave] + 7*_b[1.cohort#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.cohort#wave]) (slope3: 1*_b[wave] + 1*_b[1.cohort#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind ib3.cohort##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) ///
(sc0: _b[4.education]) (sc1: _b[4.education] + 1*_b[wave] + 1*_b[4.education#wave]) ///
(sc2: _b[4.education] + 2*_b[wave] + 2*_b[4.education#wave]) (sc3: _b[4.education] + 3*_b[wave] + 3*_b[4.education#wave]) ///
(sc4: _b[4.education] + 4*_b[wave] + 4*_b[4.education#wave]) (sc5: _b[4.education] + 5*_b[wave] + 5*_b[4.education#wave]) ///
(sc6: _b[4.education] + 6*_b[wave] + 6*_b[4.education#wave]) (sc7: _b[4.education] + 7*_b[wave] + 7*_b[4.education#wave]) ///
(hs0: _b[3.education]) (hs1: _b[3.education] + 1*_b[wave] + 1*_b[3.education#wave]) ///
(hs2: _b[3.education] + 2*_b[wave] + 2*_b[3.education#wave]) (hs3: _b[3.education] + 3*_b[wave] + 3*_b[3.education#wave]) ///
(hs4: _b[3.education] + 4*_b[wave] + 4*_b[3.education#wave]) (hs5: _b[3.education] + 5*_b[wave] + 5*_b[3.education#wave]) ///
(hs6: _b[3.education] + 6*_b[wave] + 6*_b[3.education#wave]) (hs7: _b[3.education] + 7*_b[wave] + 7*_b[3.education#wave]) ///
(lt0: _b[1.education]) (lt1: _b[1.education] + 1*_b[wave] + 1*_b[1.education#wave]) ///
(lt2: _b[1.education] + 2*_b[wave] + 2*_b[1.education#wave]) (lt3: _b[1.education] + 3*_b[wave] + 3*_b[1.education#wave]) ///
(lt4: _b[1.education] + 4*_b[wave] + 4*_b[1.education#wave]) (lt5: _b[1.education] + 5*_b[wave] + 5*_b[1.education#wave]) ///
(lt6: _b[1.education] + 6*_b[wave] + 6*_b[1.education#wave]) (lt7: _b[1.education] + 7*_b[wave] + 7*_b[1.education#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[4.education#wave]) (slope3: 1*_b[wave] + 1*_b[3.education#wave]) (slope4: 1*_b[wave] + 1*_b[1.education#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind ib5.education##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (e1: 1*_b[wave]) (e2: 2*_b[wave]) (e3: 3*_b[wave]) (e4: 4*_b[wave]) (e5: 5*_b[wave]) ///
(e6: 6*_b[wave]) (e7: 7*_b[wave]) ///
(r0: _b[1.employ]) (r1: _b[1.employ] + 1*_b[wave] + 1*_b[1.employ#wave]) ///
(r2: _b[1.employ] + 2*_b[wave] + 2*_b[1.employ#wave]) (r3: _b[1.employ] + 3*_b[wave] + 3*_b[1.employ#wave]) ///
(r4: _b[1.employ] + 4*_b[wave] + 4*_b[1.employ#wave]) (r5: _b[1.employ] + 5*_b[wave] + 5*_b[1.employ#wave]) ///
(r6: _b[1.employ] + 6*_b[wave] + 6*_b[1.employ#wave]) (r7: _b[1.employ] + 7*_b[wave] + 7*_b[1.employ#wave]) ///
(u0: _b[2.employ]) (u1: _b[2.employ] + 1*_b[wave] + 1*_b[2.employ#wave]) ///
(u2: _b[2.employ] + 2*_b[wave] + 2*_b[2.employ#wave]) (u3: _b[2.employ] + 3*_b[wave] + 3*_b[2.employ#wave]) ///
(u4: _b[2.employ] + 4*_b[wave] + 4*_b[2.employ#wave]) (u5: _b[2.employ] + 5*_b[wave] + 5*_b[2.employ#wave]) ///
(u6: _b[2.employ] + 6*_b[wave] + 6*_b[2.employ#wave]) (u7: _b[2.employ] + 7*_b[wave] + 7*_b[2.employ#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.employ#wave]) (slope3: 1*_b[wave] + 1*_b[2.employ#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind i.employ##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) ///
(n0: _b[1.marital]) (n1: _b[1.marital] + 1*_b[wave] + 1*_b[1.marital#wave]) ///
(n2: _b[1.marital] + 2*_b[wave] + 2*_b[1.marital#wave]) (n3: _b[1.marital] + 3*_b[wave] + 3*_b[1.marital#wave]) ///
(n4: _b[1.marital] + 4*_b[wave] + 4*_b[1.marital#wave]) (n5: _b[1.marital] + 5*_b[wave] + 5*_b[1.marital#wave]) ///
(n6: _b[1.marital] + 6*_b[wave] + 6*_b[1.marital#wave]) (n7: _b[1.marital] + 7*_b[wave] + 7*_b[1.marital#wave]) ///
(w0: _b[2.marital]) (w1: _b[2.marital] + 1*_b[wave] + 1*_b[2.marital#wave]) ///
(w2: _b[2.marital] + 2*_b[wave] + 2*_b[2.marital#wave]) (w3: _b[2.marital] + 3*_b[wave] + 3*_b[2.marital#wave]) ///
(w4: _b[2.marital] + 4*_b[wave] + 4*_b[2.marital#wave]) (w5: _b[2.marital] + 5*_b[wave] + 5*_b[2.marital#wave]) ///
(w6: _b[2.marital] + 6*_b[wave] + 6*_b[2.marital#wave]) (w7: _b[2.marital] + 7*_b[wave] + 7*_b[2.marital#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.marital#wave]) (slope3: 1*_b[wave] + 1*_b[2.marital#wave]) ///
, cmdok esampvaryok dots: melogit f1scalelonely_ind i.marital##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

log close