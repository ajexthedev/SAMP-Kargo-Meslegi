#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <streamer>

//2487.3599 -2671.091 13.6394
#define KARGO_ISBASI_X (2487.3599)
#define KARGO_ISBASI_Y (-2671.091)
#define KARGO_ISBASI_Z (13.6394)
#define KARGO_ISBASI_RANGE (3.0)
#define KARGO_ISBASI_PICKUP (1239)
#define KARGO_ISBASI_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{c9c9c9}/kargo isbasi"

//2389.0405,-2673.4324,13.6676
#define KARGO_ODUN_X (2389.0405)
#define KARGO_ODUN_Y (-2673.4324)
#define KARGO_ODUN_Z (13.6676)
#define KARGO_ODUN_RANGE (3.0)
#define KARGO_ODUN_PICKUP (2060)
#define KARGO_ODUN_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{6fa8dc}ODUN FABRIKASI"

//2500.3318,-2607.8806,13.6498
#define KARGO_ODUN_BIRAK_X (2500.3318)
#define KARGO_ODUN_BIRAK_Y (-2607.8806)
#define KARGO_ODUN_BIRAK_Z (13.6498)
#define KARGO_ODUN_BIRAK_RANGE (3.0)
#define KARGO_ODUN_BIRAK_PICKUP (1579)
#define KARGO_ODUN_BIRAK_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{6fa8dc}ODUN SATIŞ FABRIKASI"

//2454.2341,-2485.7700,13.6426
#define KARGO_TEKSTIL_X (2454.2341)
#define KARGO_TEKSTIL_Y (-2485.7700)
#define KARGO_TEKSTIL_Z (13.6426)
#define KARGO_TEKSTIL_RANGE (3.0)
#define KARGO_TEKSTIL_PICKUP (2060)
#define KARGO_TEKSTIL_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{ffd966}TEKSTIL FABRIKASI"

//2500.7476,-2570.3167,13.6496
#define KARGO_TEKSTIL_BIRAK_X (2500.7476)
#define KARGO_TEKSTIL_BIRAK_Y (-2570.3167)
#define KARGO_TEKSTIL_BIRAK_Z (13.6496)
#define KARGO_TEKSTIL_BIRAK_RANGE (3.0)
#define KARGO_TEKSTIL_BIRAK_PICKUP (2060)
#define KARGO_TEKSTIL_BIRAK_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{ffd966}TEKSTIL SATIŞ FABRIKASI"

//2473.3606,-2628.0325,13.6513
#define KARGO_ARAC_TAMIR_X (2473.3606)
#define KARGO_ARAC_TAMIR_Y (-2628.0325)
#define KARGO_ARAC_TAMIR_Z (13.6513)
#define KARGO_ARAC_TAMIR_RANGE (3.0)
#define KARGO_ARAC_TAMIR_PICKUP (1650)
#define KARGO_ARAC_TAMIR_LABEL_TEXT "{e69138}[Kargo Mesleği]\n{ffd966}Araç Tamir Noktası"

enum e_player_data
{
	bool:pKargoIsbasi,
	pKargoStreak,
	bool:pKargoBasladi,
	bool:pKargoOdun,
	bool:pKargoOdunArac,
	bool:pKargoTekstil,
	bool:pKargoTekstilArac,
	pCheckpoint
};

new PlayerData[MAX_PLAYERS][e_player_data];

main () {} 

new kargoveh[2];

public OnGameModeInit()
{
	//İŞBAŞI
	CreateDynamicPickup(KARGO_ISBASI_PICKUP, 1, KARGO_ISBASI_X, KARGO_ISBASI_Y, KARGO_ISBASI_Z);
	CreateDynamic3DTextLabel(KARGO_ISBASI_LABEL_TEXT, -1, KARGO_ISBASI_X, KARGO_ISBASI_Y, KARGO_ISBASI_Z, 15.0);

	//ODUN KARGO
	CreateDynamicPickup(KARGO_ODUN_PICKUP, 1, KARGO_ODUN_X, KARGO_ODUN_Y, KARGO_ODUN_Z);
	CreateDynamic3DTextLabel(KARGO_ODUN_LABEL_TEXT, -1, KARGO_ODUN_X, KARGO_ODUN_Y, KARGO_ODUN_Z, 15.0);

	//ODUN KARGO SATIŞ
	CreateDynamicPickup(KARGO_ODUN_BIRAK_PICKUP, 1, KARGO_ODUN_BIRAK_X, KARGO_ODUN_BIRAK_Y, KARGO_ODUN_BIRAK_Z);
	CreateDynamic3DTextLabel(KARGO_ODUN_BIRAK_LABEL_TEXT, -1, KARGO_ODUN_BIRAK_X, KARGO_ODUN_BIRAK_Y, KARGO_ODUN_BIRAK_Z, 15.0);

	//TEKSTIL KARGO
	CreateDynamicPickup(KARGO_TEKSTIL_PICKUP, 1, KARGO_TEKSTIL_X, KARGO_TEKSTIL_Y, KARGO_TEKSTIL_Z);
	CreateDynamic3DTextLabel(KARGO_TEKSTIL_LABEL_TEXT, -1, KARGO_TEKSTIL_X, KARGO_TEKSTIL_Y, KARGO_TEKSTIL_Z, 15.0);

	//TEKSTIL KARGO SATIŞ
	CreateDynamicPickup(KARGO_TEKSTIL_BIRAK_PICKUP, 1, KARGO_TEKSTIL_BIRAK_X, KARGO_TEKSTIL_BIRAK_Y, KARGO_TEKSTIL_BIRAK_Z);
	CreateDynamic3DTextLabel(KARGO_TEKSTIL_BIRAK_LABEL_TEXT, -1, KARGO_TEKSTIL_BIRAK_X, KARGO_TEKSTIL_BIRAK_Y, KARGO_TEKSTIL_BIRAK_Z, 15.0);

	//KARGO ARAÇ TAMİR
	CreateDynamicPickup(KARGO_ARAC_TAMIR_PICKUP, 1, KARGO_ARAC_TAMIR_X, KARGO_ARAC_TAMIR_Y, KARGO_ARAC_TAMIR_Z);
	CreateDynamic3DTextLabel(KARGO_ARAC_TAMIR_LABEL_TEXT, -1, KARGO_ARAC_TAMIR_X, KARGO_ARAC_TAMIR_Y, KARGO_ARAC_TAMIR_Z, 15.0);

	//Kargo Araç
	kargoveh[0] = AddStaticVehicle(530, 2498.1824, -2673.2476, 13.6328, 86.8014, -1, -1);
	kargoveh[1] = AddStaticVehicle(530, 2499.0701, -2670.3506, 13.6328, 86.8014, -1, -1);
	return 1;
}

public OnPlayerConnect(playerid)
{
	KargoVeriSifirla(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	KargoVeriSifirla(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, 2487.3599, -2671.0918, 13.6394);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerData[playerid][pKargoIsbasi] == true)
	{
		SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Meslek işbaşında {f44336}öldüğünüz{ffffff} için bütün verileriniz sıfırlandı.");
		KargoVeriSifirla(playerid);
		return 1;
	} 
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerData[playerid][pKargoBasladi] == true)
	{
		new vehid = GetPlayerVehicleID(playerid);
		SetVehicleToRespawn(vehid);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
    {
		for(new i = 0; i < sizeof kargoveh; i++)
		{
			if(IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				if(PlayerData[playerid][pKargoBasladi] == false)
					SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Kargo aracına bindin. ({9fc5e8}/kargo basla{ffffff})");
			}
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) // Player entered a vehicle as a driver
    {
		if(PlayerData[playerid][pKargoBasladi] == true)
		{
			new vehid = GetPlayerVehicleID(playerid);

			SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Kargo aracından indiğin için verilerin sıfırlandı. ({9fc5e8}/kargo isbasi{ffffff})");
			SetVehicleToRespawn(vehid);
			KargoVeriSifirla(playerid);
		}
    }
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerData[playerid][pCheckpoint] == 1)
    {
        PlayerData[playerid][pCheckpoint] = 0;
		GameTextForPlayer(playerid, "~g~/kargo al", 1500, 4);
		DisablePlayerCheckpoint(playerid);
    }
	if(PlayerData[playerid][pCheckpoint] == 2)
    {
        PlayerData[playerid][pCheckpoint] = 0;
		GameTextForPlayer(playerid, "~g~/kargo birak", 1500, 4);
		DisablePlayerCheckpoint(playerid);
    }
	return 1;
}

stock randomEx(min, max)
{
    new randm = random(max-min)+min;
    return randm;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
        str[144];

    /*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
    */
    if ((args = numargs()) == 3)
    {
        SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

CMD:kargo(playerid, params[])
{
	new str[32], str2[32];
	if(!IsPlayerConnected(playerid)) return 1;
	if(sscanf(params,"s[32]S()[32]", str, str2))
	{
		SendClientMessage(playerid, -1, "{8fce00}KULLANIM:{ffffff} /kargo [parametre]");
		SendClientMessage(playerid, -1,  "{ffd966}PARAMETRE:{c9c9c9} isbasi - veri - basla - al - birak - tamir");
		return 1;
	}
	if(!strcmp(params, "isbasi", true))
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "{F97043}HATA: {ffffff}Bir araç içerisinde bu komutu kullanamazsın!");
		if(IsPlayerInRangeOfPoint(playerid, KARGO_ISBASI_RANGE, KARGO_ISBASI_X, KARGO_ISBASI_Y, KARGO_ISBASI_Z))
		{
			if(PlayerData[playerid][pKargoIsbasi] == false)
			{
				PlayerData[playerid][pKargoIsbasi] = true;
				PlayerData[playerid][pKargoStreak] = 0;
				SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Başarıyla işbaşına giriş yaptın.");
				SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Yakında bulunan forkliftlere binerek işe başlayabilirsin!");
				return 1;
			}
			if(PlayerData[playerid][pKargoIsbasi] == true)
			{
				KargoVeriSifirla(playerid);
				SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Başarıyla işbaşından çıkış yaptın.");
				SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Meslekte bulunan tüm verilerin sıfırlandı!");
				return 1;
			} 
			return 1;
		}
		else return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Bir işbaşı noktasına yakın değilsin.");
	}
	if(!strcmp(params, "basla", true))
	{
		if(PlayerData[playerid][pKargoIsbasi] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}İşbaşında değilken mesleğe başlayamazsın!");
		if(PlayerData[playerid][pKargoBasladi] == true) return SendClientMessage(playerid, -1 , "{e69138}[KARGO]: {ffffff}Zaten mesleğe başlamışsın!");
		for(new i = 0; i < sizeof kargoveh; i++)
		{
			if(IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Kargo mesleğine başladın!");
				PlayerData[playerid][pKargoBasladi] = true;
				RandomNoktalar(playerid);
			}
		}
	} 
	if(!strcmp(params, "veri", true))
	{
		if(PlayerData[playerid][pKargoIsbasi] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}İşbaşında değilken görüntüleyemezsin!");
		else
		{
			SendClientMessage(playerid, -1, "{38761d}|_________________________________|");
			SendClientMessageEx(playerid, -1, "{e69138}[KARGO] Toplam taşıma: {ffffff}%d",  PlayerData[playerid][pKargoStreak]);
			SendClientMessage(playerid, -1, "{38761d}|_________________________________|");
		}
		return 1;
	} 
	if(!strcmp(params, "al", true))
	{
		if(PlayerData[playerid][pKargoIsbasi] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}İşbaşında değilken bu komutu kullanamazsın!");
		if(PlayerData[playerid][pKargoBasladi] == false) return SendClientMessage(playerid, -1 , "{e69138}[KARGO]: {ffffff}Mesleğe başlamadan bu komutu kullanamazsın!");
		for(new i = 0; i < sizeof kargoveh; i++)
		{
			if(PlayerData[playerid][pKargoOdun] == true && IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				if(IsPlayerInRangeOfPoint(playerid, KARGO_ODUN_RANGE, KARGO_ODUN_X, KARGO_ODUN_Y, KARGO_ODUN_Z))
				{
					if(PlayerData[playerid][pKargoOdunArac] == true) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Zaten forklifte odun kolisini almışsın.");
					else
					{
						SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Odun kolisini başarıyla forklifte yükledin.");
						SetPlayerCheckpoint(playerid, KARGO_ODUN_BIRAK_X, KARGO_ODUN_BIRAK_Y, KARGO_ODUN_BIRAK_Z, 5.0);
						PlayerData[playerid][pCheckpoint] = 2;
						PlayerData[playerid][pKargoOdunArac] = true;
					}
				}
				return 1;
			}
			if(PlayerData[playerid][pKargoTekstil] == true && IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				if(IsPlayerInRangeOfPoint(playerid, KARGO_TEKSTIL_RANGE, KARGO_TEKSTIL_X, KARGO_TEKSTIL_Y, KARGO_TEKSTIL_Z))
				{
					if(PlayerData[playerid][pKargoTekstilArac] == true) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Zaten forklifte tekstil kolisini almışsın.");
					else
					{
						SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Tekstil kolisini başarıyla forklifte yükledin.");
						SetPlayerCheckpoint(playerid, KARGO_TEKSTIL_BIRAK_X, KARGO_TEKSTIL_BIRAK_Y, KARGO_TEKSTIL_BIRAK_Z, 5.0);
						PlayerData[playerid][pCheckpoint] = 2;
						PlayerData[playerid][pKargoTekstilArac] = true;
					}
				}
				return 1;
			}
		}
		return 1;
	}
	if(!strcmp(params, "birak", true))
	{
		new pay = 300 + randomEx(100, 150); // Oyuncuya verilecek para buradan ayarlanabilir.
		if(PlayerData[playerid][pKargoIsbasi] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}İşbaşında değilken bu komutu kullanamazsın!");
		if(PlayerData[playerid][pKargoBasladi] == false) return SendClientMessage(playerid, -1 , "{e69138}[KARGO]: {ffffff}Mesleğe başlamadan bu komutu kullanamazsın!");
		for(new i = 0; i < sizeof kargoveh; i++)
		{
			if(PlayerData[playerid][pKargoOdun] == true && PlayerData[playerid][pKargoOdunArac] == true && IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				if(IsPlayerInRangeOfPoint(playerid, KARGO_ODUN_BIRAK_RANGE, KARGO_ODUN_BIRAK_X, KARGO_ODUN_BIRAK_Y, KARGO_ODUN_BIRAK_Z))
				{
					if(PlayerData[playerid][pKargoOdunArac] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Aracında odun kolisi yok.");
					else
					{
						SendClientMessageEx(playerid, -1, "{e69138}[KARGO]: {ffffff}Odun kolisini başarıyla sattın ve {6aa84f}$%d{ffffff} kazandın!.", pay);
						PlayerData[playerid][pKargoOdunArac] = false;
						PlayerData[playerid][pKargoOdun] = false;
						GivePlayerMoney(playerid, pay);
						PlayerData[playerid][pKargoStreak]++;
						RandomNoktalar(playerid);
					}
				}
				return 1;
			}
			if(PlayerData[playerid][pKargoTekstil] == true && PlayerData[playerid][pKargoTekstilArac] == true && IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				if(IsPlayerInRangeOfPoint(playerid, KARGO_TEKSTIL_BIRAK_RANGE, KARGO_TEKSTIL_BIRAK_X, KARGO_TEKSTIL_BIRAK_Y, KARGO_TEKSTIL_BIRAK_Z))
				{
					if(PlayerData[playerid][pKargoTekstilArac] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Aracında tekstik kolisi yok.");
					else
					{
						SendClientMessageEx(playerid, -1, "{e69138}[KARGO]: {ffffff}Tekstil kolisini başarıyla sattın ve {6aa84f}$%d{ffffff} kazandın!.", pay);
						PlayerData[playerid][pKargoTekstilArac] = false;
						PlayerData[playerid][pKargoTekstil] = false;
						GivePlayerMoney(playerid, pay);
						PlayerData[playerid][pKargoStreak]++;
						RandomNoktalar(playerid);
					}
				}
			}
		}
	}
	if(!strcmp(params, "tamir", true))
	{
		if(PlayerData[playerid][pKargoIsbasi] == false) return SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}İşbaşında değilken bu komutu kullanamazsın!");
		if(PlayerData[playerid][pKargoBasladi] == false) return SendClientMessage(playerid, -1 , "{e69138}[KARGO]: {ffffff}Mesleğe başlamadan bu komutu kullanamazsın!");
		for(new i = 0; i < sizeof kargoveh; i++)
		{
			if(IsPlayerInVehicle(playerid, kargoveh[i]))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(IsPlayerInRangeOfPoint(playerid, KARGO_ARAC_TAMIR_RANGE, KARGO_ARAC_TAMIR_X, KARGO_ARAC_TAMIR_Y, KARGO_ARAC_TAMIR_Z))
				{
					RepairVehicle(vehicleid);
					SendClientMessageEx(playerid, -1, "{33aa33}Aracınız tamir edildi.");
				}
			}
		}
	}	 
	return 1; 
}


//İsteğe bağlı olarak nokta arttırımı yapılabilir. 
stock RandomNoktalar(playerid)
{
	new randpoints = random(2); //Eğer nokta arttırırsanız burayı güncelleyin.

	switch(randpoints)
	{
		case 0:
		{
			SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Odun fabrikası bölgesinden kolileri al.");
			SetPlayerCheckpoint(playerid, KARGO_ODUN_X, KARGO_ODUN_Y, KARGO_ODUN_Z, 5.0);
			PlayerData[playerid][pCheckpoint] = 1;
			PlayerData[playerid][pKargoOdun] = true;
		}
		case 1:
		{
			SendClientMessage(playerid, -1, "{e69138}[KARGO]: {ffffff}Tekstil fabrikası bölgesinden kolileri al.");
			SetPlayerCheckpoint(playerid, KARGO_TEKSTIL_X, KARGO_TEKSTIL_Y, KARGO_TEKSTIL_Z, 5.0);
			PlayerData[playerid][pCheckpoint] = 1;
			PlayerData[playerid][pKargoTekstil] = true;
		}
	} 
	return 1;
}

stock KargoVeriSifirla(playerid)
{
	PlayerData[playerid][pKargoIsbasi] = false;
	PlayerData[playerid][pKargoStreak] = 0;
	PlayerData[playerid][pKargoOdun] = false;
	PlayerData[playerid][pKargoOdunArac] = false;
	PlayerData[playerid][pKargoBasladi] = false;
	PlayerData[playerid][pKargoTekstil] = false;
	PlayerData[playerid][pKargoTekstilArac] = false;
	PlayerData[playerid][pCheckpoint] = 0;
	return 1;
}
