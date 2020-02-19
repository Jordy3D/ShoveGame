using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Crate : OnTriggerEvent
{
  public StatType statType = StatType.Speed;

  public void Collect(float _val)
  {
    print("Crate collected!");

    var player = otherCollider.GetComponent<Controller>();

    switch (statType)
    {
      case StatType.Speed:
        player.speedBoost += _val;
        break;
      case StatType.Jump:
        player.jumpBoost += _val;
        break;
      case StatType.Weight:
        player.weightBoost += _val;
        break;
      case StatType.Strength:
        player.strengthBoost += _val;
        break;
    }

    Destroy(gameObject);
  }
}

public enum StatType
{
  Speed,
  Jump, 
  Weight,
  Strength
}
