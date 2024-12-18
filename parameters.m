clear all; close all 

%definizione parametri DA TABELLA PAPER
%resistenze 
Rr = 6.9; %Ohm
Rs = 6.7; %Ohm 

%induttanze
Lls = 5.3e-3; %Henry (dispersione statorica)
Llr = 12.8e-3; %Henry (dispersione rotorica)
Lm = 614e-3; %Henry (magnetizzante)

Lr = Lm + Llr;%6268e-4; %induttanza totale rotore
Ls = 6544e-4; %induttanza totale dello statore %654.4e-3
%tempo campionamento 
Ts = 0.0001; %10KHz, tempo di campionamento

%%
%definizione dei parametri meccanici ed elettrici del motore ad induzione

%parametri meccanici
Jm = 0.07*6; %coefficiente inerzia (kg*m^2)
Bm = 0.0004*6; %coefficiente di attrito (kg*m^2/s)
P = 1; %numero di coppie polari

%% 
%Voltage source inverter VSI model:

%decomposizione spazio vettoriale
%decoupling transformation matrix 
T = 1/3 * [1, 0, 1, 0, 1, 0; 
    sqrt(3)/2, 1/2, -sqrt(3)/2, 1/2, 0, 1; 
    -1/2, sqrt(3)/2, -1/2, -sqrt(3)/2, 1, 0;
    -sqrt(3)/2, 1/2, sqrt(3)/2, 1/2, 0, 1; 
    -1/2, -sqrt(3)/2, -1/2, sqrt(3)/2, 1, 0;
    0, -1, 0, -1, 0, 1]';

T_inv = inv(T);

%segnali di controllo 
% for i = a:f 
%     Si = randi([0,1]);
% end 
Sa = 0.25;
Sb = 0.5;
Sc = 0.6;
Sd = 0.2;
Se = 0.3;
Sf = 0.58;
S = [Sa, Sb, Sc, Sd, Se, Sf];

%VSI model
M = 1/3 * [2, 0, -1, 0, -1, 0;
    0, 2, 0, -1, 0, -1;
    -1, 0, 2, 0, -1, 0; 
    0, -1, 0, 2, 0, -1;
    -1, 0, -1, 0, 2, 0;
    0, -1, 0, -1, 0, 2] * transpose(S);


%%
%guadagni per controllo nel sottospazio alfa-beta
v_lambda = [0.5 0.5];
lambda = diag(v_lambda);


%guadagni per controllo nel sottospazio x-y
v_gamma = [0.9 0.9];
gamma = diag(v_gamma); 
rho1 = 30; 
rho2 = 30; 
rho = [rho1 0; 0 rho2];
%%
%corrente d fissata
i_ds = 1; %amper 

%%
% guadagni PI
Kp = 9.17;
Ki = 0.027; 
%% 

%costruzione matrici di stato
c1 = Ls*Lr - Lm^2; 
c2 = Lr/c1; 
c3 = 1/Lls; 
c4 = Lm/c1;
c5 = Ls/c1;

%matrice A1
a11 = 1 - Ts*c2*Rs;
%a12 = Ts*c4*Lm*wr;
%a21 = -a12;
a22 = a11;

%A1 = [a11, a12; a21, a22];

%matrice H1
h11 = Ts*c4*Rr;
%h12 = Ts*c4*Lr*wr;
h22 = h11;
%h21 = -h12;

%H1 = [h11, h12; h21, h22];

%matrice A2
a33 = 1 - Ts*c3*Rs;
a44 = a33;

A2 = [a33, 0; 0, a44];

%matrice A3
a51 = -Ts*c4*Rs;
a62 = a51;
% a52 = -Ts*c5*Lm*wr;
% a61 = -a52;
% 
% A3 = [a51, a52; a61, a62];

%matrice H2
h31 = 1-Ts*c5*Rr;
h42 = h31;
% h32 = -c5*wr*Ts*Lr;
% h41 = -h32;
% 
% H2 = [h31, h32; h41, h42];

%matrice B1
b1 = Ts*c2;

B1 = [b1, 0; 0, b1]*4;

%matrice B2
b2 = Ts*c3;

B2 = [b2, 0; 0, b2];

%matrice B3
b3 = -Ts*c4;

B3 = [b3, 0; 0, b3]*4;

%Coefficiente di inerzia
%Jm = 15;
Jm_ = 1/Jm;

%Load Torque
Tl = 2;

%coefficiente di attrito
%Bm = 0.05;


us_alfa = 0;
us_beta = 0;
us_x = 0;
us_y = 0;

n11 = 0;
n12 = 0;
n21 = 0;
n22 = 0;
n32 = 0;
n31 = 0;

%%
%salvataggio parametri
%save('motor_parameters.mat')

%% Aggiunta Matteo

% Rewrite A1 = A1d + A1a
A1d = [a11 0; 0 a22];

a12 = Ts*c4*Lm;
a21 = -a12;
A1a = [0 a12; a21 0];

% Rewrite A3 = A3d + A3a
A3d = [a51 0; 0 a62];

a52 = -Ts*c5*Lm;
a61 = -a52;

A3a = [0 a52; a61 0];

% Rewrite H1 = H1d + H1a
H1d = [h11 0; 0 h22];

h12 = Ts*c4*Lr;
h21 = -h12;
H1a = [0 h12; h21 0];

% Rewrite H2 = H2d + H2a
H2d = [h31 0; 0 h42];

h32 = -Ts*c5*Lr;
h41 = -h32;

H2a = [0 h32; h41 0];

% Magnetic Inductance
M_ind = Lm / 4;

%% Controller Parameters
B1_inv = inv(B1);
B2_inv = inv(B2);
%% Export
save('all_parameters.mat')
