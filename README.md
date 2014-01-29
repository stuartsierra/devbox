# devbox - my virtual machine provisioning scripts

These files use [Vagrant] to create an instance of a virtual machine
with my preferred software installed on either [VirtualBox] or [AWS].

I publish this repository for **example purposes only**. I do not
recommend using it as-is. Instead, treat it as a source of ideas for
creating your own Vagrant setup.


[Vagrant]: http://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/
[AWS]: http://aws.amazon.com/


## Files

    Vagrantfile.example      Ruby script to configure Vagrant

    provision-functions.sh   Reusable Bash functions for provisioning

    provision.sh             System provisioning script, run as root

    user-provision.sh        User provisioning script, run as normal user

    notes.org                Emacs org-mode file with additional
                             instructions for manual installation steps


## Copyright and License

The MIT License (MIT)

Copyright © 2014 Stuart Sierra

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
