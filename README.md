# Branch LAB1:
Задание 1:
Запустите Microsoft SQL Server Management Studio (Start → All Programs → Microsoft SQL Server 2012 → SQL Server Management Studio). Убедитесь, что в окне Connect to Server выбрано Windows Authentication в поле Authentication. Нажмите кнопку Connect.
В Object Explorer разверните и просмотрите список установленных баз.
На панели инструментов нажмите кнопку  или нажмите Ctrl+N.
В открывшемся окне, напишите запрос на создание новой базы данных с именем NewDatabase используя инструкцию CREATE DATABASE:
CREATE DATABASE NewDatabase;
Чтобы запустить код на выполнение нажмите кнопку  на панели инструментов или клавишу F5.
Следующее сообщение говорит о том, что код был успешно выполнен:
Сообщение, выданное красным цветом, говорит о том, что в процессе выполнения произошла ошибка. Например:
В Object Explorer нажмите кнопку Refresh  и убедитесь, что новая база данных отображается в списке баз данных:
Вернитесь в окно редактора запроса, чтобы создать новую схему.
Запрос в SQL Server выполняется в рамках определенной базы данных. Её имя можно найти на панели инструментов.
На рисунке выбрана база данных master, которая является системной базой данных. Чтобы создать новую схему в NewDatabase, а не в master, вам необходимо изменить имя рабочей базы данных на NewDatabase. Для этого вы можете выбрать эту базу данных из списка на панели инструментов:
Либо использовать оператор USE в своем запросе:
USE NewDatabase;
GO
Команда GO говорит об окончании пакета инструкций T-SQL.
Создайте новую схему с помощью инструкции CREATE SCHEMA:
CREATE SCHEMA sales;
Для того, чтобы отправить на выполнение не весь код в редакторе запросов, а только какую-то его часть – выделите необходимый набор операторов:
Нажмите F5. На выполнение будет отправлен только выделенный вами код.
Создайте еще одну схему с именем persons.
В окне Object Explorer нажмите кнопку Refresh и убедитесь, что созданные вами схемы отображаются в списке доступных схем базы данных:
Каждая таблица в базе данных SQL Server должна принадлежать определенной схеме. Таблицы, созданные без указания схемы, будут созданы в схеме dbo.
Создайте новую таблицу в схеме sales с именем Orders, содержащей одно поле OrderNum, тип данных которого INT:
CREATE TABLE sales.Orders (OrderNum INT NULL);
Сохраните созданный вами запрос в файловой системе (File → Save SQLQuery1.sql as … ).
Создайте бэкап базы данных NewDatabase используя инструкцию BACKUP DATABASE и сохраните его в файловой системе.
Удалите базу данных используя инструкцию DROP DATABASE.
Восстановите базу данных NewDatabase из сохраненного бэкапа используя инструкцию RESTORE DATABASE.

Задание 2:
Вывести на экран список отделов, принадлежащих группе ‘Research and Development’, отсортированных по названию отдела в порядке A-Z.
Вывести на экран минимальное количество оставшихся больничных часов у сотрудников. Назовите столбец с результатом ‘MinSickLeaveHours’.
Вывести на экран список неповторяющихся должностей в порядке A-Z. Вывести только первые 10 названий. Добавить столбец, в котором вывести первое слово из поля [JobTitle].

# Branch LAB2:
Задание 1:
Вывести на экран время работы каждого сотрудника.
Вывести на экран количество сотрудников в каждой группе отделов.
Вывести на экран почасовые ставки сотрудников, с указанием максимальной ставки для каждого отдела в столбце [MaxInDepartment]. В рамках каждого отдела разбейте все ставки на группы, таким образом, чтобы ставки с одинаковыми значениями входили в состав одной группы.
Задание 2:
a) создайте таблицу dbo.Employee с такой же структурой как HumanResources.Employee, кроме полей OrganizationLevel, SalariedFlag, CurrentFlag, а также кроме полей с типом hierarchyid, uniqueidentifier, не включая индексы, ограничения и триггеры;
b) используя инструкцию ALTER TABLE, создайте для таблицы dbo.Employee ограничение UNIQUE для поля NationalIDNumber;
c) используя инструкцию ALTER TABLE, создайте для таблицы dbo.Employee ограничение для поля VacationHours, запрещающее заполнение этого поля значениями меньшими или равными 0;
d) используя инструкцию ALTER TABLE, создайте для таблицы dbo.Employee ограничение DEFAULT для поля VacationHours, задайте значение по умолчанию 144;
e) заполните новую таблицу данными из HumanResources.Employee о сотрудниках на позиции ‘Buyer’. Не указывайте для выборки поле VacationHours, чтобы оно заполнилось значениями по умолчанию;
f) измените тип поля ModifiedDate на DATE и разрешите добавление null значений для него.
# Branch LAB3:
Задание 1:
a) добавьте в таблицу dbo.Employee поле EmpNum типа int;
b) объявите табличную переменную с такой же структурой как dbo.Employee и заполните ее данными из dbo.Employee. Поле VacationHours заполните из таблицы HumanResources.Employee. Поле EmpNum заполните последовательными номерами строк (примените оконные функции или создайте SEQUENCE);
c) обновите поля VacationHours и EmpNum в dbo.Employee данными из табличной переменной. Если значение в табличной переменной в поле VacationHours = 0 — оставьте старое значение;
d) удалите данные из dbo.Employee, EmailPromotion которых равен 0 в таблице Person.Person;
e) удалите поле EmpName из таблицы, удалите все созданные ограничения и значения по умолчанию.
Имена ограничений вы можете найти в метаданных. Например:
SELECT *
FROM AdventureWorks2012.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Employee';
Имена значений по умолчанию найдите самостоятельно, приведите код, которым пользовались для поиска;
f) удалите таблицу dbo.Employee.
Задание 2:
a) выполните код, созданный во втором задании второй лабораторной работы. Добавьте в таблицу dbo.Employee поля SumTotal MONEY и SumTaxAmt MONEY. Также создайте в таблице вычисляемое поле WithoutTax, вычисляющее разницу между общей суммой уплаченых налогов (SumTaxAmt) и общей суммой продаж (SumTotal).
b) создайте временную таблицу #Employee, с первичным ключом по полю BusinessEntityID. Временная таблица должна включать все поля таблицы dbo.Employee за исключением поля WithoutTax.
c) заполните временную таблицу данными из dbo.Employee. Посчитайте сумму продаж (TotalDue) и сумму налогов (TaxAmt) для каждого сотрудника (EmployeeID) в таблице Purchasing.PurchaseOrderHeader и заполните этими значениями поля SumTotal и SumTaxAmt. Выберите только те записи, где SumTotal > 5 000 000. Подсчет суммы продаж и суммы налогов осуществите в Common Table Expression (CTE).
d) удалите из таблицы dbo.Employee строки, где MaritalStatus = ‘S’
e) напишите Merge выражение, использующее dbo.Employee как target, а временную таблицу как source. Для связи target и source используйте BusinessEntityID. Обновите поля SumTotal и SumTaxAmt, если запись присутствует в source и target. Если строка присутствует во временной таблице, но не существует в target, добавьте строку в dbo.Employee. Если в dbo.Employee присутствует такая строка, которой не существует во временной таблице, удалите строку из dbo.Employee.
# Branch LAB4:
Задание 1:
a) Создайте таблицу Sales.CreditCardHst, которая будет хранить информацию об изменениях в таблице Sales.CreditCard.
Обязательные поля, которые должны присутствовать в таблице: ID — первичный ключ IDENTITY(1,1); Action — совершенное действие (insert, update или delete); ModifiedDate — дата и время, когда была совершена операция; SourceID — первичный ключ исходной таблицы; UserName — имя пользователя, совершившего операцию. Создайте другие поля, если считаете их нужными.
b) Создайте один AFTER триггер для трех операций INSERT, UPDATE, DELETE для таблицы Sales.CreditCard. Триггер должен заполнять таблицу Sales.CreditCardHst с указанием типа операции в поле Action в зависимости от оператора, вызвавшего триггер.
c) Создайте представление VIEW, отображающее все поля таблицы Sales.CreditCard.
d) Вставьте новую строку в Sales.CreditCard через представление. Обновите вставленную строку. Удалите вставленную строку. Убедитесь, что все три операции отображены в Sales.CreditCardHst.
Задание 2:
a) Создайте представление VIEW, отображающее данные из таблиц Sales.CreditCard и Sales.PersonCreditCard. Сделайте невозможным просмотр исходного кода представления. Создайте уникальный кластерный индекс в представлении по полю CreditCardID.
b) Создайте три INSTEAD OF триггера для представления на операции INSERT, UPDATE, DELETE. Каждый триггер должен выполнять соответствующие операции в таблицах Sales.CreditCard и Sales.PersonCreditCard для указанного BusinessEntityID. Обновление должно происходить только в таблице Sales.CreditCard. Удаление строк из таблицы Sales.CreditCard производите только в том случае, если удаляемые строки больше не ссылаются на Sales.PersonCreditCard.
c) Вставьте новую строку в представление, указав новые данные для CreditCard для существующего BusinessEntityID (например 1). Триггер должен добавить новые строки в таблицы Sales.CreditCard и Sales.PersonCreditCard. Обновите вставленные строки через представление. Удалите строки.
# Branch LAB5:
Создайте scalar-valued функцию, которая будет принимать в качестве входного параметра id модели для продукта (Production.ProductModel.ProductModelID) и возвращать суммарную стоимость продуктов данной модели (Production.Product.ListPrice).
Создайте inline table-valued функцию, которая будет принимать в качестве входного параметра id заказчика (Sales.Customer.CustomerID), а возвращать 2 последних заказа, оформленных заказчиком из Sales.SalesOrderHeader.
Вызовите функцию для каждого заказчика, применив оператор CROSS APPLY. Вызовите функцию для каждого заказчика, применив оператор OUTER APPLY.
Измените созданную inline table-valued функцию, сделав ее multistatement table-valued (предварительно сохранив для проверки код создания inline table-valued функции).
# Branch LAB6:
Создайте хранимую процедуру, которая будет возвращать сводную таблицу (оператор PIVOT), отображающую данные о количестве оформленных заказов каждым сотрудником (Purchasing.PurchaseOrderHeader.EmployeeID), доставленных определенным образом (Purchasing.ShipMethod). Список типов доставки передайте в процедуру через входной параметр.
Таким образом, вызов процедуры будет выглядеть следующим образом:
EXECUTE dbo.OrderCountByShipping ‘[CARGO TRANSPORT 5],[OVERNIGHT J-FAST],[OVERSEAS — DELUXE]’
# Branch LAB7:
1) Вывести значения полей [BusinessEntityID], [NationalIDNumber] и [JobTitle] из таблицы [HumanResources].[Employee] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Employees>
  <Employee ID="1">
    <NationalIDNumber>295847284</NationalIDNumber>
    <JobTitle>Chief Executive Officer</JobTitle>
  </Employee>
  <Employee ID="2">
    <NationalIDNumber>245797967</NationalIDNumber>
    <JobTitle>Vice President of Engineering</JobTitle>
  </Employee>
</Employees>
Создать временную таблицу и заполнить её данными из переменной, содержащей xml.
2) Вывести значения полей [ProductID], [Name], [ProductNumber] из таблицы [Production].[Product] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Products>
  <Product ID="1">
    <Name>Adjustable Race</Name>
    <ProductNumber>AR-5381</ProductNumber>
  </Product>
  <Product ID="2">
    <Name>Bearing Ball</Name>
    <ProductNumber>BA-8327</ProductNumber>
  </Product>
</Products>
Создать хранимую процедуру, возвращающую таблицу, заполненную из xml переменной представленного вида. Вызвать эту процедуру для заполненной на первом шаге переменной.
3) Вывести значения полей [BusinessEntityID], [FirstName] и [LastName] из таблицы [Person].[Person] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Persons>
  <Person>
    <ID>285</ID>
    <FirstName>Syed</FirstName>
    <LastName>Abbas</LastName>
  </Person>
  <Person>
    <ID>293</ID>
    <FirstName>Catherine</FirstName>
    <LastName>Abel</LastName>
  </Person>
</Persons>
Создать временную таблицу и заполнить её данными из переменной, содержащей xml.
4) Вывести значения полей [BusinessEntityID], [Name], [AccountNumber] из таблицы [Purchasing].[Vendor] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Vendors>
  <Vendor>
    <ID>1492</ID>
    <Name>Australia Bike Retailer</Name>
    <AccountNumber>AUSTRALI0001</AccountNumber>
  </Vendor>
  <Vendor>
    <ID>1494</ID>
    <Name>Allenson Cycles</Name>
    <AccountNumber>ALLENSON0001</AccountNumber>
  </Vendor>
</Vendors>
Создать хранимую процедуру, возвращающую таблицу, заполненную из xml переменной представленного вида. Вызвать эту процедуру для заполненной на первом шаге переменной.
5) Вывести значения полей [LocationID], [Name] и [CostRate]из таблицы [Production].[Location] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Locations>
  <Location ID="1" Name="Tool Crib" Cost="0.0000" />
  <Location ID="2" Name="Sheet Metal Racks" Cost="0.0000" />
</Locations>
Создать временную таблицу и заполнить её данными из переменной, содержащей xml.
6) Вывести значения полей [CreditCardID], [CardType], [CardNumber] из таблицы [Sales].[CreditCard] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<CreditCards>
  <Card ID="1" Type="SuperiorCard" Number="33332664695310" />
  <Card ID="2" Type="Distinguish" Number="55552127249722" />
</CreditCards>
Создать хранимую процедуру, возвращающую таблицу, заполненную из xml переменной представленного вида. Вызвать эту процедуру для заполненной на первом шаге переменной.
7) Вывести значения полей [ProductID], [Name] из таблицы [Production].[Product] и полей [ProductModelID] и [Name] из таблицы [Production].[ProductModel] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Products>
  <Product ID="680">
    <Name>HL Road Frame - Black, 58</Name>
    <Model ID="6">
      <Name>HL Road Frame</Name>
    </Model>
  </Product>
  <Product ID="706">
    <Name>HL Road Frame - Red, 58</Name>
    <Model ID="6">
      <Name>HL Road Frame</Name>
    </Model>
  </Product>
</Products>
Создать временную таблицу и заполнить её данными из переменной, содержащей xml.
8) Вывести значения полей [AddressID], [City]из таблицы [Person].[Address] и полей [StateProvinceID] и [CountryRegionCode] из таблицы [Person].[StateProvince] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<Addresses>
  <Address ID="532">
    <City>Ottawa</City>
    <Province ID="57">
      <Region>CA</Region>
    </Province>
  </Address>
  <Address ID="497">
    <City>Burnaby</City>
    <Province ID="7">
      <Region>CA</Region>
    </Province>
  </Address>
</Addresses>
Создать хранимую процедуру, возвращающую таблицу, заполненную из xml переменной представленного вида. Вызвать эту процедуру для заполненной на первом шаге переменной.
9) Вывести значения полей [StartDate], [EndDate]из таблицы [HumanResources].[EmployeeDepartmentHistory] и полей [GroupName] и [Name] из таблицы [HumanResources].[Department] в виде xml, сохраненного в переменную. Формат xml должен соответствовать примеру:
<History>
  <Transaction>
    <Start>2003-02-15</Start>
    <Department>
      <Group>Executive General and Administration</Group>
      <Name>Executive</Name>
    </Department>
  </Transaction>
  <Transaction>
    <Start>2002-03-03</Start>
    <Department>
      <Group>Research and Development</Group>
      <Name>Engineering</Name>
    </Department>
  </Transaction>
</History>
Создать временную таблицу, состоящую из 1 колонки и заполнить её xml, содержащимся в тегах Department.
10) Вывести значения полей [FirstName], [LastName] из таблицы [Person].[Person] и полей [ModifiedDate] и [BusinessEntityID] из таблицы [Person].[Password] в виде xml, сохраненного в переменную. Вывести только первые 100 записи из таблицы. Формат xml должен соответствовать примеру:
<Persons>
  <Person>
    <FirstName>Ken</FirstName>
    <LastName>Sánchez</LastName>
    <Password>
      <Date>2003-02-08T00:00:00</Date>
      <ID>1</ID>
    </Password>
  </Person>
  <Person>
    <FirstName>Terri</FirstName>
    <LastName>Duffy</LastName>
    <Password>
      <Date>2002-02-24T00:00:00</Date>
      <ID>2</ID>
    </Password>
  </Person>
</Persons >
Создать хранимую процедуру, возвращающую таблицу, состоящую из 1 колонки и заполняет её xml, содержащимся в тегах Password. Вызвать эту процедуру для заполненной на первом шаге переменной.

