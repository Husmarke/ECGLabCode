%% plot ECG
clc, clear

rawDataS = readtable('C:\Users\ellio\Desktop\Data EKG Labb\Stine EKG.xlsx');

dataArray = table2array(rawDataS); % converts the table to 2d array
Ts = 1/50; % time signature (sampling frequency)
t = 0:Ts:10-Ts; % how many seconds the experiment took 

x = []*height(dataArray); % deklares an empty array with the size of the data

for i=1:height(dataArray)
    x(i)=dataArray(i, 2); % inserts one of the collumns from the table into the new array
end

plot(t, x); % plots the ECG
legend("ECG") % adds a legend
xlabel("Time (s)") % labels the x-axis
ylabel("Amplitude (mv)")% labels the y-axis



%% trend Gain
clc, clear

rawData = readtable("C:\Users\ellio\Desktop\Data EKG Labb\Gain.xlsx", "VariableNamingRule","preserve"); %fetches the data

plot(rawData, "Frequency [Hz]", "Gain", "Marker","o"); % plots data
legend("Gain") % adds legend

%% fourier
clc, clear

rawData = readtable('C:\Users\ellio\Desktop\Data EKG Labb\Stine EKG.xlsx');



Ts = 1/50; % time signature (sampling frequency)
t = 0:Ts:10-Ts; % how many seconds the experiment took 
dataArray = table2array(rawData); % converts the table to 2d array


x = []*length(dataArray); % deklarerar en tom array

for i=1:length(dataArray)
    x(i)=dataArray(i, 2); % sätter in en kollumn för att få en array istället
end


y = fft(x); % fast fourier transform
fs = 1/Ts; % inverterade tidssignaturen
f = (0:length(y)-1)*fs/length(y); % längden på frekvenssprektumet

n = length(x); % längden av x
power = abs(y).^2/n; % filterar ut brus

subplot(2, 2, 1);% subplots
plot(f, abs(y));% plot of frequency spectrum 
xlim([-0.5, 50.5]);% adjusts the axis length
title("fourier");% title
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(2, 2, 2);
plot(f, power); % plot of frequency spectrum ^2
xlim([-0.5, 50.5]); % adjusts the axis length
title("filtered fourier");% title
xlabel("Frequency (Hz)");
ylabel("Magnitude");
% removing the extremes of the transforms

newY = []*500;
newPower = []*500;

margin = 2; % what frequencies to remove

for i=1: 500
    if i > 1+margin && i < 500-margin % the values to keep
        newY(i) = y(i);
        newPower(i) = power(i);
    else
        newY(i) = 0; % else dont add anything
        newPower(i) = 0;
    end
end

%plotting the trimmed transforms
subplot(2, 2, 3);
plot(f, abs(newY));% plot of frequency spectrum with extremes removed 
xlim([0, 50]);% adjusts the axis length
title("trimmed fourier");% title
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(2, 2, 4);
plot(f, newPower);% plot of frequency spectrum ^2 with extremes removed
xlim([0, 50]);% adjusts the axis length
title("Trimmed & filtered Fourier"); % title
xlabel("Frequency (Hz)");
ylabel("Magnitude");
