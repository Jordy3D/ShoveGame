using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IgnoreLights : MonoBehaviour
{
  [Tooltip("On the NVG, put all scene lights you want to ignore here. On the Main Camera, put the NightVisionLight in here.")]
  public List<Light> Lights;

  void OnPreCull()
  {
    foreach (Light light in Lights)
    {
      light.enabled = false;
    }
  }

  void OnPostRender()
  {
    foreach (Light light in Lights)
    {
      light.enabled = true;
    }
  }
}
