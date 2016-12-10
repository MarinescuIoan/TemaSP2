%Tema 2 - Semnale si Programare - numarul din lista = 15, deci vom avea
% un semnal dreptugnhiular cu perioada 40 si N = 50 si durata = 15.

D=15;
N=50;
P=40;
F=1/P;
t=0:0.02:P-0.02; %teorema esantionarii
w0=2*pi*F;

%generez un vector cu zerouri:
x = zeros(1,size(t,2));

%construirea vectorului
x(t<=D)=1;
x(t>D)=-1;
x(t>P-D)=1;

% determinare coeficienti
for k = -N:N
    xt = x;
    xt = xt.*exp(-j*k*w0*t);
    X(k+51) = trapz(t,xt); 
end

%reconstruirea semnalului dat

x_nounout(1:length(t)) = 0; 

for const = 1:length(t);
for k = -N:N
x_nounout(const) = x_nounout(const) + (1/P)*X(k+N+1)*exp(j*k*w0*t(const));
end
end % semnalul dat cu coeficientii seriei

figure(1);
plot(t,x); % afisez mai intai x(t)

title('x(t) si armonicile semnalului esantionat');
hold on

plot(t,x_nounout,'g'); 

xlabel('Timp (s)');
ylabel('Amplitudine');


frecventa = -N*F:F:N*F; % vectorul de frecvente 
figure(2);
stem(frecventa,abs(X)); 
title('Spectrul x(t)');
xlabel('Frecventa (Hz)');
ylabel('|X|');

% Am folosit informatiile din curs despre seriile Fourier ca sume infinite de sinusuri si
% cosinusuri pentru SFT, armonici pentru SFA si exponentiale pentru SFE. Aceste sume pot 
% fi aproximate prin esantionare, pentru a putea fi mai  usor de analizat si fara a produce 
% prea mari erori. Asadar, am reconstruit semnalul cu ajutorul formulelor de la Semnale si
%Sisteme.
