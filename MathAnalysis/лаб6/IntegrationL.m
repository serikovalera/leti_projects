function Answer = IntegrationL(P)
  Answer = 0;
  for q = 1 : length(P)
      if P(q) ~= 0
        if(q ~= length(P))
          Answer = Answer + P(q)*factorial(length(P) - q); 
        else
          Answer = Answer + 1*P(q);
        end
      end
  end
end