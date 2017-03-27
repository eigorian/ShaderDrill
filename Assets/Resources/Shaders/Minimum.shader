Shader "ShaderDrill/Minimum"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			float4 vert(float4 vertex : POSITION) : SV_POSITION
			{
				return mul(UNITY_MATRIX_MVP, vertex);
			}

			float4 frag(float4 i : SV_POSITION) : SV_Target
			{
				return fixed4(1.0, 1.0, 1.0, 1.0);
			}

			ENDCG
		}
	}
}
