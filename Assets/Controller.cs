using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

using BT;

public class Controller : MonoBehaviour
{
  public Transform gamePlane;
  public float moveSpeed = 10, jumpStrength = 10, pushStrength = 100, pushDistance = 2;

  public float speedBoost, jumpBoost, weightBoost, strengthBoost, percentage;

  Vector2 m;
  Vector2 r;

  Rigidbody rb;

  // Start is called before the first frame update
  void Start()
  {
    rb = GetComponent<Rigidbody>();
  }

  // Update is called once per frame
  void Update()
  {
    Move();
    Rotate();
  }

  private void Move()
  {
    Vector3 movement = new Vector3(m.x, 0, m.y) * (moveSpeed + speedBoost) * Time.deltaTime;
    transform.Translate(movement, UnityEngine.Space.World);
  }
  private void Rotate()
  {
    float heading = Mathf.Atan2(r.x, r.y);
    transform.rotation = Quaternion.Euler(0f, heading * Mathf.Rad2Deg, 0f);
  }

  void OnMovement(InputValue _value)
  {
    m = _value.Get<Vector2>();
  }

  void OnRotation(InputValue _value)
  {
    r = _value.Get<Vector2>();
  }

  void OnJump()
  {
    rb.AddForce(transform.up * (jumpStrength + jumpBoost), ForceMode.Impulse);
  }

  void OnFire()
  {
    Transform other = transform.SphereForward(1, pushDistance).transform;
    other.GetComponent<Rigidbody>()?.AddRelativeForce(transform.forward * (pushStrength * 1 / transform.Distance(other)));
  }
}
