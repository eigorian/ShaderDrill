Shader "ShaderDrill/GradationMap"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_GradationTex("Gradation", 2D) = "white" {}
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
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			sampler2D _GradationTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 origin = tex2D(_MainTex, i.texcoord);
				float grayscale = origin.r * 0.299 + origin.g + 0.587 + origin.b * 0.114;
				return tex2D(_GradationTex, grayscale);
			}
			ENDCG
		}
	}
}
