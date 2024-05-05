clc
clear all
close all

%% delete
delete( '*.asv')

%% path
addpath ./ToolBoxes/mmwrite

%% load
load ./save/NUM_DATA

%% generate matrix

Dx = 1/(2*dx)*( diag( ones(1,Nx-1), 1) - diag( ones(1,Nx-1), -1) );
Dy_mat = 1/(2*dy)*( diag( ones(1,Nx*Ny-Nx), Nx) - diag( ones(1,Nx*Ny-Nx), -Nx) );


Dx_mat = [];  
for i=1:Ny;
    Dx_mat = blkdiag( Dx_mat, Dx);
end


%% plot

h_fig(1) = figure(1);
set( h_fig(1), 'Position', [100 100 1000 800])

hplot = surf( x_vec, y_vec, u01.', 'FaceColor', 'interp', 'LineStyle', '-');
caxis( [-1 1])
lighting phong
light
axis image
zlim( [ -1. 1.])
xlabel( 'X position [m]')
ylabel( 'Y position [m]')
zlabel( 'Z position [m]')
view( [ -1 1 1])

ii=1;
i_movie = 1;
movie_data = struct( 'cdata', [], 'colormap', []);
E_t = zeros(length( time),1);
for t=time


    u = hx(:,ii);

    uxy1 = u(1:Nx*Ny); 
    uxy2 = u(Nx*Ny+1:end); 

    uxy = reshape( uxy1, Nx, []).';
    set( hplot, 'ZData', uxy)

    %% ƒGƒlƒ‹ƒMŒvŽZ
    dE = 1/2*( uxy2.^2 + tx*(Dx_mat*uxy1).^2 + ty*(Dy_mat*uxy1).^2 );
    dExy = reshape( dE, Nx, []).';
    E_t(ii) = trapz( x_vec, trapz( y_vec, dExy, 1), 2);

    
    
    movie_data(i_movie) = getframe( h_fig(1));
    i_movie = i_movie+1;
    
    drawnow


    ii=ii+1;
end

%% plot Energy
h_fig(2) = figure(2);

plot( time, E_t)
xlabel( 'Time [-]')
ylabel( 'Energy [-]')
ylim( [0 1.5*max( E_t)])


%% save

video.frames = movie_data;
video.width=size( video.frames(1).cdata, 2);
video.height=size( video.frames(1).cdata, 1);
video.times = time;

mmwrite( './save/data.wmv', video)


fig_name = { 'behavior', 'Energy'};

for ii = 1:length( fig_name)
    
    saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.fig'])
end
    
    

