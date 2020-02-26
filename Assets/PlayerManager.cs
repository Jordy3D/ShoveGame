using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using BT;
using TMPro;
using System.Linq;
using NaughtyAttributes;

public class PlayerManager : MonoBehaviour
{
  public SmashCamera cam;

  [BoxGroup("UI")] public GridLayoutGroup playerUIHolder;

  [BoxGroup("UI")] public float[] Xoffsets = new float[] { 800.0f, 400.0f, 260.0f, 200.0f };

  [BoxGroup("UI")] public List<Transform> players, playerUIs;
  [BoxGroup("UI")] public List<TextMeshProUGUI> percents, types;
  [BoxGroup("UI")] public List<GameObject> stocks;

  [BoxGroup("UI")] public GameObject winUI, stockIcon, gameUI;

  [BoxGroup("UI")] public string modeText;

  List<Controller> controllers;

  [BoxGroup("Scenes")] public GameObject charSelectScene, gameScene;

  bool goingUp;

  private void Start()
  {
    playerUIHolder.gameObject.SetActive(false);
    gameUI.SetActive(false);

    List<TextMeshProUGUI> temp = new List<TextMeshProUGUI>();
    temp.AddRange(playerUIHolder.GetComponentsInChildren<TextMeshProUGUI>());
    foreach (var text in temp)
    {
      if (text.name == "Percent")
        percents.Add(text);
      else
        types.Add(text);
    }

    for (int i = 0; i < playerUIHolder.transform.childCount; i++)
    {
      playerUIs.Add(playerUIHolder.transform.GetChild(i));
    }

    foreach (var ui in playerUIs)
    {
      stocks.Add(ui.GetComponentInChildren<Stock>().gameObject);
    }

    winUI.SetActive(false);
    goingUp = true;

    controllers = new List<Controller>();
  }

  public void UpdatePlayers()
  {
    if (playerUIHolder.gameObject.activeSelf == false && gameScene.activeSelf == true)
      playerUIHolder.gameObject.SetActive(true);

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
      goingUp = false;

    UpdatePlayerUI();
  }

  public void UpdatePlayerUI()
  {
    for (int i = 0; i < players.Count; i++)
    {
      percents[i].SetText(controllers[i].percentage.ToString());
      types[i].SetText(modeText);

      for (int c = 0; c < stocks.Count; c++)
        stocks[i].transform.Clear();

      for (int s = 0; s < controllers[i].stocks; s++)
        Instantiate(stockIcon, stocks[i].transform);

    }
  }

  public void StartGame()
  {
    charSelectScene.SetActive(false);
    gameScene.SetActive(true);
    gameUI.SetActive(true);
  }

  public void StartCharSelect()
  {
    charSelectScene.SetActive(true);
    gameScene.SetActive(false);
    gameUI.SetActive(false);
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
