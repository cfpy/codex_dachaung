function output = fiber_propagation(input,t,L_km)
%% Parameter
%input : Input signal in a.u.
%t     : Sampling time of the input signal 
%L_km  : Channel length in km 

%% Modulation
dt = 1e-12;    %risoluzione temporale
ptx_bit1_dbm = 0; %potenza trasmessa sul bit 1 in dBm
epsilon = 9.7; %rapporto di estinzione lineare approssimato dal valore 9.69

ptx_bit1 = 10^(-3)*10^(ptx_bit1_dbm/10);   %conversione in watt
ptx_bit0 = ptx_bit1 / epsilon; 
%I_tx = ptx_bit0 + input/max(input)*(ptx_bit1-ptx_bit0);
I_tx = input;
tempo_totale = t(end)-t(1); %ampiezza dell'asse temporale
t_s = 0:dt:tempo_totale; %array tempo-continuo
tx = interp1(t,I_tx,t_s);

%% Frequency response of the CHANNEL
lungonda = 1550e-9; %lunghezza d'onda in [m]
c= 3e8; %velocità della luce in [m/s]
%eta_eff = 1.46; %indice di rifrazione del silicio
D= 16.7e-6; %coefficiente di dispersione cromatica definito in [s/(m^2)]
beta2 = -D*((lungonda^2)*2*pi/c) ; %derivata seconda della risposta in fase
alpha_dbkm = 0.2;  %coefficiente di attenuazione [dB/Km]
alpha = (1/4.343)* alpha_dbkm;  %coefficiente attenuazione in [1/Km]

frequenza_totale = 1/dt; %ampiezza asse delle frequenze [Hz]
df= (1/tempo_totale); %passo in frequenza o risoluzione frequenziale [Hz]
freq_diappoggio = -(frequenza_totale/2):df:frequenza_totale/2;
B_f = beta2 *(freq_diappoggio.^2)* L_km * 10^3 ;
Hc_f0 = complex(cos(B_f),sin(B_f));  %ris.freq.canale(complessa) equivalente in b.base A(f)^2 verrà considerato successivamente al canale come attenuazione di potenza riga 165
Hc_f = fftshift(Hc_f0); %shift della risposta in banda monolatera

TX_s = fft(tx); 
RX = TX_s .* Hc_f;  %filtraggio segnale attraverso il canale 
rx = ifft(RX);  %segnale post canale riportato nel dom. temporale
rx_intensity = (abs(rx).^2);  %intesità luminosa 

%% Reception phase, introduction of noise equivalent to TIA
responsivity= 1; % indice conversione [A/W]
NEC= 20e-12; % [A/sqrt(Hz)] Noise Equivality current
Bn= 7.5e9; %banda equivalente del rumore
alpha_specialdbkm = 0; %0.5/6; %coef.di attenuazione in dB/Km with compensation fiber

alpha_slineare = alpha_specialdbkm*(1/ 4.343);
alpha_totale = alpha_slineare + alpha;
A_fspecial = exp((-1/2)*alpha_totale*L_km); %attenuazione che considero a livello di potenza ma non relativamente al canale
%Prx_bit0 = ptx_bit0 * (A_fspecial)^2; %potenza ricevuta nel caso di compensazione
Prx_bit1 = ptx_bit1 * (A_fspecial)^2;  %potenza ricevuta nel caso di compensazione
PI = (rx_intensity) .* Prx_bit1;  %potena istantanea considerando la potenza ricevuta
I = PI * responsivity;  % fotocorrente[A]
sigma= NEC * sqrt(Bn);  %deviazione stand.del filtro t.impedenza
%varianza= sigma.^2;
%w_noise= wgn(1,length(I),varianza,'linear'); %AWGN con varianza sigma.^2
w_noise = sigma*randn(1,length(I)); %wnoise ridefinito con randi

%% Gaussian filter "TIA"
sigmagauss = 1.2e10; %dev.standard calcolata in modo da avere f_taglio a 10GHz
A = 1; %altezza nell'origine della gaussiana

gaussian = A*exp(-(freq_diappoggio).^2 / sigmagauss^2); %definizione gaussiana nel dominio delle frequenze
gaussian_shifted = fftshift(gaussian); %shift della gaussiana a monobanda

%% Signal passing for the TIA and adding noise
rx_awgn= I + w_noise ; %somma del mio segnale al rum.eq. TIA in ingresso
RX_awgn = fft(rx_awgn); %passaggio nel dominio delle freq.
RX_tia = RX_awgn .* gaussian_shifted; %segnale post filtro gaussiano TIA
rx_tia = ifft(RX_tia); %segnale riportato nel tempo

%% Output generation
output = interp1(t_s,rx_tia,t);
%output = interp1(t_s,rx_intensity,t);
%% SNR and EyeDiagram 
% prx_mediateenuata = (Prx_bit1 + Prx_bit0)/2;
% SNR = prx_mediateenuata/sigma^2;
% SNR_dB = 10*log(SNR);
% mu1 = ptx_bit1 * (A_f)^2;
% mu0 = ptx_bit0 * (A_f)^2;
% Q = (mu1 - mu0)/ (2*sigma);
% P_be = qfunc(Q);

%vettoretsimbolo= 0 : dt : tsimbolo;  %Con ciclo For, lento con + di 128bit
% for i= 0 : LEN-1
%      for k= 1:101
%      j=k+(100*i);
%      vettoresupporto(k) = rx_awgn(j);
%      end
%      figure(11);
%      title('EYE-diagram ','color','blue');
%      scatter(vettoretsimbolo,vettoresupporto);
%      hold on;
% end
% clear all;
