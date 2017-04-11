Shader ".UnityCattus/Specular"
{
	Properties
	{
		_DiffuseColor ("Diffuse Color", Color) = (1, 1, 1, 1)
		_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
		_Shininess ("Shininess", Float) = 10
	}

	SubShader
	{
		Pass
		{
			Tags { "Lightmode" = "ForwardBase"}

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			uniform float4 _LightColor0;

			uniform float4 _DiffuseColor;
			uniform float4 _SpecColor;
			uniform float _Shininess;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 posWorld : TEXCOORD0;
				float3 normalDir : TEXCOORD1;
			};

			vertexOutput vert (vertexInput i)
			{
				vertexOutput o;

				o.normalDir = normalize(mul(float4(i.normal, 0.0), unity_WorldToObject).xyz);
				o.posWorld = mul(unity_ObjectToWorld, i.vertex);
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);

				return o;
			}

			float4 frag (vertexOutput i) : COLOR
			{
				//vector direction
				float3 normalDirection = normalize(i.normalDir);
				float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);

				//attenuation
				float atten;
				float3 lightDirection;

				//calculate attenuation and light direction
				if(_WorldSpaceLightPos0.w == 0.0)
				{
					atten = 1;
					lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				}
				else
				{
					float3 fragmentToLightsource = _WorldSpaceLightPos0.xyz - i.posWorld.xyz;
					float distance = length(fragmentToLightsource);
					atten = 1.0 / distance;
					lightDirection = normalize(fragmentToLightsource);
				}

				//lighting
				float3 diffuseReflection = _LightColor0.rgb * _DiffuseColor * atten * max(0.0, dot(normalDirection, lightDirection));
				float3 specularHighlight;

				if( dot(normalDirection, lightDirection) < 0.0 )
					specularHighlight = float3(0.0, 0.0, 0.0);
				else
					specularHighlight = _LightColor0.rgb * _SpecColor.rgb * atten * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);

				//light final
				float3 lightFinal = diffuseReflection + specularHighlight + UNITY_LIGHTMODEL_AMBIENT;

				return float4(lightFinal, 1.0);
			}
			ENDCG
		}

	}
}