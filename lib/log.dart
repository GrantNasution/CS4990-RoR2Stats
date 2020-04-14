
class Log {
  String lclass;
  int kills, minionKills, deaths, damageDealt, minionDamageDealt;

  String get gClass => lclass;
  int get gKills => kills;
  int get gminionKills => minionKills;
  int get gDeaths => deaths;
  int get gdamageDealt => damageDealt;
  int get gminionDamageDealt => minionDamageDealt;

  set sKills(int kills) {this.kills = kills;}
  set sminionKills(int minionKills) {this.minionKills = minionKills;}
  set sDeaths(int deaths) {this.deaths = deaths;}
  set sdamageDealt(int damageDealt) {this.damageDealt = damageDealt;}
  set sminionDamageDealt(int minionDamageDealt) {this.minionDamageDealt = minionDamageDealt;}
  set sClass(String setClass) {this.lclass = setClass;}

  // Log(this.lclass, this.kills, this.minionKills, this.deaths, this.damageDealt, this.minionDamageDealt);
  Log({
        this.lclass,
        this.kills,
        this.minionKills,
        this.deaths,
        this.damageDealt,
        this.minionDamageDealt,
    });

  Log.empty() {

  }

  Log.clone(Log log) : this(
    lclass: log.lclass, 
    kills: log.kills,
    minionKills: log.minionKills,
    deaths: log.deaths,
    damageDealt: log.damageDealt,
    minionDamageDealt: log.minionDamageDealt
  );

  String stringify() {
    return '$lclass $kills $minionKills $deaths $damageDealt $minionDamageDealt';
  }

  //For storing log
  toJSONEncodable(int index) {
    Map<int, String> m = new Map();

    m[index] = this.stringify();
  }

  factory Log.fromMap(Map<String, dynamic> json) => Log(
        lclass: json["lclass"],
        kills: json["kills"],
        minionKills: json["minionKills"],
        deaths: json["Deaths"],
        damageDealt: json["DamageDealt"],
        minionDamageDealt: json["minionDamageDealt"],
    );

    Map<String, String> toMap() => {
        "lclass": lclass,
        "kills": kills.toString(),
        "minionKills": minionKills.toString(),
        "Deaths": deaths.toString(),
        "DamageDealt": damageDealt.toString(),
        "minionDamageDealt": minionDamageDealt.toString(),
    };
}