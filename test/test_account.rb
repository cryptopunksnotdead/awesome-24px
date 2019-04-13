# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_account.rb


require 'helper'


class TestAccount < MiniTest::Test

  Record.build_class( :Account,
                      balance:    Integer,
                      allowances: Hash )
  Account = Record::Type::Account


  Record.new( :Account2,
                 balance:    Integer,
                 allowances: Hash )
  Account2 = Record::Type::Account2


  class Account3 < Record::Base
    field :balance,    Integer
    field :allowances, Hash
  end



  def test_account
    pp Record::Type::Account
    pp Account.ancestors

    puts "Record::Type.constants:"
    pp Record::Type.constants

    account1a  = Account.new( 1, {} )
    assert_equal Account.new( 1, {} ), account1a
    assert_equal true,     account1a.frozen?
    assert_equal true,     account1a.values.frozen?
    assert_equal 1,        account1a.balance
    assert_equal Hash({}), account1a.allowances


    assert_equal Account.new( 20, {} ), account1a.update( balance: 20 )
    assert_equal Account.new( 30, {} ), account1a.update( balance: 30 )
    assert_equal Account.new( 30, {} ), account1a.update( { balance: 30 } )

    assert_equal Account.new( 20, {} ), account1a << { balance: 20 }
    assert_equal Account.new( 30, {} ), account1a << { balance: 30 }
    assert_equal Account.new( 30, {} ), account1a << Hash( { balance: 30 } )
  end


  def test_account2
    pp Record::Type::Account2
    pp Account2.ancestors

    puts "Record::Type.constants:"
    pp Record::Type.constants

    assert_equal [:balance, :allowances], Account2.keys
    # assert_equal [Record::Field.new( :balance,    0, Integer),
    #              Record::Field.new( :allowances, 1, Hash )
    #             ], Account2.fields

    assert_equal 0, Account2.index( :balance )
    assert_equal 1, Account2.index( :allowances )

    account1a  = Account2.new( 1, {} )
    assert_equal Account2.new( 1, {} ), account1a
    assert_equal [1, {}],               account1a.values

    assert_equal Account2.new( 20, {} ), account1a.update( balance: 20 )
    assert_equal Account2.new( 30, {} ), account1a.update( balance: 30 )
    assert_equal [20, {}],               account1a.update( balance: 20 ).values
    assert_equal [30, {}],               account1a.update( balance: 30 ).values


    account1b =  account1a.update( balance: 10, allowances: { '0xaa': 20 } )
    assert_equal Account2.new( 10, { '0xaa': 20 } ), account1b
    assert_equal Hash({ '0xaa': 20 }),               account1b.allowances
  end


  def test_account3
    pp Account3
    pp Account3.ancestors

    puts "Record::Type.constants:"
    pp Record::Type.constants

    account1a  = Account3.new( 1, {} )
    assert_equal Account3.new( 1, {} ), account1a
    assert_equal true, account1a.is_a?( Record )
    assert_equal true, account1a.is_a?( Record::Base )


    assert_equal Account3.new( 20, {} ), account1a.update( balance: 20 )
    assert_equal Account3.new( 30, {} ), account1a.update( balance: 30 )
    assert_equal [30, {}],               account1a.update( balance: 30 ).values

    account1b =  account1a.update( balance: 10 )
    assert_equal Account3.new( 10, {} ), account1b
    assert_equal 10,                      account1b.balance
    assert_equal Hash({}),                account1b.allowances
    assert_equal [10, {}],                account1b.values

    account1b =  account1a.update( balance: 10, allowances: { '0xaa': 20 } )
    assert_equal Hash({'0xaa': 20 }),      account1b.allowances
    assert_equal [10, {'0xaa': 20 }],      account1b.values

    account2 = Account3.new( 2, {} )
    assert_equal Account3.new( 2, {} ), account2
    assert_equal [2, {}], account2
  end

end  # class TestAccount
