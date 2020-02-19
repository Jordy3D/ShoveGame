using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class LerpScale : MonoBehaviour
{
  public Vector3 startScale, endScale;
  public float duration;

  public UnityEvent onEnd;

  float time;
  bool active;
  // Start is called before the first frame update
  void Start()
  {
    transform.localScale = startScale;
    time = 0;
    StartCoroutine(Scale());
  }

  // Update is called once per frame
  void Update()
  {

  }

  public IEnumerator Scale()
  {
    active = true;
    while(active)
    {
      if (time < duration)
      {
        transform.localScale = Vector3.Lerp(startScale, endScale, time/duration);
        time += Time.deltaTime;
        if (time >= duration)
        {
          onEnd.Invoke();
          active = false;
        }
      }
      yield return new WaitForEndOfFrame();
    }
  }

  public void Destroy()
  {
    Destroy(gameObject);
  }
}
