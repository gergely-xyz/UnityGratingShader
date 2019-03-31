Shader "Custom/GratingPattern"
{
	Properties
	{
		_Angle ("Direction", Range(0, 360)) = 0
		_Speed ("Speed", Range(0, 50)) = 10
		_Density ("Density", Range(0, 30)) = 5
		[Enum(Sine, 0, Square, 1)] _Square("Modulation", Float) = 0
		_Tint ("Tint Color", Color) = (1, 1, 1)
		_Offset ("Starting Phase", Range(0, 360)) = 0
		_Overlay ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "PreviewType"="Plane"}
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			// Grab values from Material properties
			float _Angle;
			float _Speed;
			float _Density;
			bool _Square;
			half4 _Tint;
			float _Offset;
			sampler2D _Overlay;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// Get overlay texture
				fixed4 tex = tex2D(_Overlay, i.uv);

				// Calculate rotation and phase (offset)
				float alpha = _Angle * UNITY_PI / 180.0;
				float beta = _Offset * UNITY_PI / 180.0;
				float sina, cosa;
				sincos(alpha, sina, cosa);

				// Get grating value
				float a = (sin(  (sina*i.uv.x*UNITY_PI+cosa*i.uv.y*UNITY_PI) * _Density*2 + beta + _Time[1]*_Speed  )+1)/2;

				// Round it if square wave modulation is set
				if (_Square){
					a = round(a);
				}

				return float4(tex.r*_Tint.r*a, tex.g*_Tint.g*a, tex.b*_Tint.b*a, 1);
			}
			ENDCG
		}
	}
}
