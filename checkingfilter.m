clc ; clear all ; close all ; 
[y , Fs ] = audioread('AudioSignal.wav')  ;
filtered = filter(LP(20000) , y)  ;
sound(filtered , Fs) ; 
% time = (1/Fs)*length(y) ; 
% t = linspace(0,time,length(y)) ; 
% plot(t,filtered) ;  
% handles.player = player  ; 
% play(handles.player) ; 
