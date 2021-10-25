MODULE m_global
IMPLICIT NONE
INTEGER :: Nz,stat,i,j,indexl1,indexl2,nlinescase,m
REAL :: dt, dz, t1, t2,alpha,k,z_R,Delta_R
REAL :: rho, c, k, sigma, eps_s, a,L,hc
REAL:: power,indice_R,rho1
REAL::rho2,L1,L2,rdz2,intercept
REAL :: rk,c_eff_av_1,c_eff_av_2
REAL :: k_eff_2,rho_av_1,rho_av_2
REAL :: k_int_1,k_int_2_m,k_int_2_p,c_int_1,c_int_2_m,c_int_2_p,powerfactor
REAL :: exponentlatent,latentheat
REAL :: c2unfrozen, c2frozen, k2unfrozen, k2frozen
REAL :: theta_uw,beta,temp_ref,theta_0_1
REAL :: d_T_theta_uw,c_eff_1,c_eff_2,k_eff_1
REAL :: c1unfrozen, c1frozen, k1unfrozen, k1frozen,theta_0_2
REAL,DIMENSION(:),ALLOCATABLE::f_s,T_air,w_R,Told,Tnew
REAL,DIMENSION(:),ALLOCATABLE::V_air,fD_loop,fD

END MODULE m_global
