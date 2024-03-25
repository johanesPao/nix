# Personal Home Manager jPao (Nix)
Repositori ini berisikan personal environment setup menggunakan `home-manager` untuk **jPao** yang dapat berjalan pada:
- [x] linux x86_64
- [ ] ~~darwin~~ (*probably will never work on this one hehe*)

Persyaratan minimal yang dibutuhkan:
- `curl` (that's it)

> [!NOTE]
> Untuk memudahkan proses instalasi `nix`, kita akan menggunakan `nix-installer` dari [Determinate Systems](https://determinate.systems/). Jika perintah di bawah tidak berfungsi dengan baik, silahkan merujuk ke [https://install.determinate.systems](https://install.determinate.systems) sebagai referensi perintah instalasi menggunakan `curl`.
Pertama - tama, install Nix pada sistem dengan perintah sebagai berikut:
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Jika home-manager belum pernah di-inisiasi sebelumnya pada host, maka jalankan perintah - perintah berikut:
```
mkdir -p $HOME/.config && cd $HOME/.config
git clone https://github.com/johanesPao/nix.git
nix run nixpkgs#home-manager -- switch --flake nix/#linux_x86_64
```
> ![WARNING]
> `#linux_x86_64` adalah varian profile, namun saat ini belum ada profile lain yang dikembangkan selain varian ini.

Untuk melakukan pembaruan konfigurasi dan reload `home-manager`:
```
home-manager switch
```
