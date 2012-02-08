"""
Requires: beautiful soup
"""

import BeautifulSoup
import urllib

data = urllib.urlopen("http://dlc.iec.cat/results.asp?txtEntrada=mar&operEntrada=0")
soup = BeautifulSoup.BeautifulSoup(data.read())
a = soup.find("div", {"id": "accepcio"})
f = open("./diec.html", 'w')
f.write('<html>\n\t<meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n<body>\n')
f.write(a.prettify())
f.write('</body>\n</html>')


