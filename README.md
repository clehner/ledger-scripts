ledger-scripts
==============

A collection of scripts for helping to organize one's finances using
[ledger](ledger-cli.org),
with a focus on crypto-currencies.

© 2013 Charles Lehner, [MIT License](http://cel.mit-license.org/)

Data import scripts
-------------------

Convert transactions from various CSV formats into Ledger format.

#### `lbcsv2ledger`
Import LocalBitcoins transactions into ledger.

Parses the "Completed Contacts" CSV file. Automatically calculates the missing
fee.

#### `fidelity2ledger`
Import Fidelity transactions

Handles commodities/funds properly.

#### `mint2ledger`
Import Mint transactions.

Combines transfers between accounts, and allows for abritrary renaming of
transactions.

#### `dwolla2ledger`
Import transactions from a Dwolla statement.

#### `mtgox2ledger`
Import MtGox trading history.

Reads both the USD and BTC CSV files exported from Mt.Gox.

Does not combine corresponding withdraw fees and withdraw debits.

#### `btce2ledger`
Import BTC-E trading history. *Incomplete, but may be useful for a start.*

Reads data that you copy and paste from BTC-E's Transactions history table.

#### `electrum2ledger`
TODO

#### `coinbase2ledger`
TODO

#### `blockchain2ledger`
TODO

#### `havelock2ledger`
TODO

#### `campbx2ledger`
TODO

More scripts
------------

#### `getquote`

Get quotes for various stocks, currencies, and commodities.

Covers:

BTC, altcoins, gold, silver, Havelock Investments, CryptoTrade, CryptoStocks,
and NASDAQ.

#### `claws-filter`

Detect transactions in incoming emails through the Claws Mail client and write
them to a ledger journal.

Handles:

* Dividends received from Havelock and Cryptostocks.

* Payments sent from Paypal, Dwolla, and Coinbase.

#### `merge-ledger`

Merge multiple ledger journals into one, in roughly time order. It prompts you to
merge transactions between journals that might be the same.
