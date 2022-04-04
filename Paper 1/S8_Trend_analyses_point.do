log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/point bivariate.smcl", replace

/**********************************************/
/* Syntax File 8                              */
/* Bivariate analysis - Point loneliness      */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

mi estimate, cmdok esampvaryok dots: melogit f1lonely c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) (m8: 8*_b[wave]) (m9: 9*_b[wave]) (m10: 10*_b[wave])  (m11: 11*_b[wave]) ///
(f0: _b[2.gender]) (f1: _b[2.gender] + 1*_b[wave] + 1*_b[2.gender#wave]) ///
(f2: _b[2.gender] + 2*_b[wave] + 2*_b[2.gender#wave]) (f3: _b[2.gender] + 3*_b[wave] + 3*_b[2.gender#wave]) ///
(f4: _b[2.gender] + 4*_b[wave] + 4*_b[2.gender#wave]) (f5: _b[2.gender] + 5*_b[wave] + 5*_b[2.gender#wave]) ///
(f6: _b[2.gender] + 6*_b[wave] + 6*_b[2.gender#wave]) (f7: _b[2.gender] + 7*_b[wave] + 7*_b[2.gender#wave]) ///
(f8: _b[2.gender] + 8*_b[wave] + 8*_b[2.gender#wave]) (f9: _b[2.gender] + 9*_b[wave] + 9*_b[2.gender#wave]) ///
(f10: _b[2.gender] + 10*_b[wave] + 10*_b[2.gender#wave]) (f11: _b[2.gender] + 11*_b[wave] + 11*_b[2.gender#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.gender#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely i.gender##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) (c10: 10*_b[wave]) (c11: 11*_b[wave]) ///
(b0: _b[1.ethnicity]) (b1: _b[1.ethnicity] + 1*_b[wave] + 1*_b[1.ethnicity#wave]) ///
(b2: _b[1.ethnicity] + 2*_b[wave] + 2*_b[1.ethnicity#wave]) (b3: _b[1.ethnicity] + 3*_b[wave] + 3*_b[1.ethnicity#wave]) ///
(b4: _b[1.ethnicity] + 4*_b[wave] + 4*_b[1.ethnicity#wave]) (b5: _b[1.ethnicity] + 5*_b[wave] + 5*_b[1.ethnicity#wave]) ///
(b6: _b[1.ethnicity] + 6*_b[wave] + 6*_b[1.ethnicity#wave]) (b7: _b[1.ethnicity] + 7*_b[wave] + 7*_b[1.ethnicity#wave]) ///
(b8: _b[1.ethnicity] + 8*_b[wave] + 8*_b[1.ethnicity#wave]) (b9: _b[1.ethnicity] + 9*_b[wave] + 9*_b[1.ethnicity#wave]) ///
(b10: _b[1.ethnicity] + 10*_b[wave] + 10*_b[1.ethnicity#wave]) (b11: _b[1.ethnicity] + 11*_b[wave] + 11*_b[1.ethnicity#wave]) ///
(h0: _b[2.ethnicity]) (h1: _b[2.ethnicity] + 1*_b[wave] + 1*_b[2.ethnicity#wave]) ///
(h2: _b[2.ethnicity] + 2*_b[wave] + 2*_b[2.ethnicity#wave]) (h3: _b[2.ethnicity] + 3*_b[wave] + 3*_b[2.ethnicity#wave]) ///
(h4: _b[2.ethnicity] + 4*_b[wave] + 4*_b[2.ethnicity#wave]) (h5: _b[2.ethnicity] + 5*_b[wave] + 5*_b[2.ethnicity#wave]) ///
(h6: _b[2.ethnicity] + 6*_b[wave] + 6*_b[2.ethnicity#wave]) (h7: _b[2.ethnicity] + 7*_b[wave] + 7*_b[2.ethnicity#wave]) ///
(h8: _b[2.ethnicity] + 8*_b[wave] + 8*_b[2.ethnicity#wave]) (h9: _b[2.ethnicity] + 9*_b[wave] + 9*_b[2.ethnicity#wave]) /// 
(h10: _b[2.ethnicity] + 10*_b[wave] + 10*_b[2.ethnicity#wave]) (h11: _b[2.ethnicity] + 11*_b[wave] + 11*_b[2.ethnicity#wave]) /// 
(o0: _b[3.ethnicity]) (o1: _b[3.ethnicity] + 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
(o2: _b[3.ethnicity] + 2*_b[wave] + 2*_b[3.ethnicity#wave]) (o3: _b[3.ethnicity] + 3*_b[wave] + 3*_b[3.ethnicity#wave]) ///
(o4: _b[3.ethnicity] + 4*_b[wave] + 4*_b[3.ethnicity#wave]) (o5: _b[3.ethnicity] + 5*_b[wave] + 5*_b[3.ethnicity#wave]) ///
(o6: _b[3.ethnicity] + 6*_b[wave] + 6*_b[3.ethnicity#wave]) (o7: _b[3.ethnicity] + 7*_b[wave] + 7*_b[3.ethnicity#wave]) ///
(o8: _b[3.ethnicity] + 8*_b[wave] + 8*_b[3.ethnicity#wave]) (o9: _b[3.ethnicity] + 9*_b[wave] + 9*_b[3.ethnicity#wave]) ///
(o10: _b[3.ethnicity] + 10*_b[wave] + 10*_b[3.ethnicity#wave]) (o11: _b[3.ethnicity] + 11*_b[wave] + 11*_b[3.ethnicity#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.ethnicity#wave]) (slope3: 1*_b[wave] + 1*_b[2.ethnicity#wave]) (slope4: 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely i.ethnicity##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) (c10: 10*_b[wave]) (c11: 11*_b[wave]) ///
(n0: _b[1.caucasian]) (n1: _b[1.caucasian] + 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
(n2: _b[1.caucasian] + 2*_b[wave] + 2*_b[1.caucasian#wave]) (n3: _b[1.caucasian] + 3*_b[wave] + 3*_b[1.caucasian#wave]) ///
(n4: _b[1.caucasian] + 4*_b[wave] + 4*_b[1.caucasian#wave]) (n5: _b[1.caucasian] + 5*_b[wave] + 5*_b[1.caucasian#wave]) ///
(n6: _b[1.caucasian] + 6*_b[wave] + 6*_b[1.caucasian#wave]) (n7: _b[1.caucasian] + 7*_b[wave] + 7*_b[1.caucasian#wave]) ///
(n8: _b[1.caucasian] + 8*_b[wave] + 8*_b[1.caucasian#wave]) (n9: _b[1.caucasian] + 9*_b[wave] + 9*_b[1.caucasian#wave]) ///
(n10: _b[1.caucasian] + 10*_b[wave] + 10*_b[1.caucasian#wave]) (n11: _b[1.caucasian] + 11*_b[wave] + 11*_b[1.caucasian#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely i.caucasian##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (bb1: 1*_b[wave]) (bb2: 2*_b[wave]) (bb3: 3*_b[wave]) (bb4: 4*_b[wave]) (bb5: 5*_b[wave]) ///
(bb6: 6*_b[wave]) (bb7: 7*_b[wave]) (bb8: 8*_b[wave]) (bb9: 9*_b[wave]) (bb10: 10*_b[wave]) (bb11: 11*_b[wave]) ///
(si0: _b[2.cohort]) (si1: _b[2.cohort] + 1*_b[wave] + 1*_b[2.cohort#wave]) ///
(si2: _b[2.cohort] + 2*_b[wave] + 2*_b[2.cohort#wave]) (si3: _b[2.cohort] + 3*_b[wave] + 3*_b[2.cohort#wave]) ///
(si4: _b[2.cohort] + 4*_b[wave] + 4*_b[2.cohort#wave]) (si5: _b[2.cohort] + 5*_b[wave] + 5*_b[2.cohort#wave]) ///
(si6: _b[2.cohort] + 6*_b[wave] + 6*_b[2.cohort#wave]) (si7: _b[2.cohort] + 7*_b[wave] + 7*_b[2.cohort#wave]) ///
(si8: _b[2.cohort] + 8*_b[wave] + 8*_b[2.cohort#wave]) (si9: _b[2.cohort] + 9*_b[wave] + 9*_b[2.cohort#wave]) ///
(si10: _b[2.cohort] + 10*_b[wave] + 10*_b[2.cohort#wave]) (si11: _b[2.cohort] + 11*_b[wave] + 11*_b[2.cohort#wave]) ///
(gi0: _b[1.cohort]) (gi1: _b[1.cohort] + 1*_b[wave] + 1*_b[1.cohort#wave]) ///
(gi2: _b[1.cohort] + 2*_b[wave] + 2*_b[1.cohort#wave]) (gi3: _b[1.cohort] + 3*_b[wave] + 3*_b[1.cohort#wave]) ///
(gi4: _b[1.cohort] + 4*_b[wave] + 4*_b[1.cohort#wave]) (gi5: _b[1.cohort] + 5*_b[wave] + 5*_b[1.cohort#wave]) ///
(gi6: _b[1.cohort] + 6*_b[wave] + 6*_b[1.cohort#wave]) (gi7: _b[1.cohort] + 7*_b[wave] + 7*_b[1.cohort#wave]) ///
(gi8: _b[1.cohort] + 8*_b[wave] + 8*_b[1.cohort#wave]) (gi9: _b[1.cohort] + 9*_b[wave] + 9*_b[1.cohort#wave]) ///
(gi10: _b[1.cohort] + 10*_b[wave] + 10*_b[1.cohort#wave]) (gi11: _b[1.cohort] + 11*_b[wave] + 11*_b[1.cohort#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.cohort#wave]) (slope3: 1*_b[wave] + 1*_b[1.cohort#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely ib3.cohort##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) (c10: 10*_b[wave]) (c11: 11*_b[wave]) ///
(sc0: _b[4.education]) (sc1: _b[4.education] + 1*_b[wave] + 1*_b[4.education#wave]) ///
(sc2: _b[4.education] + 2*_b[wave] + 2*_b[4.education#wave]) (sc3: _b[4.education] + 3*_b[wave] + 3*_b[4.education#wave]) ///
(sc4: _b[4.education] + 4*_b[wave] + 4*_b[4.education#wave]) (sc5: _b[4.education] + 5*_b[wave] + 5*_b[4.education#wave]) ///
(sc6: _b[4.education] + 6*_b[wave] + 6*_b[4.education#wave]) (sc7: _b[4.education] + 7*_b[wave] + 7*_b[4.education#wave]) ///
(sc8: _b[4.education] + 8*_b[wave] + 8*_b[4.education#wave]) (sc9: _b[4.education] + 9*_b[wave] + 9*_b[4.education#wave]) ///
(sc10: _b[4.education] + 10*_b[wave] + 10*_b[4.education#wave]) (sc11: _b[4.education] + 11*_b[wave] + 11*_b[4.education#wave]) ///
(hs0: _b[3.education]) (hs1: _b[3.education] + 1*_b[wave] + 1*_b[3.education#wave]) ///
(hs2: _b[3.education] + 2*_b[wave] + 2*_b[3.education#wave]) (hs3: _b[3.education] + 3*_b[wave] + 3*_b[3.education#wave]) ///
(hs4: _b[3.education] + 4*_b[wave] + 4*_b[3.education#wave]) (hs5: _b[3.education] + 5*_b[wave] + 5*_b[3.education#wave]) ///
(hs6: _b[3.education] + 6*_b[wave] + 6*_b[3.education#wave]) (hs7: _b[3.education] + 7*_b[wave] + 7*_b[3.education#wave]) ///
(hs8: _b[3.education] + 8*_b[wave] + 8*_b[3.education#wave]) (hs9: _b[3.education] + 9*_b[wave] + 9*_b[3.education#wave]) ///
(hs10: _b[3.education] + 10*_b[wave] + 10*_b[3.education#wave]) (hs11: _b[3.education] + 11*_b[wave] + 11*_b[3.education#wave]) ///
(lt0: _b[1.education]) (lt1: _b[1.education] + 1*_b[wave] + 1*_b[1.education#wave]) ///
(lt2: _b[1.education] + 2*_b[wave] + 2*_b[1.education#wave]) (lt3: _b[1.education] + 3*_b[wave] + 3*_b[1.education#wave]) ///
(lt4: _b[1.education] + 4*_b[wave] + 4*_b[1.education#wave]) (lt5: _b[1.education] + 5*_b[wave] + 5*_b[1.education#wave]) ///
(lt6: _b[1.education] + 6*_b[wave] + 6*_b[1.education#wave]) (lt7: _b[1.education] + 7*_b[wave] + 7*_b[1.education#wave]) ///
(lt8: _b[1.education] + 8*_b[wave] + 8*_b[1.education#wave]) (lt9: _b[1.education] + 9*_b[wave] + 9*_b[1.education#wave]) ///
(lt10: _b[1.education] + 10*_b[wave] + 10*_b[1.education#wave]) (lt11: _b[1.education] + 11*_b[wave] + 11*_b[1.education#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[4.education#wave]) (slope3: 1*_b[wave] + 1*_b[3.education#wave]) (slope4: 1*_b[wave] + 1*_b[1.education#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely ib5.education##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (e1: 1*_b[wave]) (e2: 2*_b[wave]) (e3: 3*_b[wave]) (e4: 4*_b[wave]) (e5: 5*_b[wave]) ///
(e6: 6*_b[wave]) (e7: 7*_b[wave]) (e8: 8*_b[wave]) (e9: 9*_b[wave]) (e10: 10*_b[wave]) (e11: 11*_b[wave]) ///
(r0: _b[1.employ]) (r1: _b[1.employ] + 1*_b[wave] + 1*_b[1.employ#wave]) ///
(r2: _b[1.employ] + 2*_b[wave] + 2*_b[1.employ#wave]) (r3: _b[1.employ] + 3*_b[wave] + 3*_b[1.employ#wave]) ///
(r4: _b[1.employ] + 4*_b[wave] + 4*_b[1.employ#wave]) (r5: _b[1.employ] + 5*_b[wave] + 5*_b[1.employ#wave]) ///
(r6: _b[1.employ] + 6*_b[wave] + 6*_b[1.employ#wave]) (r7: _b[1.employ] + 7*_b[wave] + 7*_b[1.employ#wave]) ///
(r8: _b[1.employ] + 8*_b[wave] + 8*_b[1.employ#wave]) (r9: _b[1.employ] + 9*_b[wave] + 9*_b[1.employ#wave]) ///
(r10: _b[1.employ] + 10*_b[wave] + 10*_b[1.employ#wave]) (r11: _b[1.employ] + 11*_b[wave] + 11*_b[1.employ#wave]) ///
(u0: _b[2.employ]) (u1: _b[2.employ] + 1*_b[wave] + 1*_b[2.employ#wave]) ///
(u2: _b[2.employ] + 2*_b[wave] + 2*_b[2.employ#wave]) (u3: _b[2.employ] + 3*_b[wave] + 3*_b[2.employ#wave]) ///
(u4: _b[2.employ] + 4*_b[wave] + 4*_b[2.employ#wave]) (u5: _b[2.employ] + 5*_b[wave] + 5*_b[2.employ#wave]) ///
(u6: _b[2.employ] + 6*_b[wave] + 6*_b[2.employ#wave]) (u7: _b[2.employ] + 7*_b[wave] + 7*_b[2.employ#wave]) ///
(u8: _b[2.employ] + 8*_b[wave] + 8*_b[2.employ#wave]) (u9: _b[2.employ] + 9*_b[wave] + 9*_b[2.employ#wave]) ///
(u10: _b[2.employ] + 10*_b[wave] + 10*_b[2.employ#wave]) (u11: _b[2.employ] + 11*_b[wave] + 11*_b[2.employ#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.employ#wave]) (slope3: 1*_b[wave] + 1*_b[2.employ#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely i.employ##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) (m8: 8*_b[wave]) (m9: 9*_b[wave]) (m10: 10*_b[wave]) (m11: 11*_b[wave]) ///
(n0: _b[1.marital]) (n1: _b[1.marital] + 1*_b[wave] + 1*_b[1.marital#wave]) ///
(n2: _b[1.marital] + 2*_b[wave] + 2*_b[1.marital#wave]) (n3: _b[1.marital] + 3*_b[wave] + 3*_b[1.marital#wave]) ///
(n4: _b[1.marital] + 4*_b[wave] + 4*_b[1.marital#wave]) (n5: _b[1.marital] + 5*_b[wave] + 5*_b[1.marital#wave]) ///
(n6: _b[1.marital] + 6*_b[wave] + 6*_b[1.marital#wave]) (n7: _b[1.marital] + 7*_b[wave] + 7*_b[1.marital#wave]) ///
(n8: _b[1.marital] + 8*_b[wave] + 8*_b[1.marital#wave]) (n9: _b[1.marital] + 9*_b[wave] + 9*_b[1.marital#wave]) ///
(n10: _b[1.marital] + 10*_b[wave] + 10*_b[1.marital#wave]) (n11: _b[1.marital] + 11*_b[wave] + 11*_b[1.marital#wave]) ///
(w0: _b[2.marital]) (w1: _b[2.marital] + 1*_b[wave] + 1*_b[2.marital#wave]) ///
(w2: _b[2.marital] + 2*_b[wave] + 2*_b[2.marital#wave]) (w3: _b[2.marital] + 3*_b[wave] + 3*_b[2.marital#wave]) ///
(w4: _b[2.marital] + 4*_b[wave] + 4*_b[2.marital#wave]) (w5: _b[2.marital] + 5*_b[wave] + 5*_b[2.marital#wave]) ///
(w6: _b[2.marital] + 6*_b[wave] + 6*_b[2.marital#wave]) (w7: _b[2.marital] + 7*_b[wave] + 7*_b[2.marital#wave]) ///
(w8: _b[2.marital] + 8*_b[wave] + 8*_b[2.marital#wave]) (w9: _b[2.marital] + 9*_b[wave] + 9*_b[2.marital#wave]) ///
(w10: _b[2.marital] + 10*_b[wave] + 10*_b[2.marital#wave]) (w11: _b[2.marital] + 11*_b[wave] + 11*_b[2.marital#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.marital#wave]) (slope3: 1*_b[wave] + 1*_b[2.marital#wave]) ///
, cmdok esampvaryok dots: melogit f1lonely i.marital##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)

log close

