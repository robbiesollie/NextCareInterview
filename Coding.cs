/*
* define the Book's barcode as AAA-BBB-CCC-DDD such that 
* AAA is the first 3 alphanumeric characters of the book title
* BBB is the first 3 alphanumeric characters of the author's name
* CCC is the number of pages, with leading zeros
* DDD is the number ISBN number, with leading zeros
* 
* And then output the Book's Title with barcode in ascending order according to the barcode.
*/

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

class Program
{
    public class Book
    {
        public string Title { get; set; }
        public string Author { get; set; }
        public int Pages { get; set; }
        public long ISBN { get; set; }
        public Book(string _title, string _author, int _pages, long _isbn)
        {
            Title = _title;
            Author = _author;
            Pages = _pages;
            ISBN = _isbn;
        }

        

        public String Barcode
        {
            get 
            { 
                return Regex.Replace(Title, "\\W", "").Substring(0, 3) 
                    + "-" + Regex.Replace(Author, "\\W", "").Substring(0, 3) 
                    + "-" + Pages.ToString().PadLeft(3, '0') 
                    + "-" + ISBN.ToString().PadLeft(3, '0');
            }
        }
    }

    static void Main(string[] args)
    {
        List<Book> Library = new List<Book>();
        Library.Add(new Book("The Hobbit", "J. R. R. Tolkien", 80, 9780544174221));
        Library.Add(new Book("Harry Potter and the Philosopher's Stone", "J. K. Rowling", 368, 9781408883808));
        Library.Add(new Book("To Kill a Mockingbird", "Harper Lee", 281, 9780060935467));
        Library.Sort(compareBooks);
        foreach(Book b in Library)
        {
            Console.WriteLine(b.Barcode);
        }

    }

    public static int compareBooks(Book x, Book y)
    {
        return x.Barcode.CompareTo(y.Barcode);
    }
}