using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameOptions : MonoBehaviour
{
  public GameMode mode = GameMode.Percentage;
  public MayhemLevel mayhem = MayhemLevel.Normal;

  public CrateSpawner spawner;
  public PlayerManager playerManager;

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

  public void SetMayhemLevel(MayhemLevel _level)
  {
    switch (_level)
    {
      case MayhemLevel.Normal:
        spawner.delay = 20;
        break;
      case MayhemLevel.Quick:
        spawner.delay = 10;
        break;
      case MayhemLevel.Mayhem:
        spawner.delay = 2.5f;
        break;
      case MayhemLevel.SuperMayhem:
        spawner.delay = 1;
        break;
    }
  }

  public void SetGameMode(GameMode _mode)
  {
    switch (_mode)
    {
      case GameMode.HP:
        playerManager.modeText = "HP";
        break;
      case GameMode.Percentage:
        playerManager.modeText = "%";
        break;
    }
  }
}

public enum GameMode
{
  HP,
  Percentage
}

public enum MayhemLevel
{
  Normal,
  Quick,
  Mayhem,
  SuperMayhem
}
