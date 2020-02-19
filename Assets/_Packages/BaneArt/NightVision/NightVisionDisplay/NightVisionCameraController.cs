using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NightVisionCameraController : MonoBehaviour
{
  public Light nightVisLight;
  [Tooltip("Change this to set the strength of the night vision. (This is just changing the light's intensity)")]
  [Range(0, 2.5f)]
  public float nightVisStrength = 1;

  float previoustrength;

  void Start()
  {
    nightVisLight = GetComponentInChildren<Light>(true);
    if (!nightVisLight)
    {
      print("No Light found on NightVisCam. The camera will not work.");
    }
  }
  void Update()
  {
    if (previoustrength != nightVisStrength)
    {
      print("Setting intensity...");
      nightVisLight.intensity = nightVisStrength;
      previoustrength = nightVisStrength;
    }
  }
}
