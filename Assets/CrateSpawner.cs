using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrateSpawner : RunEventConstantly
{
  public GameObject crate;
  public StatType type = StatType.Speed;

  public float radius;

  public void SpawnCrate()
  {
    Array values = Enum.GetValues(typeof(StatType));
    System.Random random = new System.Random();
    StatType randomStat = (StatType)values.GetValue(random.Next(values.Length));

    Vector3 rpoc = UnityEngine.Random.insideUnitSphere.normalized * radius;
    rpoc += transform.position;
    rpoc.y = transform.position.y;
    print(rpoc);
    GameObject spawned = Instantiate(crate, rpoc, Quaternion.identity);
    spawned.GetComponent<Crate>().statType = randomStat;
  }
}
