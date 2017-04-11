Shader ".UnityCattus/RGBColor"
{
	Properties
	{
		_Float ("Float", Range(0, 2)) = 0
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			// we got "vert" as function's name down there
			#pragma vertex vert
			#pragma fragment frag
			
			uniform float _Float;

			// vertex shader inputs
			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			// vertex shader outputs
			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 col : TEXCOORD0;
			};
			
			// vertex shader
			vertexOutput vert (vertexInput IN)
			{
				vertexOutput OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.col = IN.vertex + float4(_Float, _Float, _Float, 0);
				return OUT;
			}
    
			// fragment shader
			fixed4 frag (vertexOutput IN) : COLOR
			{
				return IN.col;
			}
			ENDCG
		}
	}
}
