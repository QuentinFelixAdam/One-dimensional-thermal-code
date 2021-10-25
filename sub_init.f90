!Define boundaries | INITIALIZATION

SUBROUTINE init()
USE m_global
IMPLICIT NONE

dz = L/(Nz-1)
alpha = k/(rho*c)
rho_av_1 = (rho + rho1) * 0.5
rho_av_2 = (rho1 + rho2) * 0.5
rdz2 = 1.0/(dz**2.0)
rk = 1.0/k
powerfactor = 1.0/(c*rho*dz*Delta_R)

ALLOCATE(Told(Nz))
ALLOCATE(Tnew(Nz))
ALLOCATE(w_R(Nz))

DO i = 1,Nz

w_R(i) = 0.0

END DO

indice_R = INT(z_R/dz) + 1
w_R(INT(indice_R)) = 1.0
indexl1 = INT(REAL(L1)/REAL(dz)) + 1
indexl2 = INT(REAL(L1+L2)/REAL(dz)) + 1

PRINT*,'-----------------------------------'
PRINT*,'------DELETING EXISTING FILES------'
PRINT*,'-----------------------------------'

OPEN(23, IOSTAT=stat, FILE='Frostfronttrack.dat', STATUS='old')
IF (stat.EQ.0) THEN
CLOSE(23, STATUS='delete')
END IF

PRINT*,'-----------------------------------'
PRINT*,'------EXISTING FILES DELETED-------'
PRINT*,'-----------------------------------'


PRINT*,'-----------------------------------'
PRINT*,'----LOADING TEMPERATURE PROFILE FROM SPINUP----'
PRINT*,'-----------------------------------'

OPEN(51,FILE='Tdepththroughdepthspinup.dat',STATUS='old')
DO i = 1,Nz
READ(51,*,END = 88) Tnew(i)
END DO
88 CLOSE(51)

Told = Tnew

PRINT*,'-----------------------------------'
PRINT*,'----TEMPERATURE PROFILE FROM SPINUP LOADED----'
PRINT*,'-----------------------------------'

OPEN(27,FILE='Frostfronttrack.dat',POSITION='append')

END SUBROUTINE init
