// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BaneArt/SnowDepression"
{
	Properties
	{
		_GradientHeight("GradientHeight", Range( 0 , 20)) = 6.4
		_Top_Y("Top_Y", Color) = (0.7259277,0.7647059,0.06185123,0)
		_Top_XZ("Top_XZ", Color) = (0.2569204,0.5525266,0.7279412,0)
		_Bot_Y("Bot_Y", Color) = (0.3877363,0.5955882,0.188311,0)
		_Bot_XZ("Bot_XZ", Color) = (0.7058823,0.2024221,0.2024221,0)
		_NormalMap("NormalMap", 2D) = "bump" {}
		_VertextOffsetStrength("VertextOffsetStrength", Range( 0 , 5)) = 1
		_VertextOffsetRadius("VertextOffsetRadius", Range( 0 , 10)) = 5.588235
		_VertOffsetMultiplier("VertOffsetMultiplier", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform int ArrayLength;
		uniform float4 positionsArray[42];
		uniform float _VertextOffsetRadius;
		uniform float _VertextOffsetStrength;
		uniform float _VertOffsetMultiplier;
		uniform sampler2D _NormalMap;
		uniform float4 _Bot_XZ;
		uniform float4 _Bot_Y;
		uniform float4 _Top_XZ;
		uniform float4 _Top_Y;
		uniform float _GradientHeight;


		float DistanceCheck18_g13( float3 WorldPos , int ArrayLength , float3 objectPosition )
		{
			float closest=10000;
			float now=0;
			for(int i=0; i<ArrayLength;i++)
			{
			  now = distance(WorldPos,positionsArray[i]);
			  if(now < closest)
			  {
			    closest = now;
			  }
			}
			return closest;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 WorldPos18_g13 = ase_worldPos;
			int ArrayLength18_g13 = ArrayLength;
			float3 objectPosition18_g13 = positionsArray[clamp(0,0,(42 - 1))].xyz;
			float localDistanceCheck18_g13 = DistanceCheck18_g13( WorldPos18_g13 , ArrayLength18_g13 , objectPosition18_g13 );
			float clampResult10_g13 = clamp( pow( ( localDistanceCheck18_g13 / _VertextOffsetRadius ) , _VertextOffsetStrength ) , 0.0 , 1.0 );
			float2 lerpResult62 = lerp( float2( 0,1 ) , float2( 0,0 ) , clampResult10_g13);
			v.vertex.xyz += float3( ( lerpResult62 * _VertOffsetMultiplier ) ,  0.0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 Normal65 = UnpackNormal( tex2D( _NormalMap, i.uv_texcoord ) );
			o.Normal = Normal65;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_22_0 = abs( ase_worldNormal );
			float temp_output_23_0 = (( temp_output_22_0 * temp_output_22_0 )).y;
			float4 lerpResult17 = lerp( _Bot_XZ , _Bot_Y , temp_output_23_0);
			float4 lerpResult27 = lerp( _Top_XZ , _Top_Y , temp_output_23_0);
			float3 ase_worldPos = i.worldPos;
			float clampResult32 = clamp( ( ase_worldPos.y / _GradientHeight ) , 0.0 , 1.0 );
			float4 lerpResult28 = lerp( lerpResult17 , lerpResult27 , clampResult32);
			float4 temp_cast_0 = (0.0).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float4 clampResult42 = clamp( lerpResult28 , temp_cast_0 , temp_cast_1 );
			float4 Albedo67 = clampResult42;
			o.Albedo = Albedo67.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
1972;43;1049;728;149.8462;-286.4899;1.76488;True;False
Node;AmplifyShaderEditor.CommentaryNode;43;-2309.229,387.8848;Inherit;False;901.0599;287.59;Get World Y Vector Mask;4;23;8;22;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;8;-2272.451,474.9954;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;46;-2264.596,-210.1021;Inherit;False;730.3268;510.8144;Create the world gradient;5;2;5;32;33;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;22;-2001.508,487.0916;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2214.596,7.199674;Float;False;Property;_GradientHeight;GradientHeight;0;0;Create;True;0;0;False;0;6.4;2.2;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;45;-1762.024,1189.983;Inherit;False;907.8201;534.3306;The same lerp for the Top Gradient Colors;3;27;26;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1802.105,484.8918;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;44;-1757.627,730.2855;Inherit;False;897.6793;426.1704;Lerp the 2 Gradient Bottom Colors according to the above normals y vector;3;21;17;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;7;-2446.796,-289.1021;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;25;-1699.706,1273.792;Float;False;Property;_Top_XZ;Top_XZ;2;0;Create;True;0;0;False;0;0.2569204,0.5525266,0.7279412,0;0,0.3038753,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-1710.605,947.5924;Float;False;Property;_Bot_Y;Bot_Y;3;0;Create;True;0;0;False;0;0.3877363,0.5955882,0.188311,0;0.6886792,0.6886792,0.6886792,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;19;-1710.304,780.3916;Float;False;Property;_Bot_XZ;Bot_XZ;4;0;Create;True;0;0;False;0;0.7058823,0.2024221,0.2024221,0;0.7404704,0,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-1896.661,-81.79171;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1938.991,180.7123;Float;False;Constant;_Float1;Float 1;-1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;-1708.009,1484.99;Float;False;Property;_Top_Y;Top_Y;1;0;Create;True;0;0;False;0;0.7259277,0.7647059,0.06185123,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;23;-1620.908,491.5916;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1935.627,86.51085;Float;False;Constant;_Float0;Float 0;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;54;-220.1427,469.293;Inherit;False;574.3599;190.4;Lerp the Bottom and Top Colors according to the world gradient;1;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;17;-1086.904,837.2902;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;27;-1096.107,1417.091;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;32;-1722.269,-84.3163;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;543.6882,1062.363;Inherit;False;Property;_VertextOffsetRadius;VertextOffsetRadius;7;0;Create;True;0;0;False;0;5.588235;2.43;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;543.6882,1144.364;Inherit;False;Property;_VertextOffsetStrength;VertextOffsetStrength;6;0;Create;True;0;0;False;0;1;1.98;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;570.0342,-202.7786;Inherit;False;918;182;Final Clamp, you can disable it or rise the max value if you want to produce values higher than 1 for HDR;2;42;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;28;-170.1427,519.293;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;53;-1759.043,-517.9124;Inherit;False;359;265;Normal Map;1;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2167.653,-535.7055;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;42;620.0342,-152.7785;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;58;959.5684,818.5287;Inherit;False;Constant;_Vector0;Vector 0;9;0;Create;True;0;0;False;0;0,1;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;59;959.5684,962.5286;Inherit;False;Constant;_Vector1;Vector 1;10;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;60;837.0358,1094.216;Inherit;False;DistanceBlendObjectArray;-1;;13;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1709.043,-467.9123;Inherit;True;Property;_NormalMap;NormalMap;5;0;Create;True;0;0;False;0;None;10ff51d2d87fb7b46b70b55f8551c146;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;62;1200.099,824.4551;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;801.3168,-114.917;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-1336.683,-422.9244;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;61;1201.243,960.9529;Inherit;False;Property;_VertOffsetMultiplier;VertOffsetMultiplier;8;0;Create;True;0;0;False;0;0;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;55;1607.965,38.88491;Inherit;False;596.7905;477.5201;Created by Mourelas Konstantinos @mourelask - www.moure.xyz;1;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;1517.086,829.335;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;1423.383,104.5813;Inherit;False;67;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;1419.272,201.9599;Inherit;False;65;Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1777.777,104.7652;Float;False;True;2;ASEMaterialInspector;0;0;Standard;BaneArt/SnowDepression;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;8;0
WireConnection;15;0;22;0
WireConnection;15;1;22;0
WireConnection;5;0;7;2
WireConnection;5;1;2;0
WireConnection;23;0;15;0
WireConnection;17;0;19;0
WireConnection;17;1;21;0
WireConnection;17;2;23;0
WireConnection;27;0;25;0
WireConnection;27;1;26;0
WireConnection;27;2;23;0
WireConnection;32;0;5;0
WireConnection;32;1;33;0
WireConnection;32;2;34;0
WireConnection;28;0;17;0
WireConnection;28;1;27;0
WireConnection;28;2;32;0
WireConnection;42;0;28;0
WireConnection;42;1;33;0
WireConnection;42;2;34;0
WireConnection;60;20;56;0
WireConnection;60;21;57;0
WireConnection;9;1;11;0
WireConnection;62;0;58;0
WireConnection;62;1;59;0
WireConnection;62;2;60;0
WireConnection;67;0;42;0
WireConnection;65;0;9;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;0;0;68;0
WireConnection;0;1;66;0
WireConnection;0;11;63;0
ASEEND*/
//CHKSM=7913431F56C559284A90D471AD887CE1C619CB8F