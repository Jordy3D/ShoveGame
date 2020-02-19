using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnWithDelay : MonoBehaviour
{
  public int spawnCount;
  public GameObject spawnObject;
  public float spawnDelay;

  // Start is called before the first frame update
  void Start()
  {
    StartCoroutine(Scale(spawnDelay, spawnCount));
  }

  // Update is called once per frame
  void Update()
  {

  }

  public IEnumerator Scale(float _delay, int _loopCount)
  {
    int currentCount = 0;
    while (currentCount < _loopCount)
    {
      Instantiate(spawnObject, transform.position, spawnObject.transform.rotation);
      currentCount++;
      yield return new WaitForSeconds(_delay);
    }
  }
}
