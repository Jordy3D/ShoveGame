using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

[RequireComponent(typeof(Camera))]
public class SmashCamera : MonoBehaviour
{
  public List<Transform> targets;
  [Header("Perspective Settings")]
  public float minZoom = 40;
  public float maxZoom = 10;
  public float zoomLimit = 50;

  [Header("Orthographic Settings")]
  public float minSize = 3;
  public float maxSize = 10;
  public float sizeLimit = 50;

  [Header("Global Settings")]
  public Vector3 offset;
  public float yModifier;
  public float zoomSpeed = 1, smoothTime = .5f;

  public UnityEvent onJoin;
  public UnityEvent onRemove;

  Camera cam;
  Vector3 vel;

  Bounds bounds;

  void Start()
  {
    cam = GetComponent<Camera>();
  }

  void LateUpdate()
  {
    if (targets.Count == 0)
      return;

    bounds = GetBounds(targets);

    MoveCam();
    ZoomCam();
  }

  void ZoomCam()
  {
    if (cam.orthographic)
    {
      float newZoom = Mathf.Lerp(minSize, maxSize, Mathf.Max(bounds.size.x, bounds.size.y * yModifier) / sizeLimit);
      cam.orthographicSize = Mathf.Lerp(cam.orthographicSize, newZoom, Time.deltaTime * zoomSpeed);
    }
    else
    {
      float newZoom = Mathf.Lerp(maxZoom, minZoom, Mathf.Max(bounds.size.x, bounds.size.z * yModifier) / zoomLimit);
      cam.fieldOfView = Mathf.Lerp(cam.fieldOfView, newZoom, Time.deltaTime * zoomSpeed);
    }
  }

  void MoveCam()
  {
    Vector3 midPoint = bounds.center;
    Vector3 newPos = midPoint + offset;

    transform.position = Vector3.SmoothDamp(transform.position, newPos, ref vel, smoothTime);
  }

  Bounds GetBounds(List<Transform> _targets)
  {
    var bounds = new Bounds(_targets[0].position, Vector3.zero);
    if (targets.Count == 1)
    {
      return bounds;
    }
    for (int i = 0; i < _targets.Count; i++)
    {
      bounds.Encapsulate(targets[i].position);
    }
    return bounds;
  }

  public void AddTarget(Transform _target)
  {
    targets.Add(_target);
    onJoin.Invoke();
  }

  public void RemoveTarget(Transform _target)
  {
    targets.Remove(_target);
    onRemove.Invoke();
  }
}
