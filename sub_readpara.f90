SUBROUTINE readpara()
USE m_global
IMPLICIT NONE

NAMELIST /para/dt,Nz,rho,c,k,L,z_R,Delta_R,sigma,eps_s,a,&
               power,rho1,rho2,z_R,L1,L2,c2unfrozen,c2frozen,&
               k2unfrozen,k2frozen,beta,temp_ref,theta_0_1,c1unfrozen,&
               c1frozen,k1unfrozen,k1frozen,latentheat,theta_0_2

OPEN(20,FILE='para.dat')

READ(20,NML=para)

CLOSE(20)


END SUBROUTINE readpara
