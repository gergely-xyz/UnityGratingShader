using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomizeCloud : MonoBehaviour {
    private Renderer r;

    void Start () {
        r = GetComponent<Renderer>();
        r.materials[0].SetFloat("_offsetX", Random.Range(-1000f, 1000f));
        r.materials[0].SetFloat("_offsetY", 3f);
    }

}
