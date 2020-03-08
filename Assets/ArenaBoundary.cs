using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArenaBoundary : OnTriggerEvent
{
  public SmashCamera cam;
  public PlayerManager manager;

  public override void Start()
  {
    base.Start();

    cam = Camera.main.GetComponent<SmashCamera>();
    manager = Camera.main.GetComponent<PlayerManager>();
  }

  public void Out()
  {
    Controller player = otherCollider.GetComponent<Controller>();

    if (player)
    {
      print("Ring out!");

      if (player.stocks > 0)
      {
        player.stocks--;
        if (player.stocks <= 0)
        {
          cam.RemoveTarget(otherCollider.transform);
          player.canInput = false;
        }
        else
        {
          player.Respawn();
          manager.UpdatePlayerUI();
        }
      }
      
    }
  }
}
