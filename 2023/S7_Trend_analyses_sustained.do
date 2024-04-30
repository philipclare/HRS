log using "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Results/sustained bivariate timing.smcl", replace

/**********************************************/
/* Syntax File 7                              */
/* Bivariate analysis - Sustained loneliness  */
/**********************************************/

use "/Users/pjclare/Dropbox (Sydney Uni)/HRS/Data/HRS Imputed data/final imputed data.dta", clear

replace wave=wave-2

timer on 1
mi estimate, cmdok esampvaryok dots saving(testfile1, replace) esample(esample1): melogit suslonely c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns using testfile1, at(wave=(0/9)) esample(esample1) predict(mu)
timer off 1

timer on 2
mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) (m8: 8*_b[wave]) (m9: 9*_b[wave]) ///
(f0: _b[2.gender]) (f1: _b[2.gender] + 1*_b[wave] + 1*_b[2.gender#wave]) ///
(f2: _b[2.gender] + 2*_b[wave] + 2*_b[2.gender#wave]) (f3: _b[2.gender] + 3*_b[wave] + 3*_b[2.gender#wave]) ///
(f4: _b[2.gender] + 4*_b[wave] + 4*_b[2.gender#wave]) (f5: _b[2.gender] + 5*_b[wave] + 5*_b[2.gender#wave]) ///
(f6: _b[2.gender] + 6*_b[wave] + 6*_b[2.gender#wave]) (f7: _b[2.gender] + 7*_b[wave] + 7*_b[2.gender#wave]) ///
(f8: _b[2.gender] + 8*_b[wave] + 8*_b[2.gender#wave]) (f9: _b[2.gender] + 9*_b[wave] + 9*_b[2.gender#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.gender#wave]) ///
, saving(testfile2, replace) esample(esample2) cmdok esampvaryok dots: melogit suslonely i.gender##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.gender using testfile2, at(wave=(0/9)) esample(esample2) predict(mu)
timer off 2

timer on 3
mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) ///
(b0: _b[1.ethnicity]) (b1: _b[1.ethnicity] + 1*_b[wave] + 1*_b[1.ethnicity#wave]) ///
(b2: _b[1.ethnicity] + 2*_b[wave] + 2*_b[1.ethnicity#wave]) (b3: _b[1.ethnicity] + 3*_b[wave] + 3*_b[1.ethnicity#wave]) ///
(b4: _b[1.ethnicity] + 4*_b[wave] + 4*_b[1.ethnicity#wave]) (b5: _b[1.ethnicity] + 5*_b[wave] + 5*_b[1.ethnicity#wave]) ///
(b6: _b[1.ethnicity] + 6*_b[wave] + 6*_b[1.ethnicity#wave]) (b7: _b[1.ethnicity] + 7*_b[wave] + 7*_b[1.ethnicity#wave]) ///
(b8: _b[1.ethnicity] + 8*_b[wave] + 8*_b[1.ethnicity#wave]) (b9: _b[1.ethnicity] + 9*_b[wave] + 9*_b[1.ethnicity#wave]) ///
(h0: _b[2.ethnicity]) (h1: _b[2.ethnicity] + 1*_b[wave] + 1*_b[2.ethnicity#wave]) ///
(h2: _b[2.ethnicity] + 2*_b[wave] + 2*_b[2.ethnicity#wave]) (h3: _b[2.ethnicity] + 3*_b[wave] + 3*_b[2.ethnicity#wave]) ///
(h4: _b[2.ethnicity] + 4*_b[wave] + 4*_b[2.ethnicity#wave]) (h5: _b[2.ethnicity] + 5*_b[wave] + 5*_b[2.ethnicity#wave]) ///
(h6: _b[2.ethnicity] + 6*_b[wave] + 6*_b[2.ethnicity#wave]) (h7: _b[2.ethnicity] + 7*_b[wave] + 7*_b[2.ethnicity#wave]) ///
(h8: _b[2.ethnicity] + 8*_b[wave] + 8*_b[2.ethnicity#wave]) (h9: _b[2.ethnicity] + 9*_b[wave] + 9*_b[2.ethnicity#wave]) /// 
(o0: _b[3.ethnicity]) (o1: _b[3.ethnicity] + 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
(o2: _b[3.ethnicity] + 2*_b[wave] + 2*_b[3.ethnicity#wave]) (o3: _b[3.ethnicity] + 3*_b[wave] + 3*_b[3.ethnicity#wave]) ///
(o4: _b[3.ethnicity] + 4*_b[wave] + 4*_b[3.ethnicity#wave]) (o5: _b[3.ethnicity] + 5*_b[wave] + 5*_b[3.ethnicity#wave]) ///
(o6: _b[3.ethnicity] + 6*_b[wave] + 6*_b[3.ethnicity#wave]) (o7: _b[3.ethnicity] + 7*_b[wave] + 7*_b[3.ethnicity#wave]) ///
(o8: _b[3.ethnicity] + 8*_b[wave] + 8*_b[3.ethnicity#wave]) (o9: _b[3.ethnicity] + 9*_b[wave] + 9*_b[3.ethnicity#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.ethnicity#wave]) (slope3: 1*_b[wave] + 1*_b[2.ethnicity#wave]) (slope4: 1*_b[wave] + 1*_b[3.ethnicity#wave]) ///
, saving(testfile3, replace) esample(esample3) cmdok esampvaryok dots: melogit suslonely i.ethnicity##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.ethnicity using testfile3, at(wave=(0/9)) esample(esample3) predict(mu)
timer off 3

timer on 4
mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) ///
(n0: _b[1.caucasian]) (n1: _b[1.caucasian] + 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
(n2: _b[1.caucasian] + 2*_b[wave] + 2*_b[1.caucasian#wave]) (n3: _b[1.caucasian] + 3*_b[wave] + 3*_b[1.caucasian#wave]) ///
(n4: _b[1.caucasian] + 4*_b[wave] + 4*_b[1.caucasian#wave]) (n5: _b[1.caucasian] + 5*_b[wave] + 5*_b[1.caucasian#wave]) ///
(n6: _b[1.caucasian] + 6*_b[wave] + 6*_b[1.caucasian#wave]) (n7: _b[1.caucasian] + 7*_b[wave] + 7*_b[1.caucasian#wave]) ///
(n8: _b[1.caucasian] + 8*_b[wave] + 8*_b[1.caucasian#wave]) (n9: _b[1.caucasian] + 9*_b[wave] + 9*_b[1.caucasian#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.caucasian#wave]) ///
, saving(testfile4, replace) esample(esample4) cmdok esampvaryok dots: melogit suslonely i.caucasian##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.caucasian using testfile4, at(wave=(0/9)) esample(esample4) predict(mu)
timer off 4

timer on 5
mi estimate (bb1: 1*_b[wave]) (bb2: 2*_b[wave]) (bb3: 3*_b[wave]) (bb4: 4*_b[wave]) (bb5: 5*_b[wave]) ///
(bb6: 6*_b[wave]) (bb7: 7*_b[wave]) (bb8: 8*_b[wave]) (bb9: 9*_b[wave]) ///
(si0: _b[2.cohort]) (si1: _b[2.cohort] + 1*_b[wave] + 1*_b[2.cohort#wave]) ///
(si2: _b[2.cohort] + 2*_b[wave] + 2*_b[2.cohort#wave]) (si3: _b[2.cohort] + 3*_b[wave] + 3*_b[2.cohort#wave]) ///
(si4: _b[2.cohort] + 4*_b[wave] + 4*_b[2.cohort#wave]) (si5: _b[2.cohort] + 5*_b[wave] + 5*_b[2.cohort#wave]) ///
(si6: _b[2.cohort] + 6*_b[wave] + 6*_b[2.cohort#wave]) (si7: _b[2.cohort] + 7*_b[wave] + 7*_b[2.cohort#wave]) ///
(si8: _b[2.cohort] + 8*_b[wave] + 8*_b[2.cohort#wave]) (si9: _b[2.cohort] + 9*_b[wave] + 9*_b[2.cohort#wave]) ///
(bb0: _b[1.cohort]) (gi1: _b[1.cohort] + 1*_b[wave] + 1*_b[1.cohort#wave]) ///
(gi2: _b[1.cohort] + 2*_b[wave] + 2*_b[1.cohort#wave]) (gi3: _b[1.cohort] + 3*_b[wave] + 3*_b[1.cohort#wave]) ///
(gi4: _b[1.cohort] + 4*_b[wave] + 4*_b[1.cohort#wave]) (gi5: _b[1.cohort] + 5*_b[wave] + 5*_b[1.cohort#wave]) ///
(gi6: _b[1.cohort] + 6*_b[wave] + 6*_b[1.cohort#wave]) (gi7: _b[1.cohort] + 7*_b[wave] + 7*_b[1.cohort#wave]) ///
(gi8: _b[1.cohort] + 8*_b[wave] + 8*_b[1.cohort#wave]) (gi9: _b[1.cohort] + 9*_b[wave] + 9*_b[1.cohort#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[2.cohort#wave]) (slope3: 1*_b[wave] + 1*_b[1.cohort#wave]) ///
, saving(testfile5, replace) esample(esample5) cmdok esampvaryok dots: melogit suslonely ib3.cohort##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.cohort using testfile5, at(wave=(0/9)) esample(esample5) predict(mu)
timer off 5

timer on 6
mi estimate (c1: 1*_b[wave]) (c2: 2*_b[wave]) (c3: 3*_b[wave]) (c4: 4*_b[wave]) (c5: 5*_b[wave]) ///
(c6: 6*_b[wave]) (c7: 7*_b[wave]) (c8: 8*_b[wave]) (c9: 9*_b[wave]) ///
(sc0: _b[4.education]) (sc1: _b[4.education] + 1*_b[wave] + 1*_b[4.education#wave]) ///
(sc2: _b[4.education] + 2*_b[wave] + 2*_b[4.education#wave]) (sc3: _b[4.education] + 3*_b[wave] + 3*_b[4.education#wave]) ///
(sc4: _b[4.education] + 4*_b[wave] + 4*_b[4.education#wave]) (sc5: _b[4.education] + 5*_b[wave] + 5*_b[4.education#wave]) ///
(sc6: _b[4.education] + 6*_b[wave] + 6*_b[4.education#wave]) (sc7: _b[4.education] + 7*_b[wave] + 7*_b[4.education#wave]) ///
(sc8: _b[4.education] + 8*_b[wave] + 8*_b[4.education#wave]) (sc9: _b[4.education] + 9*_b[wave] + 9*_b[4.education#wave]) ///
(hs0: _b[3.education]) (hs1: _b[3.education] + 1*_b[wave] + 1*_b[3.education#wave]) ///
(hs2: _b[3.education] + 2*_b[wave] + 2*_b[3.education#wave]) (hs3: _b[3.education] + 3*_b[wave] + 3*_b[3.education#wave]) ///
(hs4: _b[3.education] + 4*_b[wave] + 4*_b[3.education#wave]) (hs5: _b[3.education] + 5*_b[wave] + 5*_b[3.education#wave]) ///
(hs6: _b[3.education] + 6*_b[wave] + 6*_b[3.education#wave]) (hs7: _b[3.education] + 7*_b[wave] + 7*_b[3.education#wave]) ///
(hs8: _b[3.education] + 8*_b[wave] + 8*_b[3.education#wave]) (hs9: _b[3.education] + 9*_b[wave] + 9*_b[3.education#wave]) ///
(lt0: _b[1.education]) (lt1: _b[1.education] + 1*_b[wave] + 1*_b[1.education#wave]) ///
(lt2: _b[1.education] + 2*_b[wave] + 2*_b[1.education#wave]) (lt3: _b[1.education] + 3*_b[wave] + 3*_b[1.education#wave]) ///
(lt4: _b[1.education] + 4*_b[wave] + 4*_b[1.education#wave]) (lt5: _b[1.education] + 5*_b[wave] + 5*_b[1.education#wave]) ///
(lt6: _b[1.education] + 6*_b[wave] + 6*_b[1.education#wave]) (lt7: _b[1.education] + 7*_b[wave] + 7*_b[1.education#wave]) ///
(lt8: _b[1.education] + 8*_b[wave] + 8*_b[1.education#wave]) (lt9: _b[1.education] + 9*_b[wave] + 9*_b[1.education#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[4.education#wave]) (slope3: 1*_b[wave] + 1*_b[3.education#wave]) (slope4: 1*_b[wave] + 1*_b[1.education#wave]) ///
, saving(testfile6, replace) esample(esample6) cmdok esampvaryok dots: melogit suslonely ib5.education##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.education using testfile6, at(wave=(0/9)) esample(esample6) predict(mu)
timer off 6

timer on 7
mi estimate (e1: 1*_b[wave]) (e2: 2*_b[wave]) (e3: 3*_b[wave]) (e4: 4*_b[wave]) (e5: 5*_b[wave]) ///
(e6: 6*_b[wave]) (e7: 7*_b[wave]) (e8: 8*_b[wave]) (e9: 9*_b[wave]) ///
(r0: _b[1.employ]) (r1: _b[1.employ] + 1*_b[wave] + 1*_b[1.employ#wave]) ///
(r2: _b[1.employ] + 2*_b[wave] + 2*_b[1.employ#wave]) (r3: _b[1.employ] + 3*_b[wave] + 3*_b[1.employ#wave]) ///
(r4: _b[1.employ] + 4*_b[wave] + 4*_b[1.employ#wave]) (r5: _b[1.employ] + 5*_b[wave] + 5*_b[1.employ#wave]) ///
(r6: _b[1.employ] + 6*_b[wave] + 6*_b[1.employ#wave]) (r7: _b[1.employ] + 7*_b[wave] + 7*_b[1.employ#wave]) ///
(r8: _b[1.employ] + 8*_b[wave] + 8*_b[1.employ#wave]) (r9: _b[1.employ] + 9*_b[wave] + 9*_b[1.employ#wave]) ///
(u0: _b[2.employ]) (u1: _b[2.employ] + 1*_b[wave] + 1*_b[2.employ#wave]) ///
(u2: _b[2.employ] + 2*_b[wave] + 2*_b[2.employ#wave]) (u3: _b[2.employ] + 3*_b[wave] + 3*_b[2.employ#wave]) ///
(u4: _b[2.employ] + 4*_b[wave] + 4*_b[2.employ#wave]) (u5: _b[2.employ] + 5*_b[wave] + 5*_b[2.employ#wave]) ///
(u6: _b[2.employ] + 6*_b[wave] + 6*_b[2.employ#wave]) (u7: _b[2.employ] + 7*_b[wave] + 7*_b[2.employ#wave]) ///
(u8: _b[2.employ] + 8*_b[wave] + 8*_b[2.employ#wave]) (u9: _b[2.employ] + 9*_b[wave] + 9*_b[2.employ#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.employ#wave]) (slope3: 1*_b[wave] + 1*_b[2.employ#wave]) ///
, saving(testfile7, replace) esample(esample7) cmdok esampvaryok dots: melogit suslonely i.employ##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.employ using testfile7, at(wave=(0/9)) esample(esample7) predict(mu)
timer off 7

timer on 8
mi estimate (m1: 1*_b[wave]) (m2: 2*_b[wave]) (m3: 3*_b[wave]) (m4: 4*_b[wave]) (m5: 5*_b[wave]) ///
(m6: 6*_b[wave]) (m7: 7*_b[wave]) (m8: 8*_b[wave]) (m9: 9*_b[wave]) ///
(n0: _b[1.marital]) (n1: _b[1.marital] + 1*_b[wave] + 1*_b[1.marital#wave]) ///
(n2: _b[1.marital] + 2*_b[wave] + 2*_b[1.marital#wave]) (n3: _b[1.marital] + 3*_b[wave] + 3*_b[1.marital#wave]) ///
(n4: _b[1.marital] + 4*_b[wave] + 4*_b[1.marital#wave]) (n5: _b[1.marital] + 5*_b[wave] + 5*_b[1.marital#wave]) ///
(n6: _b[1.marital] + 6*_b[wave] + 6*_b[1.marital#wave]) (n7: _b[1.marital] + 7*_b[wave] + 7*_b[1.marital#wave]) ///
(n8: _b[1.marital] + 8*_b[wave] + 8*_b[1.marital#wave]) (n9: _b[1.marital] + 9*_b[wave] + 9*_b[1.marital#wave]) ///
(w0: _b[2.marital]) (w1: _b[2.marital] + 1*_b[wave] + 1*_b[2.marital#wave]) ///
(w2: _b[2.marital] + 2*_b[wave] + 2*_b[2.marital#wave]) (w3: _b[2.marital] + 3*_b[wave] + 3*_b[2.marital#wave]) ///
(w4: _b[2.marital] + 4*_b[wave] + 4*_b[2.marital#wave]) (w5: _b[2.marital] + 5*_b[wave] + 5*_b[2.marital#wave]) ///
(w6: _b[2.marital] + 6*_b[wave] + 6*_b[2.marital#wave]) (w7: _b[2.marital] + 7*_b[wave] + 7*_b[2.marital#wave]) ///
(w8: _b[2.marital] + 8*_b[wave] + 8*_b[2.marital#wave]) (w9: _b[2.marital] + 9*_b[wave] + 9*_b[2.marital#wave]) ///
(slope1: 1*_b[wave]) (slope2: 1*_b[wave] + 1*_b[1.marital#wave]) (slope3: 1*_b[wave] + 1*_b[2.marital#wave]) ///
, saving(testfile8, replace) esample(esample8) cmdok esampvaryok dots: melogit suslonely i.marital##c.wave if cohort>0 & laborforcestatus!=6 || id:, intp(5)
mimrgns i.marital using testfile8, at(wave=(0/9)) esample(esample8) predict(mu)
timer off 8

timer list

log close