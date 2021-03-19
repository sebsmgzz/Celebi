# Celebi
There are many instances you would wanna restore a database. But what to do when the restore process
is tedious and time consuming because, lets face it, those backup files are giganormous and no one wants
to spend 2 daily hours simple restoring a temporal database for a remaining 6 hours workday, just to go on
and do all over again tomorrow, this is 2021!

Celebi is the autopilot for database restoration processes. As of right now it is powershell and sql based, but there are plans to expand to other platfroms and databases. With Celebi, you can just schedule the restore of your database to happen at, say 1am, so when you are ready to work on those legacy system's bug again, the temporal database is already there for you to break and play with as much as you want without risk of (another) production bug.

Installation
------------
1. Clone this repo to whetever from whetever to want it to be executed
2. Modify the `config.json` configurations file as required [Read more](docs/Configuration)
3. Run the `Install.ps1`
4. Enjoy

Usage
-----
Under the hood Celebi sets up a scheduled task pointing to the actual restore script. So whenever you wanna make a change to the configuration file, you just need to do that, there is no need for additional steps.<br>
After running the restore celebi leaves the powershell terminal open for the next time you log on into your machine, get a notice and a brief review of the restore process.

Credits
-------
Main developer: Sebastán M. Gzz.

License
-------
MIT License

Copyright (c) 2021 sebsmgzz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
