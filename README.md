This is my hack of gofmt to format the code in a way I prefer for editing. I
use this with my vim setup so that it runs myfmt when it is loading the code
into the editor and runs gofmt upon closing.

This way I get a format more to my liking while keeping things gofmt'd in my
repo.

I maintain it as a set of quilt patches against a copy of the relevant source
from the current stable Go release. I use the Makefile to streamline managing
the updates and quilt commands.
