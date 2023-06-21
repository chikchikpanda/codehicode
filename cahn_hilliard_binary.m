clear
clc
format long
N=256;        %mesh-size
M=256;        %mesh-size
del_x = 1;    %x-grid size
del_y = 1;    %y-grid size
del_t = 1.5;  %time-step size
ntmax = 500;  %total number of time steps
A = 1.0;      %Free energy barrier
Mob=1.0;      %mobility
kappa=25;     %gradient energy coefficient
c_0 = 0.5;    %initial composition
noise_str = randn(N,M); %random fluctuations for initial state
for i=1:N,
for j=1:M,
comp(j+M*(i-1))=c_0+noise_str(i,j)*(0.2); %initial state
end;
end;
half_N=N/2; %for imposing PBC
half_M=M/2; %for imposing PBC
del_kx=(2.0*pi)/(del_x*N);
del_ky=(2.0*pi)/(del_y*M);
for index=1:ntmax, %looping till total time steps
for i=1:N,
for j=1:M,
g(j+M*(i-1))=2*A*comp(j+M*(i-1))*(1-comp(j+M*(i-1)))*(1-2*comp(j+M*(i-1))); %free energy functional,g=2Ac(1-c)(1-2c)
end;
end;
f_comp=fft(comp); %taking composition in fourier space
f_g=fft(g);       %taking free energy in fourier space
%periodic boundary condition in x-direction
for i1=1:N,
if i1<half_N,
kx=(i1-1)*del_kx;
else
kx=(i1-N-1)*del_kx;
end;
kx2=kx*kx; %Reciprocal lattice vector in x-space
%periodic boundary condition in y-direction
for i2=1:M,
if i2<half_M,
ky=(i2-1)*del_ky;
else
ky=(i2-M-1)*del_ky;
end;
ky2=ky*ky; %Reciprocal lattice vector in y-space
k2=kx2+ky2; %Reciprocal lattice vector
k4=k2*k2; %Reciprocal lattice vector squared
denom=1.0+2.0*kappa*k4*del_t;
f_comp(i2+M*(i1-1))=(f_comp(i2+M*(i1-1))-k2*del_t*Mob*f_g(i2+M*(i1-1)))/denom;  %finding the next composition
end;
end;
comp=real(ifft(f_comp));   %Taking the compositions back to real space
%disp(comp);               %displaying the compositions
disp(index);               %displaying index no.
 %Taking the compositions to a matrix of size N*M
for i=1:N,
for j=1:M,
U(i,j)=comp(j+M*(i-1));
end;
end;
%constructing a pseudocolor plot for evolved compositions
pcolor(U)
colormap;
shading interp;
colorbar;
end;
