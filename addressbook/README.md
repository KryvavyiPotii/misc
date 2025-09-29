# Bourne Shell Exercise

## Addressbook

Okay, it's boring, but here's your exercise for today:
Create an addressbook program using the bourne or bourne-again shell.
It should use functions to perform the required tasks. It should be menu-based, allowing you the options of:

* Search address book
* Add entries
* Remove / edit entries

You will also need a "display" function to display a record or records when selected.

### Search

When the user searches for "Smith", the script should identify and display all "Smith" records. It is up to you whether this search is in Surname only, or in the entire record.

### Add

Input the data (Name, Surname, Email, Phone, etc).
If it appears to be a duplicate, for bonus points offer to edit the existing record.
Save the record into the data file when the user confirms.

### Remove

Enter search criteria, narrow it down to one, confirm, then remove that record.
Edit
As remove, but use the existing record for default entries.
For example, if you change the phone number, the session may look like this, if you only want to change John Smith's Phone Number:

          Name [ John Smith ]
          Phone [ 12345 ] 54321
          Email [ joe@smith.org.uk ]

Remove the old record, and add the new one. Alternatively, edit the existing record, though this may be more difficult.

### Bonus Points

* Allow for cancel options (use "special" entries (^d, CR, ^c, etc))
* Add "Confirm" option.
* Offer interactive / non-interactive modes. (ie, a menu-based version and a command-line (CLI)-based option.
* Play with getopt for CLI version.

### Hints / Things to think about

* Suggested record format: Use colons to separate fields.
* John Smith:54321:john@smith.example.com
* That way you can use "cut -d:" to read fields.
* Think about using IFS as an alternative to this method.
* Think about using space (" ") to separate fields, and convert any spaces in the input to underscores ("_") then convert them back again for display.


# Source

[The Shell Scripting Tutorial](https://www.shellscript.sh/exercises.html)
