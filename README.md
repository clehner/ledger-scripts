ledger-scripts
==============

A collection of scripts for helping to organize one's finances using
[ledger](ledger-cli.org),
with a focus on crypto-currencies.

© 2013-2016 Charles Lehner, [MIT License](http://cel.mit-license.org/)

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

Combines transfers between accounts, and allows for arbitrary renaming of
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
Import transaction history from an Electrum wallet.

Reads a CSV file exported from Electrum.

#### `blockchain2ledger`
Import transactions from a blockchain.info export.

#### `havelock2ledger`
Import transactions from a Havelock Investments account.

#### `campbx2ledger`
Import transaction history for a CampBX account.

#### `cryptotrade2ledger`
Import transaction history for a Crypto-Trade account.

To obtain the TSV data to import, visit the
[transactions page](https://crypto-trade.com/member/transactions), and for each
page of results, copy and paste the table into a text file such that each row
from the table is in its own line, with the values in the cells separated by tabs.

#### `paypal2ledger`
Import full PayPal CSV transactions history (including shopping carts).
Currently this script is buggy so the results have to be manually fixed.

#### `ethereum2ledger`
Import Ethereum transaction history for an address, using etherscan.io's API.
Depends on jq.

#### Coinbase

Two scripts are provided for processing two types of CSV files that Coinbase
exports. For best results, run both, merge the results, and then reconcile it
with the online transaction history.

* `coinbase2ledger-transactions`

Import transactions (`Coinbase-Transactions-Export...csv`). This contains every
buy, sell, send and receive in the account, but the fee amounts for the buy and
sell transactions are not always provided, and the BTC amount for buy and sell
transactions is not always accurate. The bitcoin transaction IDs are usually
included.

* `coinbase2ledger-transfers`

Import transfers/trades (`Coinbase-Transfers-Export...csv`)

This one has full fee details and exact BTC amounts for each buy/sell transfer,
but does not include other transactions sent and received from the account.

More scripts
------------

#### `getquote.pl`

Get quotes for various stocks, currencies, and commodities. Written in Perl and depends on some perl modules.

Covers:

BTC, altcoins, gold, silver, Havelock Investments, CryptoStocks,
NASDAQ, and sovereign currencies.

#### `getquote.sh`

Get quotes for things. Written in POSIX shell. Depends on curl and jq.
Currently it does not support as many tickers as `getquote.pl` does.

#### `gethistoric`

Get past quotes for BTC/USD, using BitcoinAverage's API.

#### `claws-filter`

Detect transactions in incoming emails through the Claws Mail client and write
them to a ledger journal.

Handles:

* Dividends received from Havelock and Cryptostocks.

* Payments sent from Paypal, Dwolla, and Coinbase.

#### `merge-ledger`

Merge multiple ledger journals into one, in roughly time order. It prompts you to
merge transactions between journals that might be the same.

*Not completely working*

#### `ledger-combine`

Merge multiple ledger journals into one, in time order, without detecting
duplicates.

#### `usd-bonds-interest`

Retrieve accrued interest on US Treasury savings bonds. This script queries the
[Savings Bond Calculator][sbc] on the TreasuryDirect website and looks up the
difference in total value of some bonds between two dates. To use the script
you have to set an environmental variable `BONDS_QUERY` to the query string you
would submit to the savings bond calculator. To figure out what value to use
for the query string, do the following:

- Go to the [Savings Bond Calculator][sbc] page
- Add the bonds using the form
- Right click somewhere in the form and choose "Inspect Element" to open the
  web inspector
- Find the `<form>` element in the web inspector
- Change the `method` attribute of the `<form>` from `post` to `get`
- Close the web inspector
- Submit the form using the View or Save button
- Get the URL of the resulting page. Copy the query string starting at
  `Series=` (not including `RedemptionDate=...&`)
- Set the env var to the copied query string e.g. by executing `export
  BONDS_QUERY="..."`
- Now you can run the script, e.g. `ust-bonds-interest 11/2015 12/2015` to get
  interested accrued between 11/2015 and 12/2015.

[sbc]: http://www.treasurydirect.gov/BC/SBCPrice

*TODO: automate more of this*

Similar projects
----------------

* [ledger-bitcoin](https://github.com/profmaad/ledger-bitcoin) by
[profmaad](https://github.com/profmaad)

    * electrum2ledger
    * bitstamp2ledger

* [mint-to-ledger](https://github.com/shiinee/mint-to-ledger) by
  [shiinee](https://github.com/shiinee/mint-to-ledger)

