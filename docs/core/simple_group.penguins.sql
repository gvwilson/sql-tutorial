select avg(body_mass_g) as average_mass_g
from penguins
group by sex;
