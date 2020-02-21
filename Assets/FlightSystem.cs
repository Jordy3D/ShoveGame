using UnityEngine;
using UnityEngine.InputSystem;

using NaughtyAttributes;

public class FlightSystem : MonoBehaviour
{
  [BoxGroup("Joystick Direction")]
  public Vector2 joyStick;

  [BoxGroup("Floats")]
  public float stickTwist, throttle, sensitivity, upperThrottlePot, lowerThrottlePot;

  [BoxGroup("Joystick Buttons")]
  public bool buttonA, buttonB, buttonC, safeFire, triggerLight, triggerHeavy, pinkySwitch;
  [BoxGroup("D-pads")]
  public bool lowerDPadNorth, lowerDPadSouth, lowerDPadEast, lowerDPadWest, upperDPadNorth, upperDPadSouth, upperDPadEast, upperDPadWest;
  [BoxGroup("Mode")]
  public bool mode1, mode2, mode3;

  void OnStick(InputValue _value) { joyStick = _value.Get<Vector2>(); }

  void OnUpperThrottlePot(InputValue _value) { upperThrottlePot = _value.Get<float>(); }
  void OnLowerThrottlePot(InputValue _value) { lowerThrottlePot = _value.Get<float>(); }

  void OnStickTwist(InputValue _value) { stickTwist = _value.Get<float>(); }
  void OnThrottle(InputValue _value) { throttle = _value.Get<float>(); }

  void OnMode1(InputValue _value) { mode1 = _value.Get<float>() > 0.1; }
  void OnMode2(InputValue _value) { mode2 = _value.Get<float>() > 0.1; }
  void OnMode3(InputValue _value) { mode3 = _value.Get<float>() > 0.1; }

  void OnSensitivity(InputValue _value) { sensitivity = _value.Get<float>(); }

  void OnButtonA(InputValue _value) { buttonA = _value.Get<float>() > 0.1; }
  void OnButtonB(InputValue _value) { buttonB = _value.Get<float>() > 0.1; }
  void OnButtonC(InputValue _value) { buttonC = _value.Get<float>() > 0.1; }

  void OnSafeFire(InputValue _value) { safeFire = _value.Get<float>() > 0.1; }

  void OnTriggerLight(InputValue _value) { triggerLight = _value.Get<float>() > 0.1; }
  void OnTriggerHeavy(InputValue _value) { triggerHeavy = _value.Get<float>() != 0; }
  void OnPinkySwitch(InputValue _value) { pinkySwitch = _value.Get<float>() != 0; }

  void OnLowerDPadNorth(InputValue _value) { lowerDPadNorth = _value.Get<float>() != 0; }
  void OnLowerDPadSouth(InputValue _value) { lowerDPadSouth = _value.Get<float>() != 0; }
  void OnLowerDPadEast(InputValue _value) { lowerDPadEast = _value.Get<float>() != 0; }
  void OnLowerDPadWest(InputValue _value) { lowerDPadWest = _value.Get<float>() != 0; }
}
