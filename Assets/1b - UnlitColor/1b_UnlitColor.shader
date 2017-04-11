Shader ".UnityCattus/1b Unlit Color" 
{
	Properties
	{
		_Color("My Color", Color) = (1, 1, 1, 1)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			uniform fixed4 _Color;

			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
			};

			vertexOutput vert (vertexInput i)
			{
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
				return o;
			}

			fixed4 frag (vertexOutput i) : COLOR
			{
				return _Color;
			}
			ENDCG
		}
	}
}