""" 2D example """
from larlib import *

V,FV = larSimplexGrid1([3,3])
print "\nV:\n",V,"\nFV:\n",FV
#VIEW(EXPLODE(1.5,1.5,1.5)(MKPOLS((V,FV))))

EV = larSimplexFacets(FV)
print "\nEV:\n",EV
ex,ey,ez = 1.5,1.5,1.5
#VIEW(EXPLODE(ex,ey,ez)(MKPOLS((V,EV))))

