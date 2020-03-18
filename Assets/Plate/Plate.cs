using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

using BT;
using NaughtyAttributes;

public class Plate : OnTriggerEvent
{
  [BoxGroup("Stats")]
  public float currentProgress = 0f;
  [BoxGroup("Stats")]
  public float targetProgress = 100f;

  [BoxGroup("Output")]
  public UnityEvent result;

  [BoxGroup("Debug")]
  [ReadOnly]
  public float percentComplete;
  [BoxGroup("Debug")]
  public bool targetReached = false;
  [BoxGroup("Debug")]
  public bool isPressed;

  public override void Start()
  {
    base.Start();

    targetReached = false;
    isPressed = false;
  }

  public override void OnTriggerEnter(Collider other)
  {
    if (!targetReached)
      base.OnTriggerEnter(other);

    isPressed = true;
  }

  public override void OnTriggerExit(Collider other)
  {
    if (!targetReached)
      base.OnTriggerExit(other);

    isPressed = false;
  }

  public override void OnTriggerStay(Collider other)
  {
    if (!targetReached)
      base.OnTriggerStay(other);
  }

  public void PlateProgression(float _mult)
  {
    if (currentProgress <= targetProgress)
    {
      ProgressUp(_mult);
    }
    else
    {
      TargetReached();
    }
  }

  void ProgressUp(float _mult)
  {
    if (!isPressed)
    {
      isPressed = true;
    }

    currentProgress += Time.deltaTime * _mult;
    percentComplete = (currentProgress / targetProgress) * 100;
  }

  void ProgressDown(float _mult)
  {
    currentProgress -= Time.deltaTime * _mult;
    percentComplete = (currentProgress / targetProgress) * 100;
  }

  void TargetReached()
  {
    targetReached = true;
    print(string.Format(BaneTools.ColorString("Plate Target Reached!", BaneTools.Color255(255, 100, 100))));

    //Do stuff here
    result.Invoke();
  }

  public void SetTargetReached(bool _state)
  {
    targetReached = _state;
  }

  [Button]
  public void ResetPlate()
  {
    print("reset!");
    targetReached = false;
    isPressed = false;
    percentComplete = 0;
    currentProgress = 0;
  }

  public void SetProgress(float _percentage)
  {
    if (_percentage == 0)
      ResetPlate();
    else
      percentComplete = _percentage;
  }

  public void TestSuccess()
  {
    print(string.Format(BaneTools.ColorString("Called successfully!", BaneTools.Color255(100, 255, 100))));
  }
}