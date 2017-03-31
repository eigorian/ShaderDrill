Shader "ShaderDrill/Fresnel"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType" = "Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha

		ZWrite Off
		ZTest LEqual

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata_t
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata_t v)
			{
				float3 cameraDirection = _WorldSpaceCameraPos - v.vertex;
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				//o.color.xyz = v.normal * 0.5 + 0.5;
				o.color.xyz = cameraDirection;
				o.color.w = 1.0;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.color;
				fixed4 dst = tex2D(_MainTex, i.texcoord);
				return dst;
			}
			ENDCG
		}
	}
}
