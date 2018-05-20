""" 3D example """
from larlib import *

V,CV = larSimplexGrid1([2,2,2])
print "\nV:\n",V,"\nCV:\n",CV
#VIEW(EXPLODE(1.5,1.5,1.5)(MKPOLS((V,CV))))


FV = larSimplexFacets(CV)
print "\nFV:\n",FV
#VIEW(EXPLODE(1.5,1.5,1.5)(MKPOLS((V,FV))))
EV = larSimplexFacets(FV)
print "\nEV:\n",EV
#VIEW(EXPLODE(1.5,1.5,1.5)(MKPOLS((V,EV))))

