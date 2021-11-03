# One-dimensional-thermal-code
This code allows the calculations of temperature levels within a three-layered medium. It accounts for the effects of latent heat , as well as a heat source placed at some depth within the first layer. The implemented model is utilized for thermal calculations within an asphalt pavement system to track the frost front penetration. The thermal properties found in the parameters file represent an idealized pavement system, and the heat source represents the operation of an array of heating elements in the form of ribbons. This code was developped as part of the Snowless project.

The code was implemented in ForTran 90 within a Linux environment(distribution "Linux Scientific" Version 7.7). The coding was first verified by comparison against analytic closed-form solutions involving a single thermally isotropic layer exposed at the boundaries to a prescribed temperature history and to a combination of temperature and heat-flux. The ability to account for medium layering, internal heating, and phase change due to moisture freezing and thawing, was further verified against a commercial software GeoStudio (GEO-SLOPE International Ltd., 2014) which is based on a finite-element formulation; differences were observed to be smaller than 0.13◦C (in absolute terms) for all considered cases. The latter comparison was not performed for long weather histories because GeoStudio was about two orders of magnitude slower.

The compiler is GNU Fortran (GCC) Version 4.8.5 20150623.

There is a possibility to parallelize the code with OpenMP.

In order to run the code, simply place the weather data files into the same folder as the code files, open a terminal, type "make" followed by "exe".

This code is based on a research paper to be published any time soon -- hopefully. Should you want to reuse that code and this paper be published, I will embed here a citation.

For any question: contact me via quentin.f.adam@gmail.com
