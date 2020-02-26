using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Crate : OnTriggerEvent
{
  public StatType statType = StatType.Speed;
  public float amount;

  public void Collect(float _val)
  {
    print("Crate collected!");

    var player = otherCollider.GetComponent<Controller>();

    switch (statType)
    {
      case StatType.Speed:
        player.speedBoost += _val;
        break;
      case StatType.Weight:
        player.weightBoost += _val;
        break;
      case StatType.Damage:
        player.damageBoost += _val;
        break;
      case StatType.RecoveryTime:
        player.recoveryTime -= _val / 10;
        break;
      case StatType.FireDelay:
        player.fireDelay -= _val / 10;
        break;
    }

    Destroy(gameObject);
  }
}

public enum StatType
{
  Speed,
  Weight,
  Damage,
  RecoveryTime,
  FireDelay
}
