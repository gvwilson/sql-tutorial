## null: SQL from Jupyter

$ pip install jupysql


```python
%load_ext sql
```


```python
%sql sqlite:///data/penguins.db
```


<span style="None">Connecting to &#x27;sqlite:///data/penguins.db&#x27;</span>



```sql
%%sql
select species, count(*) as num
from penguins
group by species;
```


<span style="None">Running query in &#x27;sqlite:///data/penguins.db&#x27;</span>





<table>
    <thead>
        <tr>
            <th>species</th>
            <th>num</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Adelie</td>
            <td>152</td>
        </tr>
        <tr>
            <td>Chinstrap</td>
            <td>68</td>
        </tr>
        <tr>
            <td>Gentoo</td>
            <td>124</td>
        </tr>
    </tbody>
</table>




```python

```
