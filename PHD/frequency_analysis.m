function fmax = frequency_analysis(time, timestep, cell, xrange, yrange)

    
    % Calculate number of samples
    
    samples = time/timestep;

    
    % Initialise vector to hold results of FFT
    
    fresults = zeros(1, samples);
    
    
    % Perform FFT on correct cell
    
    if(strcmpi(cell, 'E1'))
        
        load E1Rates.dat;
        fresults = fft(E1Rates);
        
    elseif(strcmpi(cell, 'E2'))
            
          load E2Rates.dat;
          fresults = fft(E2Rates);
          
    end
    
    
    % We ony want the real part of the FFT so take absolute magnitude
    
    for idx = 1 : samples
        
        fresults(idx) = abs(fresults(idx));
        
    end
    
    
    % We also want to normalise the FFT to compare different datasets
    
    for idx = 1 : samples
        
        fresults(idx) = fresults(idx)/samples;
        
    end
    
    
    % Create the labelling for the x axis
    
    x = linspace(0, 1, samples/2) * (samples/2);
    
    
    % We only need half the FFT, so only plot the first half
    % Also, the first element of the FFT contains the sum of the Fourier
    % coefficients, so start at element 2.
    
    figure();
    
    plot(x, fresults(2:(samples/2)+1))
    xlim(xrange)
    xlabel('Frequency (Hz)')
    ylim(yrange)
    ylabel('Amplitude')
    title(['Fourier transform of ', cell, ' firing rates'])
    
    saveas(gcf,'fourier','epsc')
	close(gcf)

    
    [~, fmax] = max(fresults(2:(samples/2)+1));
    
end