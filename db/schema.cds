namespace sap.capire.bookshop;
using { Currency, managed, cuid } from '@sap/cds/common';
using { sap.capire.products.Products } from '../products';

entity Books : managed {
  key ID : Integer;
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  stock  : Integer;
  price  : Decimal(9,2);
  currency : Currency;
}

entity Magazines : Products {
    publisher: String;
}

entity Authors : managed {
  key ID   : Integer;
  name     : String(111);
  books    : Association to many Books on books.author = $self;
}

entity Orders : cuid, managed {
  OrderNo  : String @title:'Order Number'; //> readable key
  Items    : Composition of many OrderItems on Items.parent = $self;
  total    : Decimal(9,2) @readonly;
  currency : Currency;
}
entity OrderItems : cuid {
  parent    : Association to Orders;
  book      : Association to Books;
  amount    : Integer;
  netAmount : Decimal(9,2);
}

entity Movies: additionalInfo {
    key ID: Integer;
    name: String(1111);
}


aspect additionalInfo{
    genre: String(100);
    language: String(200);
}