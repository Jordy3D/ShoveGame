using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterSelect : MonoBehaviour
{
  public PlayerManager manager;

  public int playerCount;
  public int takenCount;
  public float startDelay;

  // Start is called before the first frame update
  void Start()
  {
    takenCount = 0;
  }

  public void TakenCountChange(int _value)
  {
    UpdatePlayerCount();
    takenCount += _value;

    if (takenCount == playerCount && playerCount > 1)
    {
      StartCoroutine(nameof(StartGame));
    }
  }

  public void UpdatePlayerCount()
  {
    playerCount = manager.players.Count;
  }

  public IEnumerator StartGame()
  {
    yield return new WaitForSeconds(startDelay);
    manager.StartGame();
  }
}
