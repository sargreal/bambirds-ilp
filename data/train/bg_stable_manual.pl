% Very basic object combinations for learning (Rules 1.1 to 1.4 from ERA-Paper) and 3 additional negative ones that violate these rules 

% situations
situation(bg1_1).
situation(bg1_2).
situation(bg1_3).
situation(bg1_4).
situation(bg1_5).
situation(bg1_6).
situation(bg1_7).
situation(bg1_8).

% objects in situations
inSituation(bg1_1_1,bg1_1).
inSituation(bg1_1_2,bg1_1).
inSituation(bg1_2_1,bg1_2).
inSituation(bg1_2_2,bg1_2).
inSituation(bg1_2_3,bg1_2).
inSituation(bg1_3_1,bg1_3).
inSituation(bg1_3_2,bg1_3).
inSituation(bg1_4_1,bg1_4).
inSituation(bg1_4_2,bg1_4).
inSituation(bg1_4_3,bg1_4).
inSituation(bg1_5_1,bg1_5).
inSituation(bg1_6_1,bg1_6).
inSituation(bg1_6_2,bg1_6).
inSituation(bg1_7_1,bg1_7).
inSituation(bg1_7_2,bg1_7).
inSituation(bg1_8_1,bg1_8).
inSituation(bg1_8_2,bg1_8).

% hasMaterial(ground,hill,-10,200,400,10).
% shape(ground,rect, 195,205,0,[10,410,0]).
% postive

hasMaterial(bg1_1_1,wood,0,195,5,20).
hasMaterial(bg1_1_2,hill,0,200,5,20).
hasMaterial(bg1_2_1,wood,50,180,5,20).
hasMaterial(bg1_2_2,hill,50,200,20,5).
hasMaterial(bg1_2_3,hill,65,180,20,5).
hasMaterial(bg1_3_1,wood,100,180,5,20).
hasMaterial(bg1_3_2,hill,107.5,200,20,5).
hasMaterial(bg1_4_1,wood,150,180,5,20).
hasMaterial(bg1_4_2,hill,140,200,10,30).
hasMaterial(bg1_4_3,hill,165,200,20,5).
% negative
hasMaterial(bg1_5_1,wood,200,180,5,20).
hasMaterial(bg1_6_1,wood,250,180,5,20).
hasMaterial(bg1_6_2,hill,250,200,20,5).
hasMaterial(bg1_7_1,wood,300,180,5,20).
hasMaterial(bg1_7_2,hill,315,200,20,5).
hasMaterial(bg1_8_1,wood,350,180,5,20).
hasMaterial(bg1_8_2,hill,340,200,10,30).

shape(bg1_1_1,rect, 10,192.5,100,[5,20,0]).
shape(bg1_1_2,rect, 10,197.5,100,[5,20,0]).
shape(bg1_2_1,rect, 70,177.5,100,[5,20,0]).
shape(bg1_2_2,rect, 62.5,190,100,[20,5,0]).
shape(bg1_2_3,rect, 77.5,190,100,[20,5,0]).
shape(bg1_3_1,rect, 110,177.5,100,[5,20,0]).
shape(bg1_3_2,rect, 110,190,100,[20,5,0]).
shape(bg1_4_1,rect, 160,177.5,100,[5,20,0]).
shape(bg1_4_2,rect, 145,185,300,[30,10,0]).
shape(bg1_4_3,rect, 167.5,190,100,[20,5,0]).
shape(bg1_5_1,rect, 210,177.5,100,[5,20,0]).
shape(bg1_6_1,rect, 260,177.5,100,[5,20,0]).
shape(bg1_6_2,rect, 252.5,190,100,[20,5,0]).
shape(bg1_7_1,rect, 310,177.5,100,[5,20,0]).
shape(bg1_7_2,rect, 317.5,190,100,[20,5,0]).
shape(bg1_8_1,rect, 360,177.5,100,[5,20,0]).
shape(bg1_8_2,rect, 345,185,300,[30,10,0]).