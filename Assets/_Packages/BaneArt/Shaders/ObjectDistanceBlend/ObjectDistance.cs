using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ObjectDistance : MonoBehaviour
{
  public Renderer[] targetRends;

  public Transform[] trackedObjects;

  public Vector4[] vectorPositions;
  public Vector4[] emptySpace = new Vector4[70];

  public MaterialPropertyBlock materialProperty;

  public int arrayLength;

  // Start is called before the first frame update
  void Start()
  {
    Initialise();
  }

  void Initialise()
  {
    vectorPositions = new Vector4[trackedObjects.Length];
    materialProperty = new MaterialPropertyBlock();

    for (int i = 0; i < trackedObjects.Length; i++)
    {
      vectorPositions[i] = trackedObjects[i].position;
    }

    materialProperty.SetInt("ArrayLength", arrayLength);
    //Vector4[] emptySpace = new Vector4[70];
    materialProperty.SetVectorArray("positionsArray", emptySpace);
    foreach (var rend in targetRends)
    {
      rend.SetPropertyBlock(materialProperty);
    }
  }

  // Update is called once per frame
  void Update()
  {
    if (targetRends.Length > 0)
    {
      if (!(vectorPositions.Length > 0))
      {
        Initialise();
      }
      //foreach (var trackedObject in trackedObjects)
      //{
      //  rend.sharedMaterial.SetVector("_ObjectPosition", trackedObject.position);
      //}

      //arrayLength = vectorPositions.Length;
      for (int p = 0; p < vectorPositions.Length; p++)
      {
        vectorPositions[p] = Vector4.zero;
      }

      for (int i = 0; i < trackedObjects.Length; i++)
      {
        vectorPositions[i] = trackedObjects[i].position;
      }
      materialProperty.SetInt("ArrayLength", arrayLength);
      materialProperty.SetVectorArray("positionsArray", vectorPositions);
      foreach (var rend in targetRends)
      {
        rend.SetPropertyBlock(materialProperty);
      }
    }
  }
}
