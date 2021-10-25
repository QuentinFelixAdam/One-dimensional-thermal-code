# This is an commentary line in a makefile
# Start of the makefile
objects = m_glob.o temp.o sub_init.o sub_readpara.o sub_annex.o
exe: $(objects)
	f90 -o exe $(objects)
m_glob.mod: m_glob.o m_glob.f90
	f90 -fast -c m_glob.f90
m_glob.o: m_glob.f90
	f90 -fast -c m_glob.f90
temp.o: m_glob.mod temp.f90
	f90 -fast -c -xopenmp  temp.f90
sub_init.o: sub_init.f90
	f90 -fast -c sub_init.f90
sub_readpara.o: sub_readpara.f90
	f90 -fast -c sub_readpara.f90
sub_annex.o: sub_annex.f90
	f90 -fast -c sub_annex.f90
clean:
	rm $(objects) exe m_glob.mod
# End of the makefile
