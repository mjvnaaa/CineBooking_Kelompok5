## Validasi: Email & Password Tidak Boleh Kosong
```
setState(() {
  emailErrorFariz = email.isEmpty;
  passErrorFariz = pass.isEmpty;
});
```
```
setState(() {
```
Memperbarui UI agar perubahan state tercermin di layar
```
emailErrorFariz = email.isEmpty;
```
Jika email kosong → set error email menjadi true
```
passErrorFariz = pass.isEmpty;
});
```
Jika password kosong → set error password menjadi true
## Validasi Format Email (harus @student.univ.ac.id)
```
if (!regexEmail.hasMatch(email)) {
  farizShowErrorSnackbar("Email must use @student.univ.ac.id");
  return;
}
```
```
if (!regexEmail.hasMatch(email)) {}
```
Mengecek apakah email TIDAK sesuai pola regex
```
farizShowErrorSnackbar("Email must use @student.univ.ac.id");
```
Menampilkan snackbar error
```
return; 
```
Menghentikan proses login
## Percobaan Login ke Firebase
```
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,               
  password: pass,
);                         
```
```
email: email,
```
Email yang dimasukkan user
```
password: pass,
```
Password yang dimasukkan user lalu Firebase mencoba mencocokkan kredensial
## Menyimpan Data Login Jika Remember Me Aktif
```
await farizSaveLoginData(email, pass);          
```
Menyimpan email & password ke SharedPreferences
## Navigasi Setelah Login Berhasil
```
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const HomePageAdel()),  
);
```
Mengarahkan ke halaman Home
## Error Handling Dari Firebase
```
on FirebaseAuthException catch (e) {   
  String message = "Login failed";     

  if (e.code == 'user-not-found')      
    message = "No user found for that email";

  if (e.code == 'wrong-password')      
    message = "Wrong password provided";

  if (e.code == 'invalid-email')       
    message = "Invalid email format";

  farizShowErrorSnackbar(message);     
}

```
```
on FirebaseAuthException catch (e) {   
```
Menangkap error spesifik dari Firebase Auth
```
String message = "Login failed";
```     
Pesan default jika error tidak dikenal
```
if (e.code == 'user-not-found')
```      
Jika email tidak terdaftar
message = "No user found for that email";
```
if (e.code == 'wrong-password')
```      
Jika password salah
```
message = "Wrong password provided";
```
```
if (e.code == 'invalid-email')      
```
Jika format email salah
```    
message = "Invalid email format";
```
```
farizShowErrorSnackbar(message);
}     
```
Menampilkan pesan error ke user



