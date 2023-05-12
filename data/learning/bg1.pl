% Very basic object combinations for learning (Rules 1.1 to 1.4 from ERA-Paper) and 3 additional negative ones that violate these rules 

hasMaterial(ground,hill,-1000,0,2000,10).
% postive
hasMaterial(bg1_1_1,wood,0,0,5,20).
hasMaterial(bg1_2_1,wood,50,20,5,20).
hasMaterial(bg1_2_2,wood,50,0,20,5).
hasMaterial(bg1_2_3,wood,65,0,20,5).
hasMaterial(bg1_3_1,wood,100,20,5,20).
hasMaterial(bg1_3_2,wood,107.5,0,20,5).
hasMaterial(bg1_4_1,wood,150,20,5,20).
hasMaterial(bg1_4_2,wood,140,0,10,30).
hasMaterial(bg1_4_3,wood,165,0,20,5).
% negative
hasMaterial(bg1_5_1,wood,200,20,5,20).
hasMaterial(bg1_6_1,wood,250,20,5,20).
hasMaterial(bg1_6_2,wood,250,0,20,5).
hasMaterial(bg1_7_1,wood,300,20,5,20).
hasMaterial(bg1_7_2,wood,315,0,20,5).

shape(ground,rect, 0,389,0,[10,2000,0]).
shape(bg1_1_1,rect, 10,2.5,100,[5,20,0]).
shape(bg1_2_1,rect, 70,22.5,100,[5,20,0]).
shape(bg1_2_2,rect, 62.5,10,100,[20,5,0]).
shape(bg1_2_3,rect, 77.5,10,100,[20,5,0]).
shape(bg1_3_1,rect, 110,22.5,100,[5,20,0]).
shape(bg1_3_2,rect, 110,10,100,[20,5,0]).
shape(bg1_4_1,rect, 160,22.5,100,[5,20,0]).
shape(bg1_4_2,rect, 145,15,300,[30,10,0]).
shape(bg1_4_3,rect, 167.5,10,100,[20,5,0]).
shape(bg1_5_1,rect, 210,22.5,100,[5,20,0]).
shape(bg1_6_1,rect, 260,22.5,100,[5,20,0]).
shape(bg1_6_2,rect, 252.5,10,100,[20,5,0]).
shape(bg1_7_1,rect, 310,22.5,100,[5,20,0]).
shape(bg1_7_2,rect, 317.5,10,100,[20,5,0]).