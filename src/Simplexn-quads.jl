#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - quads2tria tests file ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("Simplexn.jl")

using Base.Test

B_Rep = ([[8.6, 7.3, 3.0], [0.0, 0.0, 3.0], [3.6, 4.3, 0.0], [8.6, 7.6, 3.0], [3.6, 4.4, 0.3], [3.5, 0.3, 3.0], [0.3, 0.3, 0.3], [0.0, 0.3, 3.0], [0.0, 7.3, 0.3], [3.6, 7.3, 2.7], [8.6, 4.4, 0.0], [6.2, 7.6, 3.0], [6.0, 7.6, 2.7], [8.9, 7.6, 3.0], [5.1, 7.6, 3.0], [3.5, 7.3, 3.0], [8.9, 0.3, 0.3], [8.6, 4.4, 3.0], [6.0, 7.6, 3.0], [0.3, 4.3, 0.3], [0.3, 0.3, 0.0], [0.0, 7.3, 3.0], [6.0, 7.3, 1.3], [6.0, 7.6, 1.3], [6.0, 7.3, 0.3], [0.0, 0.0, 0.3], [7.1, 7.6, 3.0], [7.1, 7.3, 2.7], [0.3, 7.6, 0.3], [0.0, 4.3, 3.0], [8.6, 0.3, 0.0], [8.6, 7.3, 0.0], [5.1, 7.3, 2.7], [8.9, 7.3, 3.0], [3.5, 0.3, 0.0], [8.9, 0.3, 0.0], [8.9, 4.3, 0.0], [8.9, 7.6, 0.0], [3.6, 7.3, 0.0], [5.1, 7.3, 1.3], [8.6, 4.3, 3.0], [8.9, 0.0, 3.0], [8.6, 7.3, 1.3], [3.5, 0.0, 0.3], [5.1, 7.3, 3.0], [0.0, 7.6, 0.3], [0.3, 4.4, 0.0], [6.0, 7.3, 2.7], [8.6, 4.3, 0.0], [3.6, 0.0, 0.0], [3.5, 4.4, 3.0], [3.6, 7.3, 0.3], [0.3, 7.3, 0.3], [3.5, 0.3, 0.3], [0.3, 7.6, 0.0], [3.5, 4.3, 0.3], [8.6, 4.4, 0.3], [3.6, 7.3, 1.3], [3.6, 7.6, 3.0], [5.1, 7.6, 1.3], [0.3, 4.3, 3.0], [3.5, 0.0, 0.0], [3.6, 4.4, 0.0], [7.1, 7.6, 1.3], [3.5, 7.6, 0.0], [8.6, 0.0, 0.0], [0.0, 4.4, 3.0], [0.3, 4.4, 0.3], [3.5, 4.3, 3.0], [6.2, 7.3, 1.3], [8.9, 4.4, 0.0], [8.6, 7.3, 2.7], [8.9, 0.3, 3.0], [3.5, 7.3, 0.0], [3.6, 0.3, 0.0], [6.2, 7.3, 0.3], [8.6, 7.6, 2.7], [3.6, 7.6, 0.0], [0.0, 0.3, 0.0], [8.6, 7.3, 0.3], [3.5, 7.6, 0.3], [0.0, 7.3, 0.0], [0.3, 0.0, 0.0], [7.1, 7.6, 0.3], [0.0, 4.4, 0.3], [3.6, 7.6, 1.3], [0.0, 0.0, 0.0], [8.9, 4.4, 0.3], [8.9, 7.6, 0.3], [6.2, 7.3, 3.0], [6.2, 7.3, 2.7], [7.1, 7.3, 3.0], [0.0, 7.6, 0.0], [3.5, 7.6, 3.0], [0.0, 0.3, 0.3], [7.1, 7.6, 2.7], [3.6, 7.3, 3.0], [5.1, 7.3, 0.3], [0.3, 7.3, 3.0], [6.2, 7.6, 2.7], [0.3, 7.3, 0.0], [8.9, 0.0, 0.0], [0.3, 4.3, 0.0], [0.0, 4.3, 0.0], [5.1, 7.6, 0.3], [6.2, 7.6, 1.3], [3.5, 4.3, 0.0], [8.9, 7.3, 0.0], [6.0, 7.6, 0.3], [8.9, 4.3, 0.3], [8.6, 4.3, 0.3], [8.6, 7.6, 0.0], [0.3, 4.4, 3.0], [7.1, 7.3, 0.3], [0.3, 0.0, 0.3], [0.0, 4.4, 0.0], [3.5, 4.4, 0.3], [8.6, 7.6, 1.3], [3.5, 4.4, 0.0], [3.6, 4.3, 0.3], [6.0, 7.3, 3.0], [5.1, 7.6, 2.7], [3.6, 7.6, 2.7], [6.2, 7.6, 0.3], [8.9, 0.0, 0.3], [3.5, 0.0, 3.0], [0.0, 4.3, 0.3], [0.0, 7.6, 3.0], [8.9, 7.3, 0.3], [7.1, 7.3, 1.3], [8.9, 4.3, 3.0], [3.5, 7.3, 0.3], [8.6, 7.6, 0.3], [3.6, 7.6, 0.3], [3.6, 4.4, 3.0], [0.3, 0.0, 3.0], [0.3, 0.3, 3.0], [0.3, 7.6, 3.0], [8.9, 4.4, 3.0], [3.6, 4.3, 3.0], [3.6, 0.0, 0.3], [8.6, 0.0, 3.0], [3.6, 0.3, 3.0], [8.6, 0.3, 0.3], [3.6, 0.0, 3.0], [3.6, 0.3, 0.3], [8.6, 0.3, 3.0], [8.6, 0.0, 0.3], [5.6, 0.0, 3.0], [6.6, 0.3, 3.0], [5.6, 0.3, 3.0], [5.6, 0.3, 0.3], [6.6, 0.3, 2.5], [5.6, 0.0, 2.5], [6.6, 0.0, 2.5], [5.6, 0.0, 0.3], [3.6, 0.3, 2.5], [6.6, 0.0, 0.3], [8.6, 0.3, 2.5], [8.6, 0.0, 2.5], [5.6, 0.3, 2.5], [3.6, 0.0, 2.5], [6.6, 0.3, 0.3], [6.6, 0.0, 3.0]], [[0, 3, 13, 33], [0, 3, 26, 91], [0, 17, 33, 138], [0, 17, 42, 56, 71, 79], [0, 27, 71, 91], [1, 7, 25, 94], [1, 7, 135, 136], [1, 25, 114, 135], [2, 10, 48, 62], [2, 30, 48, 74], [2, 34, 74, 106], [2, 62, 106, 118], [3, 13, 76, 88, 117, 132], [3, 26, 76, 95], [4, 9, 51, 57, 96, 134], [4, 17, 56, 134], [4, 24, 51, 56, 75, 79, 97, 113], [5, 6, 53, 136], [5, 53, 55, 68], [5, 68, 139, 142], [5, 125, 135, 136], [5, 125, 142, 144], [6, 19, 53, 55], [6, 19, 60, 136], [7, 29, 60, 136], [7, 29, 94, 126], [8, 21, 45, 127], [8, 21, 66, 84], [8, 45, 81, 92], [8, 81, 84, 115], [9, 32, 39, 57], [9, 32, 44, 96], [10, 31, 38, 62], [10, 31, 70, 107], [10, 36, 48, 70], [11, 12, 18, 99], [11, 18, 89, 120], [11, 26, 89, 91], [11, 26, 95, 99], [12, 14, 18, 121], [12, 22, 23, 47], [12, 23, 99, 105], [12, 32, 47, 121], [13, 33, 88, 128], [14, 18, 44, 120], [14, 44, 58, 96], [14, 58, 121, 122], [15, 50, 96, 134], [15, 50, 116, 131], [15, 52, 98, 131], [15, 58, 93, 96], [15, 93, 98, 137], [16, 35, 36, 109], [16, 35, 101, 124], [16, 41, 72, 124], [16, 72, 109, 130], [17, 40, 130, 138], [17, 40, 134, 139], [19, 55, 60, 68], [20, 34, 61, 82], [20, 34, 102, 106], [20, 78, 82, 86], [20, 78, 102, 103], [21, 66, 98, 112], [21, 98, 127, 137], [22, 23, 39, 59], [22, 24, 39, 97], [22, 24, 69, 75], [22, 47, 69, 90], [23, 59, 104, 108], [23, 105, 108, 123], [25, 78, 86, 94], [25, 82, 86, 114], [27, 42, 71, 129], [27, 63, 95, 129], [27, 89, 90, 91], [27, 90, 95, 99], [28, 45, 54, 92], [28, 45, 127, 137], [28, 54, 64, 80], [28, 80, 93, 137], [29, 60, 66, 112], [29, 66, 84, 126], [30, 35, 36, 48], [30, 35, 65, 101], [30, 49, 65, 74], [31, 37, 107, 111], [31, 38, 77, 111], [32, 39, 59, 121], [32, 44, 47, 120], [33, 87, 128, 138], [34, 49, 61, 74], [36, 70, 87, 109], [37, 88, 107, 128], [37, 88, 111, 132], [38, 62, 73, 118], [38, 64, 73, 77], [39, 51, 57, 97], [40, 72, 130, 146], [40, 110, 119, 139], [40, 110, 143, 146, 158], [41, 72, 141, 146], [41, 124, 141, 147, 159], [42, 79, 113, 129], [43, 49, 61, 140], [43, 61, 82, 114], [43, 114, 125, 135], [43, 125, 140, 144, 161], [46, 73, 100, 118], [46, 81, 100, 115], [46, 102, 103, 115], [46, 102, 106, 118], [47, 89, 90, 120], [49, 65, 140, 147, 155, 157], [50, 60, 68, 112], [50, 67, 112, 116], [50, 68, 134, 139], [52, 67, 98, 112], [52, 67, 116, 131], [54, 64, 73, 100], [54, 81, 92, 100], [58, 80, 85, 93, 122, 133], [59, 85, 104, 133], [59, 85, 121, 122], [63, 69, 105, 129], [63, 76, 95, 117], [63, 83, 105, 123], [63, 83, 117, 132], [64, 77, 80, 133], [65, 101, 124, 147], [69, 75, 113, 129], [69, 90, 99, 105], [70, 87, 107, 128], [77, 83, 104, 108, 111, 123, 132, 133], [78, 94, 103, 126], [84, 103, 115, 126], [87, 109, 130, 138], [110, 119, 143, 145, 151, 162], [119, 139, 142, 145, 156], [140, 153, 155, 161], [141, 146, 149, 163], [141, 154, 159, 163], [142, 144, 148, 150], [142, 150, 156, 160], [143, 152, 158, 162], [144, 148, 153, 161], [145, 151, 156, 160], [146, 149, 152, 158], [147, 154, 157, 159], [148, 149, 150, 163], [148, 153, 154, 163], [149, 150, 152, 160], [151, 153, 155, 160], [151, 155, 157, 162], [152, 153, 154, 160], [152, 154, 157, 162]])

verts, triangles = quads2tria(B_Rep)


# original with 10**3
vertsPy1 = [[8.6, 7.3, 3.0], [0.0, 0.0, 3.0], [3.6, 4.3, 0.0], [8.6, 7.6, 3.0], [3.6, 4.4, 0.3], [3.5, 0.3, 3.0], [0.3, 0.3, 0.3], [0.0, 0.3, 3.0], [0.0, 7.3, 0.3], [3.6, 7.3, 2.7], [8.6, 4.4, 0.0], [6.2, 7.6, 3.0], [6.0, 7.6, 2.7], [8.9, 7.6, 3.0], [5.1, 7.6, 3.0], [3.5, 7.3, 3.0], [8.9, 0.3, 0.3], [8.6, 4.4, 3.0], [6.0, 7.6, 3.0], [0.3, 4.3, 0.3], [0.3, 0.3, 0.0], [0.0, 7.3, 3.0], [6.0, 7.3, 1.3], [6.0, 7.6, 1.3], [6.0, 7.3, 0.3], [0.0, 0.0, 0.3], [7.1, 7.6, 3.0], [7.1, 7.3, 2.7], [0.3, 7.6, 0.3], [0.0, 4.3, 3.0], [8.6, 0.3, 0.0], [8.6, 7.3, 0.0], [5.1, 7.3, 2.7], [8.9, 7.3, 3.0], [3.5, 0.3, 0.0], [8.9, 0.3, 0.0], [8.9, 4.3, 0.0], [8.9, 7.6, 0.0], [3.6, 7.3, 0.0], [5.1, 7.3, 1.3], [8.6, 4.3, 3.0], [8.9, 0.0, 3.0], [8.6, 7.3, 1.3], [3.5, 0.0, 0.3], [5.1, 7.3, 3.0], [0.0, 7.6, 0.3], [0.3, 4.4, 0.0], [6.0, 7.3, 2.7], [8.6, 4.3, 0.0], [3.6, 0.0, 0.0], [3.5, 4.4, 3.0], [3.6, 7.3, 0.3], [0.3, 7.3, 0.3], [3.5, 0.3, 0.3], [0.3, 7.6, 0.0], [3.5, 4.3, 0.3], [8.6, 4.4, 0.3], [3.6, 7.3, 1.3], [3.6, 7.6, 3.0], [5.1, 7.6, 1.3], [0.3, 4.3, 3.0], [3.5, 0.0, 0.0], [3.6, 4.4, 0.0], [7.1, 7.6, 1.3], [3.5, 7.6, 0.0], [8.6, 0.0, 0.0], [0.0, 4.4, 3.0], [0.3, 4.4, 0.3], [3.5, 4.3, 3.0], [6.2, 7.3, 1.3], [8.9, 4.4, 0.0], [8.6, 7.3, 2.7], [8.9, 0.3, 3.0], [3.5, 7.3, 0.0], [3.6, 0.3, 0.0], [6.2, 7.3, 0.3], [8.6, 7.6, 2.7], [3.6, 7.6, 0.0], [0.0, 0.3, 0.0], [8.6, 7.3, 0.3], [3.5, 7.6, 0.3], [0.0, 7.3, 0.0], [0.3, 0.0, 0.0], [7.1, 7.6, 0.3], [0.0, 4.4, 0.3], [3.6, 7.6, 1.3], [0.0, 0.0, 0.0], [8.9, 4.4, 0.3], [8.9, 7.6, 0.3], [6.2, 7.3, 3.0], [6.2, 7.3, 2.7], [7.1, 7.3, 3.0], [0.0, 7.6, 0.0], [3.5, 7.6, 3.0], [0.0, 0.3, 0.3], [7.1, 7.6, 2.7], [3.6, 7.3, 3.0], [5.1, 7.3, 0.3], [0.3, 7.3, 3.0], [6.2, 7.6, 2.7], [0.3, 7.3, 0.0], [8.9, 0.0, 0.0], [0.3, 4.3, 0.0], [0.0, 4.3, 0.0], [5.1, 7.6, 0.3], [6.2, 7.6, 1.3], [3.5, 4.3, 0.0], [8.9, 7.3, 0.0], [6.0, 7.6, 0.3], [8.9, 4.3, 0.3], [8.6, 4.3, 0.3], [8.6, 7.6, 0.0], [0.3, 4.4, 3.0], [7.1, 7.3, 0.3], [0.3, 0.0, 0.3], [0.0, 4.4, 0.0], [3.5, 4.4, 0.3], [8.6, 7.6, 1.3], [3.5, 4.4, 0.0], [3.6, 4.3, 0.3], [6.0, 7.3, 3.0], [5.1, 7.6, 2.7], [3.6, 7.6, 2.7], [6.2, 7.6, 0.3], [8.9, 0.0, 0.3], [3.5, 0.0, 3.0], [0.0, 4.3, 0.3], [0.0, 7.6, 3.0], [8.9, 7.3, 0.3], [7.1, 7.3, 1.3], [8.9, 4.3, 3.0], [3.5, 7.3, 0.3], [8.6, 7.6, 0.3], [3.6, 7.6, 0.3], [3.6, 4.4, 3.0], [0.3, 0.0, 3.0], [0.3, 0.3, 3.0], [0.3, 7.6, 3.0], [8.9, 4.4, 3.0], [3.6, 4.3, 3.0], [3.6, 0.0, 0.3], [8.6, 0.0, 3.0], [3.6, 0.3, 3.0], [8.6, 0.3, 0.3], [3.6, 0.0, 3.0], [3.6, 0.3, 0.3], [8.6, 0.3, 3.0], [8.6, 0.0, 0.3], [5.6, 0.0, 3.0], [6.6, 0.3, 3.0], [5.6, 0.3, 3.0], [5.6, 0.3, 0.3], [6.6, 0.3, 2.5], [5.6, 0.0, 2.5], [6.6, 0.0, 2.5], [5.6, 0.0, 0.3], [3.6, 0.3, 2.5], [6.6, 0.0, 0.3], [8.6, 0.3, 2.5], [8.6, 0.0, 2.5], [5.6, 0.3, 2.5], [3.6, 0.0, 2.5], [6.6, 0.3, 0.3], [6.6, 0.0, 3.0], [8.75, 7.45, 3.0], [7.85, 7.45, 3.0], [8.75, 5.85, 3.0]]
trianglesPy1 = [[164, 0, 3], [164, 3, 13], [164, 13, 33], [164, 33, 0], [165, 0, 3], [165, 3, 26], [165, 26, 91], [165, 91, 0], [166, 138, 17], [166, 17, 0], [166, 0, 33], [166, 33, 138]]

# modified with 1/(10**3)
vertsPy2 = [[8.6, 7.3, 3.0], [0.0, 0.0, 3.0], [3.6, 4.3, 0.0], [8.6, 7.6, 3.0], [3.6, 4.4, 0.3], [3.5, 0.3, 3.0], [0.3, 0.3, 0.3], [0.0, 0.3, 3.0], [0.0, 7.3, 0.3], [3.6, 7.3, 2.7], [8.6, 4.4, 0.0], [6.2, 7.6, 3.0], [6.0, 7.6, 2.7], [8.9, 7.6, 3.0], [5.1, 7.6, 3.0], [3.5, 7.3, 3.0], [8.9, 0.3, 0.3], [8.6, 4.4, 3.0], [6.0, 7.6, 3.0], [0.3, 4.3, 0.3], [0.3, 0.3, 0.0], [0.0, 7.3, 3.0], [6.0, 7.3, 1.3], [6.0, 7.6, 1.3], [6.0, 7.3, 0.3], [0.0, 0.0, 0.3], [7.1, 7.6, 3.0], [7.1, 7.3, 2.7], [0.3, 7.6, 0.3], [0.0, 4.3, 3.0], [8.6, 0.3, 0.0], [8.6, 7.3, 0.0], [5.1, 7.3, 2.7], [8.9, 7.3, 3.0], [3.5, 0.3, 0.0], [8.9, 0.3, 0.0], [8.9, 4.3, 0.0], [8.9, 7.6, 0.0], [3.6, 7.3, 0.0], [5.1, 7.3, 1.3], [8.6, 4.3, 3.0], [8.9, 0.0, 3.0], [8.6, 7.3, 1.3], [3.5, 0.0, 0.3], [5.1, 7.3, 3.0], [0.0, 7.6, 0.3], [0.3, 4.4, 0.0], [6.0, 7.3, 2.7], [8.6, 4.3, 0.0], [3.6, 0.0, 0.0], [3.5, 4.4, 3.0], [3.6, 7.3, 0.3], [0.3, 7.3, 0.3], [3.5, 0.3, 0.3], [0.3, 7.6, 0.0], [3.5, 4.3, 0.3], [8.6, 4.4, 0.3], [3.6, 7.3, 1.3], [3.6, 7.6, 3.0], [5.1, 7.6, 1.3], [0.3, 4.3, 3.0], [3.5, 0.0, 0.0], [3.6, 4.4, 0.0], [7.1, 7.6, 1.3], [3.5, 7.6, 0.0], [8.6, 0.0, 0.0], [0.0, 4.4, 3.0], [0.3, 4.4, 0.3], [3.5, 4.3, 3.0], [6.2, 7.3, 1.3], [8.9, 4.4, 0.0], [8.6, 7.3, 2.7], [8.9, 0.3, 3.0], [3.5, 7.3, 0.0], [3.6, 0.3, 0.0], [6.2, 7.3, 0.3], [8.6, 7.6, 2.7], [3.6, 7.6, 0.0], [0.0, 0.3, 0.0], [8.6, 7.3, 0.3], [3.5, 7.6, 0.3], [0.0, 7.3, 0.0], [0.3, 0.0, 0.0], [7.1, 7.6, 0.3], [0.0, 4.4, 0.3], [3.6, 7.6, 1.3], [0.0, 0.0, 0.0], [8.9, 4.4, 0.3], [8.9, 7.6, 0.3], [6.2, 7.3, 3.0], [6.2, 7.3, 2.7], [7.1, 7.3, 3.0], [0.0, 7.6, 0.0], [3.5, 7.6, 3.0], [0.0, 0.3, 0.3], [7.1, 7.6, 2.7], [3.6, 7.3, 3.0], [5.1, 7.3, 0.3], [0.3, 7.3, 3.0], [6.2, 7.6, 2.7], [0.3, 7.3, 0.0], [8.9, 0.0, 0.0], [0.3, 4.3, 0.0], [0.0, 4.3, 0.0], [5.1, 7.6, 0.3], [6.2, 7.6, 1.3], [3.5, 4.3, 0.0], [8.9, 7.3, 0.0], [6.0, 7.6, 0.3], [8.9, 4.3, 0.3], [8.6, 4.3, 0.3], [8.6, 7.6, 0.0], [0.3, 4.4, 3.0], [7.1, 7.3, 0.3], [0.3, 0.0, 0.3], [0.0, 4.4, 0.0], [3.5, 4.4, 0.3], [8.6, 7.6, 1.3], [3.5, 4.4, 0.0], [3.6, 4.3, 0.3], [6.0, 7.3, 3.0], [5.1, 7.6, 2.7], [3.6, 7.6, 2.7], [6.2, 7.6, 0.3], [8.9, 0.0, 0.3], [3.5, 0.0, 3.0], [0.0, 4.3, 0.3], [0.0, 7.6, 3.0], [8.9, 7.3, 0.3], [7.1, 7.3, 1.3], [8.9, 4.3, 3.0], [3.5, 7.3, 0.3], [8.6, 7.6, 0.3], [3.6, 7.6, 0.3], [3.6, 4.4, 3.0], [0.3, 0.0, 3.0], [0.3, 0.3, 3.0], [0.3, 7.6, 3.0], [8.9, 4.4, 3.0], [3.6, 4.3, 3.0], [3.6, 0.0, 0.3], [8.6, 0.0, 3.0], [3.6, 0.3, 3.0], [8.6, 0.3, 0.3], [3.6, 0.0, 3.0], [3.6, 0.3, 0.3], [8.6, 0.3, 3.0], [8.6, 0.0, 0.3], [5.6, 0.0, 3.0], [6.6, 0.3, 3.0], [5.6, 0.3, 3.0], [5.6, 0.3, 0.3], [6.6, 0.3, 2.5], [5.6, 0.0, 2.5], [6.6, 0.0, 2.5], [5.6, 0.0, 0.3], [3.6, 0.3, 2.5], [6.6, 0.0, 0.3], [8.6, 0.3, 2.5], [8.6, 0.0, 2.5], [5.6, 0.3, 2.5], [3.6, 0.0, 2.5], [6.6, 0.3, 0.3], [6.6, 0.0, 3.0], [8.75, 7.45, 3.0], [7.85, 7.45, 3.0], [8.75, 5.85, 3.0]]
trianglesPy2 = [[164, 13, 33], [164, 33, 0], [164, 0, 3], [164, 3, 13], [165, 26, 91], [165, 91, 0], [165, 0, 3], [165, 3, 26], [166, 33, 0], [166, 0, 17], [166, 17, 138], [166, 138, 33]]

@testset "tests" begin

@testset "prova python" begin
	@test vertsPy1 == vertsPy2
	@test Set(vertsPy1) == Set(vertsPy2)
	@test trianglesPy1 == trianglesPy2
	@test Set(trianglesPy1) == Set(trianglesPy2)
end

@testset "quads2tria 10**3" begin
	@test verts == vertsPy1
	@test Set(verts) == Set(vertsPy1)
	@test triangles == trianglesPy1
	@test Set(triangles) == Set(trianglesPy1)
end

@testset "quads2tria 1/(10**3)" begin
	@test verts == vertsPy2
	@test Set(verts) == Set(vertsPy2)
	@test triangles == trianglesPy2
	@test Set(triangles) == Set(trianglesPy2)
end

end
