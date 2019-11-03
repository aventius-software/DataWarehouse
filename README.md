This is an open source and free to use basic generic SQL Server data warehouse (or it will be ;-)

It mainly consists of the tables, functions, procedures from our blog (https://aventius.co.uk/blog/) articles on data warehousing. We hope you like it and feel free to use anything from it in your own projects. A little link back to this would be appreciated though. Also feel free to fork, send a pull request or log any issues you find.

It has been designed using Visual Studio 2019 and consists of 2 projects:-

DataWarehouse.Database (this is the main SQL database project)

DataWarehouse.UnitTests (this is the unit test project)


Don't forget to deploy the database project to the localdb, otherwise you'll get errors running the tests saying 'function ???' doesn't exist or something like that!


Happy SQL'ing from the folks at Aventius

P.S. There seems to be bug in Visual Studio 2019 (as of 2nd Nov 2019) which has broken unit tests. It is fixed and working in the latest preview version though. Until it is fixed in the non-preview version, for anyone having problems with the unit tests, see this thread below:-

https://developercommunity.visualstudio.com/content/problem/554405/vs-2019-ssdt-error-message-box-cannot-access-a-dis.html
