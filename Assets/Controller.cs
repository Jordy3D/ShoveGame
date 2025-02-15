﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

using BT;
using NaughtyAttributes;

public class Controller : MonoBehaviour
{
  public Transform gamePlane;

  [BoxGroup("Stats")]
  public float moveSpeed = 10, jumpStrength = 10, pushStrength = 100, pushDistance = 2, recoveryTime = 1, damage = 1, fireDelay = .5f, percentage, shield = 100;
  [BoxGroup("Boosts")]
  public float speedBoost, jumpBoost, weightBoost, damageBoost;

  [BoxGroup("Debugs")]
  public float pushMultipler = 10, gravity = 10, maxVelocityChange = 10;


  [BoxGroup("Debugs")]
  public int stocks = 3;

  [BoxGroup("Prefabs and references")]
  public GameObject pushEffect, shieldObject;

  [BoxGroup("States")]
  public bool canInput = true, wasHit = false, shieldOut = false, canFire = true, canShield = true;

  Vector2 m;
  Vector2 r;
  Vector3 movement;

  [HideInInspector]
  public Rigidbody rb;

  SmashCamera cam;
  PlayerManager ui;

  public CombatType combatType = CombatType.Ranged;
  public enum CombatType { Melee, Ranged }


  private void OnDrawGizmos()
  {
    Gizmos.DrawWireSphere(transform.position, pushDistance);
    Gizmos.DrawRay(transform.position, transform.forward);
  }

  private void Awake()
  {
    rb = GetComponent<Rigidbody>();

    cam = Camera.main.GetComponent<SmashCamera>();
    ui = cam.GetComponent<PlayerManager>();
    cam.AddTarget(transform);

    //rb.freezeRotation = true;
    //rb.useGravity = false;
  }

  // Start is called before the first frame update
  void Start()
  {
    rb = GetComponent<Rigidbody>();

    shieldObject.SetActive(false);
  }

  // Update is called once per frame
  void Update()
  {
    Move();
    Rotate();
  }

  private void FixedUpdate()
  {

  }

  public void Respawn()
  {
    if (stocks > 0)
    {
      stocks--;
      if (stocks <= 0)
      {
        cam.RemoveTarget(transform);
        canInput = false;
        return;
      }
      else
      {
        ui.UpdatePlayerUI();
      }
    }

    transform.position = new Vector3(0, 3, 0);
    rb.velocity = Vector3.zero;

    switch (ui.options.mode)
    {
      case GameMode.HP:
        percentage = ui.options.defaultHealth;

        break;
      case GameMode.Percentage:
        percentage = 0;
        break;
    }

    canShield = true;
    shield = 100;
    shieldObject.transform.localScale = new Vector3(shield / 100, .5f, shield / 100);

  }

  private void Move()
  {
    if (canInput)
    {
      Vector3 movement = new Vector3(m.x, 0, m.y) * (moveSpeed + speedBoost) * Time.deltaTime;

      if (wasHit && movement.magnitude > .01f)
      {
        rb.velocity = new Vector3(0, rb.velocity.y, 0);
        wasHit = false;
      }

      transform.Translate(movement, UnityEngine.Space.World);
    }

    //rb.velocity = new Vector3(movement.x * (moveSpeed + speedBoost), rb.velocity.y, movement.z * (moveSpeed + speedBoost));
  }
  private void Rotate()
  {
    if (r != Vector2.zero)
    {
      float heading = Mathf.Atan2(r.x, r.y);
      transform.rotation = Quaternion.Euler(0f, heading * Mathf.Rad2Deg, 0f);
    }
  }

  void OnMovement(InputValue _value)
  {
    m = _value.Get<Vector2>();
  }

  void OnRotation(InputValue _value)
  {
    r = _value.Get<Vector2>();
  }

  //void OnJump()
  //{
  //  if (canJump)
  //  {
  //    rb.AddForce(transform.up * (jumpStrength + jumpBoost), ForceMode.Impulse);
  //  }
  //}

  void OnFire()
  {
    if (!shieldOut)
    {
      if (canFire)
      {
        Controller otherController = null;
        Rigidbody otherRB = null;

        switch (combatType)
        {
          case CombatType.Melee:
            print("Not Yet Implented");
            break;
          case CombatType.Ranged:
            GameObject push = Instantiate(pushEffect, transform.position, transform.rotation);

            Transform other = transform.SphereForward(1, pushDistance).transform;
            Transform other2 = transform.RayForward(pushDistance).transform;

            if (other)
            {
              print(transform.name + " is hitting " + other.name);
              if (other.name == "Shield")
              {
                other.GetComponent<FollowTransform>().target.GetComponent<Controller>().DamageShield(damage);
                return;
              }
              otherRB = other.GetComponent<Rigidbody>();
              otherController = other.GetComponent<Controller>();
            }
            else if (other2)
            {
              otherRB = other2.GetComponent<Rigidbody>();
              otherController = other2.GetComponent<Controller>();
            }

            if (otherRB)
            {

              // Change the damage to a damage function!

              switch (ui.options.mode)
              {
                case GameMode.HP:
                  otherRB.AddForce(transform.forward * (pushStrength * pushMultipler), ForceMode.Impulse);

                  otherController.percentage -= damage + damageBoost;
                  if (otherController.percentage <= 0)
                  {
                    otherController.Respawn();
                  }
                  break;
                case GameMode.Percentage:
                  otherRB.AddForce(transform.forward * ((pushStrength * pushMultipler * otherController.percentage / 100) + damage), ForceMode.Impulse);

                  otherController.percentage += damage + damageBoost;
                  break;
              }

              otherController.Cooldown();

              ui.UpdatePlayerUI();
            }
            break;
        }

        FireCooldown();
      }
    }
  }

  void Damage()
  {

  }

  void DamageShield(float _value)
  {
    shield -= _value;
    if (shield > 20)
    {
      shieldObject.transform.localScale = new Vector3(shield / 100, .5f, shield / 100);
    }
    else
    {
      canShield = false;
      shieldOut = true;
      OnShieldOff();
    }
  }

  void OnShield()
  {
    if (!shieldOut && canShield)
    {
      shieldOut = true;
      shieldObject.SetActive(true);
    }
  }

  void Cooldown()
  {
    StartCoroutine(nameof(InputCooldown));
  }
  void FireCooldown()
  {
    StartCoroutine(nameof(FireInputCooldown));
  }

  void OnShieldOff()
  {
    if (shieldOut)
    {
      shieldOut = false;
      shieldObject.SetActive(false);
    }
  }

  IEnumerator InputCooldown()
  {
    wasHit = true;
    canInput = false;
    yield return new WaitForSeconds(recoveryTime);
    canInput = true;
  }

  IEnumerator FireInputCooldown()
  {
    canFire = false;
    yield return new WaitForSeconds(fireDelay);
    canFire = true;
  }
}
