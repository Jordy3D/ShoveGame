using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OptionSelect : Plate
{
  public Renderer radialDisplay;

  public void UpdateRadial()
  {
    radialDisplay.material.SetFloat("_Percentage", percentComplete);
  }
}
