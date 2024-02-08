select
    personal,
    family
from staff
where personal like '%ya%' or family glob '*De*';
