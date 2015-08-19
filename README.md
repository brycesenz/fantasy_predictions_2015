### Fantasy Predictions
Building predictive models for Fantasy Football

### Database Migrations

DB Migration Commands:

* `rake db:create`
* `rake db:migrate`
* `rake db:drop`

### Other

You can run the root file to show it works

```
ruby fantasy_predictions
```

Output:
> Count of Players: 0

Lastly, you can IRB it to do stuff:

$ irb

```
>> require "./fantasy_predictions"
=> true
>> Player.new
=> #<Player id: nil, position: nil>
>> Player.create position: "QB"
=> #<Player id: 1, position: "QB">
```