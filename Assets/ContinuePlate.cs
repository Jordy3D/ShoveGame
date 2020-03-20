using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ContinuePlate : Plate
{
  public SmashCamera cam;
  public GameOptions options;

  public int pressedCount, totalCount;

  public Renderer radialDisplay;

  public void UpdateRadial()
  {
    radialDisplay.material.SetFloat("_Percentage", percentComplete);
  }

  public override void Start()
  {
    base.Start();
  }

  public void UpdatePressedCount(int _val)
  {
    totalCount = cam.targets.Count;

    pressedCount += _val;
  }

  public void Progression(float _mult)
  {
    if (pressedCount == totalCount && totalCount >= 2)
    {
      base.PlateProgression(_mult);
    }
  }
}
