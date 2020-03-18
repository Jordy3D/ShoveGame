// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ice"
{
	Properties
	{
		_Float1("Float 1", Range( -2 , 2)) = 1.3
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_Float0("Float 0", Range( -2 , 2)) = 0.5
		_Color0("Color 0", Color) = (0.4716981,0.4716981,0.5176471,0)
		_Color1("Color 1", Color) = (1,1,1,0)
		_Float3("Float 3", Range( 0 , 1)) = 0.3095502
		_Float2("Float 2", Range( 0 , 1)) = 0
		_Float8("Float 8", Range( 0 , 1)) = 0
		_Float7("Float 7", Range( 0 , 1)) = 0.1
		_Float5("Float 5", Range( -1 , 1)) = 0.1294118
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform float _Float7;
		uniform float _Float5;
		uniform float _Float3;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform float4 _Color1;
		uniform float4 _Color0;
		uniform sampler2D _TextureSample1;
		uniform float _Float0;
		uniform float4 _TextureSample1_ST;
		uniform float _Float1;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform float _Float8;
		uniform float _Float2;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult71 = (float2(0.0 , 0.0));
			float2 appendResult72 = (float2(_Float7 , _Float7));
			float2 temp_output_60_0 = frac( v.texcoord.xy );
			float2 smoothstepResult57 = smoothstep( appendResult71 , appendResult72 , temp_output_60_0);
			float2 smoothstepResult58 = smoothstep( ( 1.0 - appendResult71 ) , ( 1.0 - appendResult72 ) , temp_output_60_0);
			float2 break64 = ( smoothstepResult57 * smoothstepResult58 );
			float temp_output_65_0 = ( break64.x * break64.y );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 temp_output_68_0 = ( ( temp_output_65_0 * ase_vertexNormal ) * _Float5 );
			v.vertex.xyz += temp_output_68_0;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float3 tex2DNode23 = UnpackScaleNormal( tex2D( _TextureSample3, uv_TextureSample3 ), _Float3 );
			float3 Normal34 = tex2DNode23;
			o.Normal = Normal34;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 tex2DNode8 = tex2D( _TextureSample1, uv_TextureSample1 );
			float2 appendResult24 = (float2(tex2DNode23.r , tex2DNode23.g));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult27 = (float2(ase_worldViewDir.x , ase_worldViewDir.y));
			float2 appendResult30 = (float2(( appendResult24 + appendResult27 ).x , ase_worldViewDir.z));
			float2 normalizeResult31 = normalize( appendResult30 );
			float2 AdjustedViewDirection32 = normalizeResult31;
			float2 paralaxOffset1 = ParallaxOffset( ( _Float0 * tex2DNode8.g ) , _Float1 , float3( AdjustedViewDirection32 ,  0.0 ) );
			float4 lerpResult15 = lerp( _Color1 , _Color0 , tex2D( _TextureSample1, ( i.uv_texcoord + paralaxOffset1 ) ).g);
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float4 ParallaxOut19 = saturate( ( lerpResult15 + ( tex2D( _TextureSample2, uv_TextureSample2 ) * _Float8 ) ) );
			float4 temp_output_20_0 = ParallaxOut19;
			o.Albedo = temp_output_20_0.rgb;
			o.Smoothness = _Float2;
			o.Transmission = temp_output_20_0.rgb;
			o.Translucency = temp_output_20_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2281;228;1390;660;1057.488;410.718;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-2320.836,156.1019;Inherit;False;Property;_Float3;Float 3;11;0;Create;True;0;0;False;0;0.3095502;0.538;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;25;-1824.524,285.5656;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;23;-2013.524,89.56554;Inherit;True;Property;_TextureSample3;Texture Sample 3;19;0;Create;True;0;0;False;0;-1;5b653e484c8e303439ef414b62f969f0;c2337c830b1ab1a4f85c7c082a427cba;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-1645.524,301.5656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-1648.524,205.5657;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-1480.524,292.5656;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1319.524,338.5656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;31;-1155.549,346.2721;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-880.1097,364.1581;Inherit;False;AdjustedViewDirection;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;-1482.965,-389.1546;Inherit;True;Property;_TextureSample0;Texture Sample 0;17;0;Create;True;0;0;False;0;-1;None;bd46706ff72992a4c8a07db09bba3dce;True;0;False;white;Auto;False;Instance;12;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1472.965,-469.1546;Inherit;False;Property;_Float0;Float 0;8;0;Create;True;0;0;False;0;0.5;0.6745818;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1425.685,-96.89941;Inherit;False;32;AdjustedViewDirection;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-1171.965,-402.1546;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1247.275,1561.611;Inherit;False;Property;_Float7;Float 7;15;0;Create;True;0;0;False;0;0.1;0.233;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1468.965,-186.1546;Inherit;False;Property;_Float1;Float 1;0;0;Create;True;0;0;False;0;1.3;0.144863;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1098.545,1472.885;Inherit;False;Constant;_Float6;Float 6;18;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;72;-854.5455,1541.885;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;1;-934.965,-284.1546;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-966.965,-406.1546;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-984.916,1274.571;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;71;-853.5455,1441.885;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;61;-624.7772,1660.422;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;60;-570.5081,1293.527;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-710.965,-307.1546;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;62;-623.6937,1589.917;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;12;-563.965,-335.1546;Inherit;True;Property;_TextureSample1;Texture Sample 1;17;0;Create;True;0;0;False;0;-1;None;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;57;-389.065,1376.479;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;13;-467.965,-505.1546;Inherit;False;Property;_Color0;Color 0;9;0;Create;True;0;0;False;0;0.4716981,0.4716981,0.5176471,0;0.1995817,0.1995817,0.3679245,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-462.965,-683.1547;Inherit;False;Property;_Color1;Color 1;10;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;-610.4879,93.28198;Inherit;False;Property;_Float8;Float 8;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-557.4967,-131.0296;Inherit;True;Property;_TextureSample2;Texture Sample 2;18;0;Create;True;0;0;False;0;-1;None;512d32701bcc64c4ca71fb6fe1b297af;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;58;-389.2397,1499.681;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-231.4879,-114.718;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-201.1202,1434.162;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;15;-182.965,-472.1546;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;64;87.0481,860.5792;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;16;21.77034,-330.5775;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;384.7477,839.7792;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;18;236.0475,-325.9876;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;69;153.9001,511.2236;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;389.8173,-330.4301;Inherit;True;ParallaxOut;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;583.9001,430.2236;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-1644.271,128.8979;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;41;346.9841,604.5765;Inherit;False;Property;_Float5;Float 5;16;0;Create;True;0;0;False;0;0.1294118;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1063.513,585.2535;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;201.9841,321.5765;Inherit;False;36;Height;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-1186.296,-289.5327;Inherit;False;Height;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;716.9001,529.2236;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;1291,125;Inherit;False;Property;_Float2;Float 2;12;0;Create;True;0;0;False;0;0;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;1386.585,-69.23189;Inherit;False;19;ParallaxOut;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;1390.962,12.13271;Inherit;False;34;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;38;391.9842,387.5765;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;223.9841,408.5765;Inherit;False;Property;_Float4;Float 4;13;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1660,-13;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Ice;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;True;0;False;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;5;22;0
WireConnection;27;0;25;1
WireConnection;27;1;25;2
WireConnection;24;0;23;1
WireConnection;24;1;23;2
WireConnection;28;0;24;0
WireConnection;28;1;27;0
WireConnection;30;0;28;0
WireConnection;30;1;25;3
WireConnection;31;0;30;0
WireConnection;32;0;31;0
WireConnection;4;0;3;0
WireConnection;4;1;8;2
WireConnection;72;0;74;0
WireConnection;72;1;74;0
WireConnection;1;0;4;0
WireConnection;1;1;9;0
WireConnection;1;2;33;0
WireConnection;71;0;73;0
WireConnection;71;1;73;0
WireConnection;61;0;72;0
WireConnection;60;0;59;0
WireConnection;11;0;10;0
WireConnection;11;1;1;0
WireConnection;62;0;71;0
WireConnection;12;1;11;0
WireConnection;57;0;60;0
WireConnection;57;1;71;0
WireConnection;57;2;72;0
WireConnection;58;0;60;0
WireConnection;58;1;62;0
WireConnection;58;2;61;0
WireConnection;76;0;17;0
WireConnection;76;1;75;0
WireConnection;63;0;57;0
WireConnection;63;1;58;0
WireConnection;15;0;14;0
WireConnection;15;1;13;0
WireConnection;15;2;12;2
WireConnection;64;0;63;0
WireConnection;16;0;15;0
WireConnection;16;1;76;0
WireConnection;65;0;64;0
WireConnection;65;1;64;1
WireConnection;18;0;16;0
WireConnection;19;0;18;0
WireConnection;67;0;65;0
WireConnection;67;1;69;0
WireConnection;34;0;23;0
WireConnection;66;0;68;0
WireConnection;66;1;65;0
WireConnection;36;0;8;2
WireConnection;68;0;67;0
WireConnection;68;1;41;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;0;0;20;0
WireConnection;0;1;35;0
WireConnection;0;4;21;0
WireConnection;0;6;20;0
WireConnection;0;7;20;0
WireConnection;0;11;68;0
ASEEND*/
//CHKSM=B31389CB201287BA1A0A4EBF28F4DCE98708F979