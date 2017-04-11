// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader ".UnityCattus/Diffuse"
{
	Properties
	{

	}

	SubShader
	{
		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			uniform float4 _LightColor0;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 col : COLOR;
			};

			vertexOutput vert (vertexInput i)
			{
				vertexOutput o;

				float3 normalDirection = normalize( mul(float4(i.normal, 0.0), unity_WorldToObject).xyz );
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 diffuseReflection = _LightColor0.rgb * max(0, dot(normalDirection, lightDirection));
				float3 lightFinal = diffuseReflection + UNITY_LIGHTMODEL_AMBIENT;

				o.col = float4(lightFinal, 1);
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);

				return o;
			}

			float4 frag (vertexOutput i) : COLOR
			{
				//normal direction
				//lighting direction
				//diffuse
				return i.col;
			}

			ENDCG
		}
	}
}