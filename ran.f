c---------------------------------------------------------------------------
        function ran0(idum)
c       'Minimal' random generator of Park and Miller
c       Returns a uniform random deviate between 0 and 1.
c       Set or reset idum to any integer value (except the unlikely value Mask)
c       to inizialise the sequence; idum must not be altered between calls for successive
c       deviates in a sequence
c       from: Numerical Recipes, p. 270
c---------------------------------------------------------------------------
      implicit none
        integer idum, IA, IM, IQ, IR, Mask
        real*8 ran0, AM
        parameter ( IA=16807, IM=2147483647, AM=1.D0/IM, 
     &              IQ= 127773, IR=2836, Mask=123459876 )
        integer k
c---------------------------------------------------------------------------
        idum=ieor(idum,Mask)
        k=idum/IQ
        idum=IA*(idum-k*IQ) - IR*k
        if (idum.lt.0) idum=idum+IM
        ran0=AM*idum
        idum=ieor(idum,Mask) 
        return
      end 

c----------------------------------------------------------------------
      FUNCTION ran2(idum)
      implicit none
      INTEGER idum,IM1,IM2,IMM1,IA1,IA2,IQ1,IQ2,IR1,IR2,NTAB,NDIV
      REAL ran2,AM,EPS,RNMX
      PARAMETER (IM1=2147483563,IM2=2147483399,AM=1./IM1,IMM1=IM1-1,
     *IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211,IR2=3791,
     *NTAB=32,NDIV=1+IMM1/NTAB,EPS=1.2e-7,RNMX=1.-EPS)
      INTEGER idum2,j,k,iv(NTAB),iy
      SAVE iv,iy,idum2
      DATA idum2/123456789/, iv/NTAB*0/, iy/0/
      if (idum.le.0) then
        idum=max(-idum,1)
        idum2=idum
        do 11 j=NTAB+8,1,-1

          k=idum/IQ1
          idum=IA1*(idum-k*IQ1)-k*IR1
          if (idum.lt.0) idum=idum+IM1
          if (j.le.NTAB) iv(j)=idum
11      continue
        iy=iv(1)
      endif
      k=idum/IQ1
      idum=IA1*(idum-k*IQ1)-k*IR1
      if (idum.lt.0) idum=idum+IM1
      k=idum2/IQ2
      idum2=IA2*(idum2-k*IQ2)-k*IR2
      if (idum2.lt.0) idum2=idum2+IM2
      j=1+iy/NDIV
      iy=iv(j)-idum2
      iv(j)=idum
      if(iy.lt.1)iy=iy+IMM1
      ran2=min(AM*iy,RNMX)
      return
      end
