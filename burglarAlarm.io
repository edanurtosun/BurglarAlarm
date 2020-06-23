#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
BlynkTimer timer;
char auth[] = "XXXX"; //blynk uygulamasından gelen anahtar
char ssid[] = "XXXX"; //wifi ismi
char pass[] = "XXXX"; //wifi parolası
int flag=0; //reed switch in hareketinin kontrol edilecegi bayrak


//hareket oldugunda bunu algılayıp uyarıyı gonderen fonksiyon
void notifyOnButtonPress()
{
  int isButtonPressed = digitalRead(D1);
  if (isButtonPressed==1 && flag==0) {
    Serial.println("UYARI : HIRSIZ VAR!");
    Blynk.notify("UYARI : HIRSIZ VAR!");
    flag=1;
  }
  else if (isButtonPressed==0)
  {
    flag=0;
  }
}

void setup()
{
Serial.begin(9600);
Blynk.begin(auth, ssid, pass); //mobil uygulamaya baglanti bilgilerinin gonderilmesi
pinMode(D1,INPUT_PULLUP);
timer.setInterval(16000L,notifyOnButtonPress); 
}
void loop()
{
  Blynk.run();
  timer.run();
}

