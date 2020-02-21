using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArenaBoundary : OnTriggerEvent
{
  public SmashCamera cam;

  public void Out()
  {
    cam.RemoveTarget(otherCollider.transform);
    print("Ring out!");
  }
}
