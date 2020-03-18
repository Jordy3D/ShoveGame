using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameOptions : MonoBehaviour
{
  public GameMode mode = GameMode.Percentage;
  public MayhemLevel mayhem = MayhemLevel.Normal;
  public float defaultHealth = 200;

  public CrateSpawner spawner;
  public PlayerManager playerManager;

  public List<OptionSelect> optionPlates;

  private void Awake()
  {
    playerManager = GetComponent<PlayerManager>();
  }

  // Start is called before the first frame update
  void Start()
  {

  }

  // Update is called once per frame
  void Update()
  {

  }

  public void WipeAllOtherPlates()
  {
    print("Wiping Plates");
    foreach (var plate in optionPlates)
    {
      plate.SetProgress(0);
      plate.UpdateRadial();
    }
  }

  public void SetMayhemLevel(int _level)
  {
    switch ((MayhemLevel)_level)
    {
      case MayhemLevel.Normal:
        mayhem = MayhemLevel.Normal;
        spawner.delay = 20;
        break;
      case MayhemLevel.Quick:
        mayhem = MayhemLevel.Quick;
        spawner.delay = 10;
        break;
      case MayhemLevel.Mayhem:
        mayhem = MayhemLevel.Mayhem;
        spawner.delay = 2.5f;
        break;
      case MayhemLevel.SuperMayhem:
        mayhem = MayhemLevel.SuperMayhem;
        spawner.delay = 1;
        break;
    }

    WipeAllOtherPlates();
  }

  public void SetGameMode(int _mode)
  {
    switch ((GameMode)_mode)
    {
      case GameMode.HP:
        mode = GameMode.HP;
        playerManager.modeText = "HP";
        break;
      case GameMode.Percentage:
        mode = GameMode.Percentage;
        playerManager.modeText = "%";
        break;
    }

    WipeAllOtherPlates();
  }
}

public enum GameMode
{
  HP = 0,
  Percentage = 1
}

public enum MayhemLevel
{
  Normal,
  Quick,
  Mayhem,
  SuperMayhem
}
