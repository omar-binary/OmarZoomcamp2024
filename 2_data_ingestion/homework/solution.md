```python
data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0.0)]
```

```python
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    
    data.columns = (data.columns.str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True).str.lower()
```

```python
    assert output['vendor_id'] is not None,
    assert output['passenger_count'].isin([0]).sum() == 0,
    assert output['trip_distance'].isin([0]).sum() == 0,
```