using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimateGrating : MonoBehaviour {
    private Renderer r;
    private float state;
    public float speed = 1;
    public bool paused;

    void Start () {
        r = GetComponent<Renderer>();
        r.materials[0].SetFloat("_Speed", 0f);
    }
	
	void FixedUpdate () {
        if (!paused) {
            r.materials[0].SetFloat("_Offset", state);
            state += speed;
            state %= 360;
        }
        
    }
}
