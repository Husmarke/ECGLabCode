%% plot EKG Elliot
clc, clear

rawDataE = readtable('C:\Users\ellio\Desktop\Data EKG Labb\Elliot EKG.xlsx');
rawDataS = readtable('C:\Users\ellio\Desktop\Data EKG Labb\Stine EKG.xlsx');

dataArray = table2array(rawDataS); % omvandlar tabellen till en 2d array
Ts = 1/50;
t = 0:Ts:10-Ts; % hur många sekunder som försöket tog

x = []*height(dataArray); % deklarerar en tom array

for i=1:height(dataArray)
    x(i)=dataArray(i, 2); % sätter in en kollumn för att få en array istället
end

subplot(2, 1, 1)
plot(t, x);
title("Stine")
legend("ECG")
xlabel("Time (s)")
ylabel("Amplitude (mv)")

subplot(2, 1, 2);
plot(rawDataE, "Index", "Amplitude");
title("Elliot")
legend("ECG")


%% trend Gain
clc, clear

rawData = readtable("C:\Users\ellio\Desktop\Data EKG Labb\Gain.xlsx", "VariableNamingRule","preserve");

plot(rawData, "Frequency [Hz]", "Gain", "Marker","o");
legend("Gain")
title("Gain of circuit")
%% test fourier/filtering (extra)
clc, clear


Ts = 1/50; % tidsignatur (sampling frekvens)
t = 0:Ts:10-Ts; % ööver hur lång tid som vi mätte indelad i segment baserade på Ts
x = sin(2*pi*15*t) + sin(2*pi*20*t); % funktion som vi kollar på

y = fft(x); % fast fourier transform
fs = 1/Ts; % inverterade tidssignaturen
f = (0:length(y)-1)*fs/length(y); % längden på frekvenssprektumet

hold on
subplot(2, 1, 1);
plot(t, x);

subplot(2, 1, 2);
plot(f, abs(y)) % plot över frekvensspektrument

hold off

%% fourier
clc, clear

rawData = readtable('C:\Users\ellio\Desktop\Data EKG Labb\Elliot EKG.xlsx');



Ts = 1/50; % tidssiganatur(sampling frekvens)
t = 0:Ts:10-Ts; % hur många sekunder som försöket tog
dataArray = table2array(rawData); % omvandlar tabellen till en 2d array
% disp(dataArray())

x = []*length(dataArray); % deklarerar en tom array

for i=1:length(dataArray)
    x(i)=dataArray(i, 2); % sätter in en kollumn för att få en array istället
end


y = fft(x); % fast fourier transform
fs = 1/Ts; % inverterade tidssignaturen
f = (0:length(y)-1)*fs/length(y); % längden på frekvenssprektumet

n = length(x); % längden av x
power = abs(y).^2/n; % filterar ut brus

subplot(2, 2, 1);
plot(f, abs(y));
axis([0, 50, 0, 50]);
title("Fourier");

subplot(2, 2, 2);
plot(f, power); % plot över frekvensspektrumet 
axis([0, 50, 0, 5]);
title("filtered");

% removing the extremes of the transforms

newY = []*500;
newPower = []*500;

for i=1: 500
    if i > 40 && i < 460
        newY(i) = y(i);
        newPower(i) = power(i);
    else
        newY(i) = 0;
        newPower(i) = 0;
    end
end

%plotting the trimmed transforms
subplot(2, 2, 3);
plot(f, abs(newY));
axis([0, 50, 0, 50]);
title("Trimmed fourier");


subplot(2, 2, 4);
plot(f, newPower);
axis([0, 50, 0, 1]);
title("Trimmed filtered");

