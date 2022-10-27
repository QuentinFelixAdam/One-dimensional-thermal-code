# One-dimensional-thermal-code
This code allows the calculations of temperature levels within a three-layered medium. It accounts for the effects of latent heat , as well as a heat source placed at some depth within the first layer. The implemented model is utilized for thermal calculations within an asphalt pavement system to track the frost front penetration. The thermal properties found in the parameters file represent an idealized pavement system, and the heat source represents the operation of an array of heating elements in the form of ribbons. This code was developped as part of the Snowless project.

The code was implemented in ForTran 90 within a Linux environment (distribution "Linux Scientific" Version 7.7). 

The code was verified against GeoStudio; see file "Verification against Geostudio.txt"

The compiler is GNU Fortran (GCC) Version 4.8.5 20150623.

There is a possibility to parallelize the code with OpenMP/MPI.

In order to run the code, simply place the weather data files into the same folder as the code files, open a terminal, type "make" followed by "exe".

To cite this code, please refer to the following journal articles: 1) https://www.sciencedirect.com/science/article/pii/S0165232X22002002 and 2) https://ascelibrary.org/doi/abs/10.1061/%28ASCE%29CR.1943-5495.0000289

For any question: contact me via quentin.f.adam@gmail.com
