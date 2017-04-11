Shader ".UnityCattus/1a UnlitColor"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			// we got "vert" as function name down there
			#pragma vertex vert
			#pragma fragment frag
			
			// vertex shader inputs
			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			// vertex shader outputs
			struct vertexOutput
			{
				float4 vertex : SV_POSITION;
			};
			
			// vertex shader
			vertexOutput vert (vertexInput IN)
			{
				vertexOutput OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				return OUT;
			}
    
			// fragment shader
			fixed4 frag (vertexOutput IN) : COLOR
			{
				return fixed4(1, 0, 0, 0);
			}
			ENDCG
		}
	}
}
