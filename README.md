
# Records - Frozen / Immutable Structs with Copy on Updates

records gem / library - frozen / immutable structs with copy on updates


* home  :: [github.com/s6ruby/records](https://github.com/s6ruby/records)
* bugs  :: [github.com/s6ruby/records/issues](https://github.com/s6ruby/records/issues)
* gem   :: [rubygems.org/gems/records](https://rubygems.org/gems/records)
* rdoc  :: [rubydoc.info/gems/records](http://rubydoc.info/gems/records)


## Usage

Use `Record.new` like `Struct.new` to build / create a new frozen / immutable
record class. Example:

``` ruby

Record.new( :Account,
              balance:    Integer,
              allowances: Hash )

# -or-

Record.new :Account,
              balance:    Integer,
              allowances: Hash

# -or-

Record.new :Account, { balance:    Integer,
                       allowances: Hash }

# -or-

class Account < Record::Base
  field :balance,    Integer
  field :allowances, Hash
end
```


And use the new record class like:

``` ruby
account1a  = Account.new( 1, {} )
account1a.frozen?            #=> true
account1a.values.frozen?     #=> true
account1a.balance            #=> 1
account1a.allowances         #=> {}
account1a.values             #=> [1, {}]

Account.keys                 #=> [:balance, :allowances]
Account.fields               #=> [<Field @key=:balance, @index=0, @type=Integer>,
                             #    <Field @key=:allowances, @index=1, @type=Hash>]
Account.index( :balance )    #=> 0
Account.index( :allowances ) #=> 1
```

Note: The `update` method (or the `<<` alias)
ALWAYS returns new record.

``` ruby
account1a.update( balance: 20 )     #=> [20, {}]
account1a.update( balance: 30 )     #=> [30, {}]
account1a.update( { balance: 30 } ) #=> [30, {}]

account1a << { balance: 20 }        #=> [20, {}]
account1a << { balance: 30 }        #=> [30, {}]

account1b =  account1a.update( balance: 40, allowances: { 'Alice': 20 } )
account1b.balance                   #=> 40
account1b.allowances                #=> { 'Alice': 20 }
account1b.values                    #=> [40, { 'Alice': 20 } ]
# ...
```

And so on and so forth.





## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `records` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
