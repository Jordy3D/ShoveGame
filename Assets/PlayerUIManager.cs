using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using TMPro;

public class PlayerUIManager : MonoBehaviour
{
  public SmashCamera cam;
  public GridLayoutGroup playerUIHolder;

  public float[] Xoffsets = new float[] { 800.0f, 400.0f, 260.0f, 200.0f };

  public List<Transform> players;
  public List<TextMeshProUGUI> percents;

  public GameObject winUI;

  List<Controller> controllers;

  bool goingUp;

  private void Start()
  {
    playerUIHolder.gameObject.SetActive(false);

    List<TextMeshProUGUI> temp = new List<TextMeshProUGUI>();
    temp.AddRange(playerUIHolder.GetComponentsInChildren<TextMeshProUGUI>());
    foreach (var text in temp)
    {
      if (text.name == "Percent")
        percents.Add(text);
    }

    winUI.SetActive(false);
    goingUp = true;

    controllers = new List<Controller>();
  }

  public void UpdatePlayers()
  {
    if (playerUIHolder.gameObject.activeSelf == false)
    {
      playerUIHolder.gameObject.SetActive(true);

    }
    players = cam.targets;

    controllers.Clear();
    foreach (var player in players)
    {
      controllers.Add(player.GetComponent<Controller>());
    }

    ChangeOffset();

    for (int i = 0; i < players.Count; i++)
    {
      percents[i].SetText(controllers[i].percentage.ToString());
    }

    if (players.Count == 1 && goingUp == false)
    {
      Win();
      controllers[0].canInput = false;
    }

    if (goingUp == true && players.Count > 1)
    {
      goingUp = false;
    }
  }

  public void UpdatePlayerUI()
  {
    for (int i = 0; i < players.Count; i++)
    {
      percents[i].SetText(controllers[i].percentage.ToString());
    }
  }

  public void ChangeOffset()
  {
    playerUIHolder.cellSize = new Vector2(Xoffsets[cam.targets.Count - 1], playerUIHolder.cellSize.y);
  }

  void Win()
  {
    winUI.SetActive(true);
  }
}
