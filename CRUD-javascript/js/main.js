var prvi_clan = {
    'id' : '1543435',
    'ime_prezime' : 'Filip Milutinovic',
    'godina_rodjenja' : 2003,
    'email' : 'fmilutinovic922it@raf.rs',
    'vrsta_clana' : 'regularni',
    'clanarina' : 3000
}
var drugi_clan = {
    'id' : '213214',
    'ime_prezime' : 'Nevena Pesic',
    'godina_rodjenja' : 2003,
    'email' : 'npesic1022it@raf.rs',
    'vrsta_clana' : 'regularni',
    'clanarina' : 3000
}
var treci_clan = {
    'id' : '2351245',
    'ime_prezime' : 'Andreja Isailovic',
    'godina_rodjenja' : 2002,
    'email' : 'andrejaisailovic002@gmail.com',
    'vrsta_clana' : 'povlasceni',
    'clanarina' : 2400
}

var clanovi;

clanovi = JSON.parse(localStorage.getItem("clanovi")) || [prvi_clan, drugi_clan, treci_clan]

var tabela_div = document.getElementById("div_za_tabelu")


window.addEventListener("load", init)

function vrsta_clana_clanarina(clanovi){
    for(var clan of clanovi){
        if(clan.vrsta_clana == 'povlasceni'){
            clan.clanarina = 3000 - 3000 * 0.2
        }
        else{
            clan.clanarina = 3000
        }
    }
}

function napravi_tabelu(){
    tabela_div.innerHTML = ''
    brojac = 0
    rez = ''
    for(var clan of clanovi){
        rez += `
        <tr>
            <td>${clan.id}</td>
            <td>${clan.ime_prezime}</td>
            <td>${clan.godina_rodjenja}</td>
            <td>${clan.email}</td>
            <td>${clan.vrsta_clana}</td>
            <td>${clan.clanarina}</td>
            <td>
                <button id="update" onclick="update_clana(${brojac})">
                    UPDATE
                </button>
            </td>
            <td>
                <button class="delete" onclick="obrisi_clana(${brojac})">
                    DELETE
                </button>
            </td>
        </tr>
        `
        brojac++
    }
    tabela_div.innerHTML += `
    <table style="border: 1; border-collapse: collapse;">
        <tr>
            <th>ID</th>
            <th>Ime i prezime</th>
            <th>Godina rodjenja</th>
            <th>Email</th>
            <th>Vrsta clana</th>
            <th>Clanarina</th>
            <th colspan="2">Opcije</th>
        </tr>
        ${rez}
    </table>
    `


}
var dodaj_dugme = document.getElementById("dodaj")

function init(){
    vrsta_clana_clanarina(clanovi)
    console.log(clanovi)

    napravi_tabelu()
    dodaj_dugme.addEventListener("click", dodaj_novog_clana)


}

function validacija_id(id){
    for(const clan of clanovi){
        if(clan.id == id){
            return 'ID vec postoji!'
        }
    }
    if(id == ''){
        return 'Niste uneli ID!'
    }
    return ''
}
function validacija_ime_prezime(ime_prezime){
    var razmak = ime_prezime.split(" ")
    if(razmak.length < 2){
        return 'Mora postojati razmak u imenu i prezimenu!'
    }
    else{
        return ''
    }
}
function validacija_godina_rodjenja(godina_rodjenja){
    if(godina_rodjenja < 0 || godina_rodjenja > 2023){
        return 'Nevalidan unos godine!'
    }
    else if(godina_rodjenja == ''){
        return 'Niste uneli broj!'
    }
    return ''
}
function validacija_email(email){
    if(!email.includes("@")){
        return 'Email mora imati znak "@"!'
    }
    return ''
}
var novi_clan;
function dodaj_novog_clana(){
    console.log("dodato")

    var id_input = document.getElementById("id")
    var ime_prezime_input = document.getElementById("ime_prezime")
    var godina_rodjenja_input = document.getElementById("godina_rodjenja")
    var email_input = document.getElementById("email")
    var vrsta_regularan_input = document.getElementById("vrsta_regularni")
    var vrsta_povlasceni_input = document.getElementById("vrsta_povlasceni")

    var id = id_input.value
    var ime_prezime = ime_prezime_input.value
    var godina_rodjenja = godina_rodjenja_input.value
    var email = email_input.value

    var vrsta_clana = '';
    var clanarina;
    if(vrsta_regularan_input.checked){
        vrsta_clana = "regularni"
        clanarina = 3000
    }
    else{
        vrsta_clana = "povlasceni"
        clanarina = 2400
    }

    console.log("ID: ",id)
    console.log("Ime i prezime: ",ime_prezime)
    console.log("godina_rodjenja: ",godina_rodjenja)
    console.log("email: ",email)
    console.log("vrsta clana: ",vrsta_clana)
    console.log("clanarina: ",clanarina)

    var greska_id = document.getElementById("greska_id")
    var greska_ime_prezime = document.getElementById("greska_ime_prezime")
    var greska_godina_rodjenja = document.getElementById("greska_godina_rodjenja")
    var greska_email = document.getElementById("greska_email")
    
    greska_id.innerHTML = validacija_id(id)
    greska_ime_prezime.innerHTML = validacija_ime_prezime(ime_prezime)
    greska_godina_rodjenja.innerHTML = validacija_godina_rodjenja(godina_rodjenja)
    greska_email.innerHTML = validacija_email(email)
    
    if(greska_id.innerHTML != '' || greska_ime_prezime.innerHTML != '' || greska_godina_rodjenja.innerHTML != '' || greska_email.innerHTML != ''){
        console.log("pojavila se greska!")
        return false
    }

    zapocni_tajmer()
    prikazi_zadatak()

    

    novi_clan = {
        'id' : id,
        'ime_prezime' : ime_prezime,
        'godina_rodjenja' : godina_rodjenja,
        'email' : email,
        'vrsta_clana' : vrsta_clana,
        'clanarina' : clanarina 
    }

    id_input.value = ''
    ime_prezime_input.value = ''
    godina_rodjenja_input.value = ''
    email_input.value = ''
    vrsta_regularan_input.checked = true




}

function obrisi_clana(pozicija){
    console.log("pozicija clana:",pozicija)
    clanovi.splice(pozicija,1)
    localStorage.setItem("clanovi", JSON.stringify(clanovi))
    napravi_tabelu()
    update.innerHTML = ''
}

var update = document.getElementById("desno")
function update_clana(pozicija){
    console.log("povezano")
    
    update.innerHTML = ''
    var trenutni_clan = clanovi[pozicija]

    var vrsta_trenutnog = '';
    if(trenutni_clan.vrsta_clana == "regularni"){
        vrsta_trenutnog = `
        <p>
            <label>Vrsta clana:</label>
            <input type="radio" name="vrsta_clana_update" id="vrsta_regularni_update" value="regularni" checked> Regularni
            <input type="radio" name="vrsta_clana_update" id="vrsta_povlasceni_update" value="povlasceni">Povlasceni
        </p>
        `
    }
    else{
        vrsta_trenutnog = `
        <p>
            <label>Vrsta clana:</label>
            <input type="radio" name="vrsta_clana_update" id="vrsta_regularni_update" value="regularni"> Regularni
            <input type="radio" name="vrsta_clana_update" id="vrsta_povlasceni_update" value="povlasceni" checked>Povlasceni
        </p>
        `
    }

    update.innerHTML += `
    <h2>Update <u>${trenutni_clan.ime_prezime}</u></h2>
    <form>
        <p>
            <label>ID</label>
            <input type="number" name="id_update" id="id_update" value="${trenutni_clan.id}" readonly>
        </p>
        <p>
            <label>Ime i prezime</label>
            <input type="text" name="ime_prezime_update" id="ime_prezime_update" value="${trenutni_clan.ime_prezime}">
            <span id="greska_ime_prezime_update"></span>
        </p>
        <p>
            <label>Godina rodjenja</label>
            <input type="number" name="godina_rodjenja_update" id="godina_rodjenja_update" value="${trenutni_clan.godina_rodjenja}">
            <span id="greska_godina_rodjenja_update"></span>
        </p>
        <p>
            <label>Email</label>
            <input type="text" name="email_update" id="email_update" value="${trenutni_clan.email}">
            <span id="greska_email_update"></span>
        </p>
        ${vrsta_trenutnog}
        <p id="centriranje_dugmeta">
            <button type="button" class="dugme" onclick="azuriraj(${pozicija})">
                AZURIRAJ
            </button>
        </p>
        
    </form>
    `

}

function azuriraj(pozicija){
    var id_input = document.getElementById("id_update")
    var ime_prezime_input = document.getElementById("ime_prezime_update")
    var godina_rodjenja_input = document.getElementById("godina_rodjenja_update")
    var email_input = document.getElementById("email_update")
    var vrsta_regularan_input = document.getElementById("vrsta_regularni_update")
    var vrsta_povlasceni_input = document.getElementById("vrsta_povlasceni_update")

    var id = id_input.value
    var ime_prezime = ime_prezime_input.value
    var godina_rodjenja = godina_rodjenja_input.value
    var email = email_input.value

    var vrsta_clana;
    var clanarina;

    if(vrsta_regularan_input.checked){
        vrsta_clana = "regularni"
        clanarina = 3000
    }
    else{
        vrsta_clana = "povlasceni"
        clanarina = 3000 - 3000 * 0.2
    }

    console.log("ID: ",id)
    console.log("Ime i prezime: ",ime_prezime)
    console.log("godina_rodjenja: ",godina_rodjenja)
    console.log("email: ",email)
    console.log("vrsta clana: ",vrsta_clana)
    console.log("clanarina: ",clanarina)

    var greska_ime_prezime = document.getElementById("greska_ime_prezime_update")
    var greska_godina_rodjenja = document.getElementById("greska_godina_rodjenja_update")
    var greska_email = document.getElementById("greska_email_update")

    greska_ime_prezime.innerHTML = validacija_ime_prezime(ime_prezime)
    greska_godina_rodjenja.innerHTML = validacija_godina_rodjenja(godina_rodjenja)
    greska_email.innerHTML = validacija_email(email)

    if(greska_ime_prezime.innerHTML != '' || greska_godina_rodjenja.innerHTML != '' || greska_email.innerHTML != ''){
        console.log("desila se greska")
        return false
    }

    izmenjen_clan = {
        'id' : id,
        'ime_prezime' : ime_prezime,
        'godina_rodjenja' : godina_rodjenja,
        'email' : email,
        'vrsta_clana' : vrsta_clana,
        'clanarina' : clanarina
    }

    clanovi[pozicija] = izmenjen_clan
    localStorage.setItem("clanovi", JSON.stringify(clanovi))
    update.innerHTML = ''
    napravi_tabelu()
}

function broj_izmedju_1_i_10(){
    return Math.floor(Math.random() * 10) + 1
}

function matematicka_operacija(){
    var operacije = ['+','-','/','*']

    var random_pozicija = Math.floor(Math.random() * operacije.length)
    
    return operacije[random_pozicija]
}

var zadatak;
var resenje_zadatka;
var dugme_odgovor = document.getElementById("provera")
var resenje_input = document.getElementById("resenje")
var poruka = document.getElementById("poruka")
var zadatak_resenje = document.getElementById("zadatak_resenje")
var zadatak_div = document.getElementById("zadatak")
var odgovor_korisnika

function prikazi_zadatak(){
    var prvi_broj = broj_izmedju_1_i_10()
    var drugi_broj = broj_izmedju_1_i_10()
    var operacija = matematicka_operacija()

    if(operacija == '/'){
        while(prvi_broj < drugi_broj){
            prvi_broj = broj_izmedju_1_i_10()
        } 
    }
    poruka.innerHTML = ''
    zadatak = `${prvi_broj} ${operacija} ${drugi_broj}`
    resenje_zadatka = Math.floor(eval(zadatak))

    zadatak_div.innerText = zadatak
    zadatak_div.classList.add("zadatak")
    zadatak_resenje.style.display = "flex"

    return zadatak
}



var centar_div = document.getElementById("centar")
var interval = null
var vreme = 30
var tajmer_element = document.getElementById("tajmer")
function zapocni_tajmer(){
    if(interval == null){
        tajmer_element.classList.add("tajmer")
        centar_div.classList.add("centar")
        tajmer_element.style.width = '100%'
        interval = setInterval(otkucaj,20)
    }


}
var procenti_sirine = 100
function otkucaj(){
    var sirina = 100/vreme/(1000/20)
    tajmer_element.style.width = procenti_sirine + '%'

    if (procenti_sirine - sirina >= 0){
        procenti_sirine -= sirina
    }
    else{
        poruka.innerHTML = 'Isteklo Vam je vreme! Clan nije dodat!'
        clearInterval(interval)
        interval = null
        procenti_sirine = 100
        tajmer_element.classList.remove("tajmer")
        zadatak_resenje.style.display = "none"
        zadatak_div.innerText = ''
        zadatak_div.classList.remove("zadatak")
        centar_div.classList.remove("centar")
        document.getElementById("resenje").value = ''
    }
}

function proveri_odgovor(){
    console.log("povezano")

    odgovor_korisnika = parseInt(resenje_input.value)

    if(!isNaN(odgovor_korisnika)){
        if(odgovor_korisnika == resenje_zadatka){
            poruka.innerHTML = "Tacan odgovor! Clan je dodat!"
            clanovi.push(novi_clan)
            localStorage.setItem("clanovi", JSON.stringify(clanovi))
            napravi_tabelu()


            console.log(interval)
            clearInterval(interval)
            console.log(interval)
            procenti_sirine = 100
            interval = null
            console.log(interval)
            tajmer_element.classList.remove("tajmer")
            zadatak_resenje.style.display = "none"
            zadatak_div.innerText = ''
            zadatak_div.classList.remove("zadatak")
            centar_div.classList.remove("centar")
            document.getElementById("resenje").value = ''

        }
        else{
            poruka.innerHTML = `Netacan odgovor! Clan nije dodat! Resenje je ${resenje_zadatka}`
            clearInterval(interval)
            interval = null
            procenti_sirine = 100
            tajmer_element.classList.remove("tajmer")
            zadatak_resenje.style.display = "none"
            zadatak_div.innerText = ''
            zadatak_div.classList.remove("zadatak")
            centar_div.classList.remove("centar")
            document.getElementById("resenje").value = ''
        }
    }
    else{
        poruka.innerHTML = "Niste uneli broj! Clan nije dodat!"
        clearInterval(interval)
        interval = null
        procenti_sirine = 100
        tajmer_element.classList.remove("tajmer")
        zadatak_resenje.style.display = "none"
        zadatak_div.innerText = ''
        zadatak_div.classList.remove("zadatak")
        centar_div.classList.remove("centar")
        document.getElementById("resenje").value = ''
    }

}





