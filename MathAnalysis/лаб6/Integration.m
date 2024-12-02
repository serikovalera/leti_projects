function Answer = Integration(P, w, a,b)
  Answer = 0;
  for q = 1 : length(P)
      if (P(q) ~= 0)
        if (w == 1)
          Answer = Answer + P(q)*(b^(length(P) - q+1) - a^(length(P) - q+1))/(length(P) - q+1);
        elseif (w == -1/2)
          Answer = Answer + P(q)*(b^(length(P) - q)*sqrt(b) - a^(length(P) - q)*sqrt(a))/(length(P) - q + 0.5);
        elseif (w == 1/2)
          Answer = Answer + P(q)*(b^(length(P) - q+1)*sqrt(b) - a^(length(P) - q+1)*sqrt(a))/(length(P) - q + 1.5);
        end
      end
  end
end