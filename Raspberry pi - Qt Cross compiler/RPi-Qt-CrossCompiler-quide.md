Raspberry Pi Cross Compiler asennus ohje Qt:lle
===

Tämä ohje edellyttää käyttäjältä Linux käyttöjärjestelmän perusosaamista ja Raspberry pi:n peruskäytön hallitsemisen (IMG asentaminen, asetusten sääty yms).

Kun tässä ohjeessa viitataan PC:n tarkoitetaan tällä omalla tietokoneella suoritettavia toimintoja.
Viitattaessa taas RPi sanaan tarkoittaa tämä, että ilmoitetut operaatiot täytyy toteuttaa Raspberry Pi tietokoneella, joko fyysisesti (näppäimistö, hiiri, näyttö) tai ssh yhteyttä käyttäen. 

Osassa tämän ohjeen toiminnoista hyödynnetään ssh yhteyden yli tehtävää rsync komentoa. Tästä syystä ssh yhteyden ottaminen Raspberry Pi laitteeseen pitää olla mahdollista toteuttaa.

**Tietoja**     
Kyseinen ohje on testattu seuraavilla alustoilla ja versioilla.
>Qt-versio 5.12.3   
Raspberry Pi 3 B+   
Raspberry Pi OS: Raspbian Buster-desktop    
PC-OS: Ubuntu 18.04

## 1. [Rpi] - development libraries asennus 

Ensiksi RPi laitteelle täytyy suorittaa firmwaren päivittäminen. Tämä tapahtuu ajamalla komento:
>sudo rpi-update    

lopuksi Raspberry Pi täytyy käynnsitää uudelleen komennolla
>reboot

Kun Raspberry Pi on käynnistynyt uudestaan tulee järjestelmästä enabloida mahdollisuus asentaa source packageja. Tämä tapahtuu menemällä tiedostoon **/etc/apt/sources.list** ja poistamalla kommentti merkin "**#**" **deb-src ...** kohdan edestä.

Tiedostoa pääsee muokkaamaan esimerkiksi nanolla komennolla 
>sudo nano /etc/apt/sources.list
___

Seuraavana täytyy pakentinhallintakirjastot päivittää ja ladata tarvittavat development librariet seuraavien komentojen avulla.

>sudo apt-get update    
>sudo apt-get build-dep qt4-x11  
>sudo apt-get build-dep libqt5gui5   
>sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0

Kun tarvittavat development librariet on asennettu onnistuneesti voidaan siirtyä kansioiden luontiin. Jos asennuksessa ilmenee virheitä ilmoitathan ne ohjeen lopussa olevan "ilmenneet ongelmat" osioon.

## 2. [RPi] - Kohdekansioiden valmsitelut.
Seuraavana luodaan kansio **/usr/local/qt5pi** ja asetetaan se pi käyttäjän alaisuuteen. käyttöoikeuksien vaihto on tärkeää, koska muuten kansio jäisi root käyttäjän alaisuuteen ja estäisi sen käytön ilman **sudo** oikeuksia.

**qt5pi** kansiota tulee sisältämään kaikki tarvittavat binäärit ja moduulit PC:llä luotujen Qt projektien käynnistämiseen Raspberry Pi:llä

Luodaan siis seuraavaksi **/usr/local/qt5pi** kansio ja vaihdetaan tämän omistussuhde rootilta pi käyttäjälle **chown** komennolla. 
>sudo mkdir /usr/local/qt5pi    
>sudo chown pi:pi /usr/local/qt5pi
___

HUOM! Luotaessa kansioita tai tiedostoja **sudo** komennolla tulee näiden omistajaksi aina root -käyttäjä. Rootin omistamiin tiedostoihin ei peruskäyttäjillä ole yleensä minkäänlaisia kirjoitus- tai suoritusoikeuksia. 

Tästä syystä tulee **sudo** komennon kanssa olla aina tarkkana. Vahingon sattuessa pystyy omistus-suhteen muuttamaan **chown** komennolla. Jos kansio sisältää enemmän väärän omistus-suhteen tiedostoja voi kansion sisäisten tiedostojen ja kansioiden omistus-suhteen muuttaa rekursiivisesti käyttämällä -R vipua esim seuraavan komennon mukaisesti:

>sudo chown -R USER:USER muokattavaKansio/

USER edustaa käyttäjää, jolle omistus halutaan muuttaa.

## 3. [PC] - Työkansion ja toolchainin luonti




## Ilmenneet ongelmat

___

## Lähteet
* https://mechatronicsblog.com/cross-compile-and-deploy-qt-5-12-for-raspberry-pi/
* 