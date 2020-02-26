using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColourSelect : OnTriggerEvent
{
  public Color charColour;
  Color oldColour;

  public Renderer ring;

  public bool isTaken;

  public Transform currentPlayer;

  public override void Start()
  {
    base.Start();
    ring.material.SetColor("_MainColour", charColour);
    ring.material.SetColor("_MainColourBlend", charColour);
  }

  public void Taken(bool _state)
  {
    if (otherCollider.transform == currentPlayer || currentPlayer == null)
    {
      currentPlayer = _state ? otherCollider.transform : null;
      isTaken = _state;
    }
  }

  public void ApplyColour()
  {
    if (!isTaken)
    {
      Material mat = otherCollider.GetComponent<Renderer>().material;
      oldColour = mat.GetColor("_Colour");
      mat.SetColor("_Colour", charColour);
    }
  }

  public void ApplyOldColour()
  {
    Material mat = otherCollider.GetComponent<Renderer>().material;
    mat.SetColor("_Colour", oldColour);
  }
}
