enable_recursion.

max_clauses(3).

head_pred(stable,1).
% head_pred(supports,2).

% Only for stable
body_pred(recursive_supports,2).
body_pred(supports,2).

body_pred(before,2).
% body_pred(after,2).
body_pred(meets,2).
% body_pred(meetsI,2).
body_pred(mostOverlapsMost,2).
% body_pred(mostOverlapsMostI,2).
body_pred(lessOverlapsMost,2).
% body_pred(lessOverlapsMostI,2).
body_pred(mostOverlapsLess,2).
% body_pred(mostOverlapsLessI,2).
body_pred(lessOverlapsLess,2).
% body_pred(lessOverlapsLessI,2).
body_pred(lessStarts,2).
% body_pred(lessStartsI,2).
body_pred(leftDuring,2).
% body_pred(leftDuringI,2).
body_pred(centerDuring,2).
% body_pred(centerDuringI,2).
body_pred(rightDuring,2).
% body_pred(rightDuringI,2).
body_pred(lessFinishes,2).
% body_pred(lessFinishesI,2).
body_pred(mostFinishes,2).
% body_pred(mostFinishesI,2).
body_pred(equal,2).
body_pred(noContact,2).
body_pred(surfaceContact,2).
body_pred(pointContact,2).
body_pred(pointSurfaceContact,2).
body_pred(horizontalContact,2).
body_pred(verticalContact,2).
body_pred(below,2).
% body_pred(above,2).
body_pred(on,2).
% body_pred(onI,2).
body_pred(overlapsY,2).
% body_pred(overlapsYI,2).
body_pred(startsY,2).
% body_pred(startsYI,2).
body_pred(duringY,2).
% body_pred(duringYI,2).
body_pred(finishesY,2).
% body_pred(finishesYI,2).
body_pred(equalY,2).
body_pred(object,1).
body_pred(fixed,1).