clc
clear all
close all

%% delete
delete( '*.asv')

%% parameter

tx = 1.0;
ty = 1.0;

Lx = 1.0;
Ly = 1.0;
Nx = 30;
Ny = 30;
dt = 1e-2;
tmax = 20;
alpha_v = 0.5;                          %% α: 0.5:クランク-ニコルソン法，0:陰解法，1:陽解法 [-]


x_vec = linspace( 0, Lx, Nx);
y_vec = linspace( 0, Ly, Ny);
dx = mean( diff( x_vec));
dy = mean( diff( y_vec));


u01 = ( sin( x_vec*pi/Lx).'*sin( y_vec*pi/Ly) ).^3;
u0 = reshape( u01, Nx, []);

%u0=zeros(m,1);
%u0(m/m)=1;

%% 行列組み立て


Dx2 = 1/(dx^2)*( diag(-2*ones(1,Nx)) + diag( ones(1,Nx-1), 1) + diag( ones(1,Nx-1), -1) );
Dy2_mat = 1/(dy^2)*( diag(-2*ones(1,Nx*Ny)) + diag( ones(1,Nx*Ny-Nx), Nx) + diag( ones(1,Nx*Ny-Nx), -Nx) );


Dx2_mat = [];  
for i=1:Ny;
    Dx2_mat = blkdiag( Dx2_mat, Dx2);
end

Dx2_mat = sparse( Dx2_mat);
Dy2_mat = sparse( Dy2_mat);

C = [  speye(Nx*Ny)                                     -dt/2*speye(Nx*Ny);
        -(1 - alpha_v)*dt*(tx*Dx2_mat + ty*Dy2_mat)   	speye(Nx*Ny)];
    
E = [  speye(Nx*Ny)                                     dt/2*speye(Nx*Ny);
        alpha_v*dt*(tx*Dx2_mat + ty*Dy2_mat)            speye(Nx*Ny)];
    

invC_E = C\E;    
    
%% 時間発展   
   
time=0:dt:tmax;

hx = zeros(2*Nx*Ny,length( time));

u = zeros(2*Nx*Ny,1);
u(1:Nx*Ny) = u0;
ii = 1;
for t = time
    
    if mod( ii, 2) == 0
        disp(t)
    end
    
    u = invC_E*u;
  
    hx(:,ii) = u;
    ii=ii+1;
end

%% save

save ./save/NUM_DATA
