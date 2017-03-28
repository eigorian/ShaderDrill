Shader "ShaderDrill/SinDistortion"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ScaleU("Scale U", Float) = 0
		_ScaleV("Scale V", Float) = 0
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }

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
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _ScaleU;
			float _ScaleV;

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 uv = i.texcoord;
				uv.x += sin(uv.y * _ScaleU);
				uv.y += sin(uv.x * _ScaleV);
				fixed4 dst = tex2D(_MainTex, uv);
				return dst;
			}

			ENDCG
		}
	}
}
