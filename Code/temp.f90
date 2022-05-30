PROGRAM temp
USE m_global
IMPLICIT NONE

CALL CPU_TIME(t1)

CALL lire()

CALL readpara()

CALL init()

OPEN(23, IOSTAT=stat, FILE='Surfacetemp.dat', STATUS='old')
IF (stat.EQ.0) THEN
CLOSE(23, STATUS='delete')
END IF

OPEN(27,FILE='Surfacetemp.dat',POSITION='append')

OPEN(51,FILE='Tdepththroughdepth.dat',STATUS='old')
DO i = 1,Nz
READ(51,*,END = 88) Tnew(i)
END DO
88 CLOSE(51)

DO m = 1,2

PRINT*,'-----------------------------------'
PRINT*,'-------BEGIN FINAL YEAR',m,'-------'
PRINT*,'-----------------------------------'

DO i = 1,nlinescase

intercept = +1

IF(((MOD(i-1,30)).EQ.0)) THEN
   DO j = 1,INT(Nz/4.0)
      IF(Tnew(j)*Tnew(j+1).LT.0.0) THEN
         intercept = -1.0*(j-1)*dz
         WRITE(27,*)(m-1)*(nlinescase-1)*dt + (i-1)*dt,intercept
      END IF
   END DO
   WRITE(27,*)(m-1)*(nlinescase-1)*dt + (i-1)*dt,intercept
END IF

!IF(((MOD(i-1,3)).EQ.0)) THEN
!   WRITE(27,*) Tnew(1)
!END IF


! EVALUATE CONVECTION COEFFICIENT

   IF(V_air(i).LE.5.0) THEN
      hc = 5.6 + 4.0*V_air(i)
   ELSE
      hc = 7.3*(V_air(i))**0.78
   END IF

! UPDATE SURFACE TEMPERATURE

   Tnew(1) = Told(1) + 2.0*alpha*dt*rdz2*( Told(2) - Told(1) + &
   dz*rk*(a*f_s(i) + hc*(T_air(i) - Told(1)) + eps_s * &
   (fD(i) - sigma*(Told(1) + 273.15)**4.0) ))

!LOOP TO UPDATE TEMPERATURE WITHIN LAYER 1
!FREEZE / THAWING EFFECTS ARE NEGLECTED

   DO j = 2,indexl1-1

      Tnew(j) = Told(j) + alpha*dt*(Told(j-1)+ &
      Told(j+1))*rdz2 -2.0*alpha*dt*rdz2*Told(j) + &
      dt*w_R(j)*power*powerfactor

   END DO

!UPDATE TEMPERATURE OF INTERFACE 1

   IF(Told(indexl1).GE.temp_ref) THEN
         d_T_theta_uw = 0.0
   ELSE
         d_T_theta_uw = ((temp_ref-Told(indexl1))/(temp_ref+273.15))**beta
         d_T_theta_uw = theta_0_1*beta*d_T_theta_uw*0.5/&
                        (temp_ref - Told(indexl1))
   END IF

   c_eff_av_1 = (c + c_int_1) * 0.5
   
   Tnew(indexl1) = Told(indexl1) + dt*rdz2*(k_int_1*Told(indexl1+1) - &
   (k_int_1 + k)*Told(indexl1) + k*Told(indexl1-1))/(c_eff_av_1* &
   rho_av_1 + latentheat*d_T_theta_uw)

!LOOP TO UPDATE TEMPERATURE WITHIN LAYER 2

   DO j = indexl1+1,indexl2-1

      IF(Told(j).GE.temp_ref) THEN
         theta_uw = theta_0_1
         d_T_theta_uw = 0.0
      ELSE
         theta_uw = ((temp_ref-Told(j))/(temp_ref+273.15))**beta
         theta_uw = theta_0_1*(1.0 - theta_uw)
         d_T_theta_uw = ((temp_ref-Told(j))/(temp_ref+273.15))**beta
         d_T_theta_uw = theta_0_1*beta*d_T_theta_uw/&
                        (temp_ref - Told(j))
      END IF

      exponentlatent = theta_uw/theta_0_1

      c_eff_1 = c1frozen*(1.0-exponentlatent) + &
      c1unfrozen*exponentlatent
      
      k_eff_1 = k1frozen**(1.0-exponentlatent) * &
      k1unfrozen**exponentlatent

      Tnew(j) = Told(j) + k_eff_1*dt*rdz2*(Told(j+1) - 2.0*Told(j) + &
      Told(j-1))/(c_eff_1*rho1 + latentheat*d_T_theta_uw)

      IF(j.EQ.indexl1+1) THEN
         c_int_1 = c_eff_1
         k_int_1 = k_eff_1
      END IF

      IF(j.EQ.indexl2-1) THEN
         c_int_2_m = c_eff_1
         k_int_2_m = k_eff_1
      END IF

   END DO

!UPDATE TEMPERATURE OF INTERFACE 2

   IF(Told(indexl2).GE.temp_ref) THEN
         d_T_theta_uw = 0.0
   ELSE
         d_T_theta_uw = ((temp_ref-Told(indexl2))/(temp_ref+273.15))**beta
         d_T_theta_uw = (theta_0_1 + theta_0_2)*0.5*beta*d_T_theta_uw/&
                        (temp_ref - Told(indexl2))
   END IF

   c_eff_av_2 = (c_int_2_m + c_int_2_p) * 0.5
   
   Tnew(indexl2) = Told(indexl2) + dt*rdz2*(k_int_2_p*Told(indexl2+1) - &
   (k_int_2_m + k_int_2_p)*Told(indexl2) + k_int_2_m*Told(indexl2-1))/(c_eff_av_2* &
   rho_av_2 + latentheat*d_T_theta_uw)

!LOOP TO UPDATE TEMPERATURE WITHIN LAYER 3

   DO j = indexl2+1,Nz-1

      IF(Told(j).GE.temp_ref) THEN
         theta_uw = theta_0_2
         d_T_theta_uw = 0.0
      ELSE
         theta_uw = ((temp_ref-Told(j))/(temp_ref+273.15))**beta
         theta_uw = theta_0_2*(1.0 - theta_uw)
         d_T_theta_uw = ((temp_ref-Told(j))/(temp_ref+273.15))**beta
         d_T_theta_uw = theta_0_2*beta*d_T_theta_uw/&
                        (temp_ref - Told(j))
      END IF

      exponentlatent = theta_uw/theta_0_2

      c_eff_2 = c2frozen*(1.0-exponentlatent) + &
      c2unfrozen*exponentlatent
      
      k_eff_2 = k2frozen**(1.0-exponentlatent) * &
      k2unfrozen**exponentlatent

      Tnew(j) = Told(j) + k_eff_2*dt*rdz2*(Told(j+1) - 2.0*Told(j) + &
      Told(j-1))/(c_eff_2*rho2 + latentheat*d_T_theta_uw)

      IF(j.EQ.indexl2+1) THEN
         c_int_2_p = c_eff_2
         k_int_2_p = k_eff_2
      END IF

   END DO

!UPDATE TEMPERATURE AT LAST NODE

   Tnew(Nz) = Tnew(Nz-1)

!SWAP THE TWO VECTORS

   Told = Tnew


END DO

PRINT*,'-----------------------------------'
PRINT*,'--------END FINAL YEAR',m,'--------'
PRINT*,'-----------------------------------'

END DO

CLOSE(27)

CALL CPU_TIME(t2)



END PROGRAM temp
