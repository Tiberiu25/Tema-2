P=40; %P este perioada semnalului
D=23; %D este durata impulsului
rez=1/10; % rez este rezolutia stabilita pentru o mai buna vizibilitate a semnalului
omega=2*pi/P; %omega este pulsatia semnalului
k=-50:50;
timp=0:rez:160-rez; 
Semnal=[ones(1,D/rez),zeros(1,(P-D)/rez),ones(1,D/rez),zeros(1,(P-D)/rez),ones(1,D/rez),zeros(1,(P-D)/rez),ones(1,D/rez),zeros(1,(P-D)/rez)];
%Am utilizat functiile ones si zeros deoarece semnalul dreptunghiular ia
%valori de 1 sau de 0

syms t 
x=0; 
coef0=int(power( exp(1),-j*x*omega*t),t,0,D);%coeficientul fundamental
y=1:50;
coefpoz= int(power( exp(1),-j*y*omega*t),t,0,D);%coeficientii pozitivi
z=-50:-1; 
coefneg=int(power( exp(1),-j*z*omega*t),t,0,D);%coeficientii negativi

Coeficienti=[coefneg,coef0,coefpoz];
coefneg=double(coefneg);
coefpoz=double(coefpoz);
coef0=double(coef0);
Coeficienti=double(Coeficienti);
%Am utilizat double pentru a avea un timp de executie mai scazut

SemnalRefacut=coef0/P;
for i=1:50
SemnalRefacut=SemnalRefacut+2*coefpoz(i)*power(exp(1),1j*i*omega*timp)/P;
%Am adunat coeficientii pentru a reface semnalul
%Coeficentii cu expodetiala negativa nu se afiseaza 
end

figure(1) %In figura 1 este reprezentat semnalul initial si semnalul refacut suprapus
plot(timp,Semnal), grid, hold on , plot(timp,SemnalRefacut,'.')
title('x(t) (Linie solida) si semnalul reconstruit cu 50 de coeficienti (Linie punctata)')
hold off;

figure(2) %In figura 2 este reprezentat spectrul de amplitudini al semnalului x(t)
stem(k,abs(Coeficienti)),grid , title('Spectrul lui x(t)');