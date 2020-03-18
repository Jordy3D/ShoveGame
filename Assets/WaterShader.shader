// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterShader"
{
	Properties
	{
		_BaseColour("Base Colour", Color) = (0,0.4037895,1,1)
		_VertDirection("Vert Direction", Range( -1 , 1)) = 0
		_WaveSpeed("Wave Speed", Vector) = (0,0,0,0)
		_Float1("Float 1", Float) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_EdgeColour("Edge Colour", Color) = (0,0,0,0)
		_IntersectIntensity("Intersect Intensity", Range( 0 , 1)) = 0.2
		_WaveBrightness("Wave Brightness", Range( 0 , 2)) = 0
		_Int0("Int 0", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform float2 _WaveSpeed;
		uniform float _Float1;
		uniform int _Int0;
		uniform float _VertDirection;
		uniform float4 _EdgeColour;
		uniform float4 _BaseColour;
		uniform float _WaveBrightness;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _IntersectIntensity;
		uniform float _Opacity;


		float3 modulo3( float3 divident , float3 divisor )
		{
			float3 positiveDivident = divident % divisor + divisor;
			return positiveDivident % divisor;
		}


		float rand3dTo1d( float3 value , float3 dotDir )
		{
			//make value smaller to avoid artefacts
				float3 smallValue = cos(value);
				//get scalar value from 3d vector
				float random = dot(smallValue, dotDir);
				//make value more random by making it bigger and then taking the factional part
				random = frac(sin(random) * 143758.5453);
				return random;
		}


		float rand1dTo1d( float value , float mutator )
		{
			float random = frac(sin(value + mutator) * 143758.5453);
				return random;
		}


		float rand3dTo1d1Param( float3 value )
		{
			float3 dotDir = float3(12.9898, 78.233, 37.719); 
			//make value smaller to avoid artefacts
				float3 smallValue = cos(value);
				//get scalar value from 3d vector
				float random = dot(smallValue, dotDir);
				//make value more random by making it bigger and then taking the factional part
				random = frac(sin(random) * 143758.5453);
				return random;
		}


		float3 rand3dTo3d( float3 value )
		{
			return float3(
					rand3dTo1d(value, float3(12.989, 78.233, 37.719)),
					rand3dTo1d(value, float3(39.346, 11.135, 83.155)),
					rand3dTo1d(value, float3(73.156, 52.235, 09.151))
				);
		}


		float3 rand1dTo3d( float value )
		{
			return float3(
					rand1dTo1d(value, 3.9812),
					rand1dTo1d(value, 7.1536),
					rand1dTo1d(value, 5.7241)
				);
		}


		float3 voronoiNoise( float3 value , float3 period , float3 angleOffset )
		{
			float3 baseCell = floor(value);
							//first pass to find the closest cell
							float minDistToCell = 10;
							float3 toClosestCell;
							float3 closestCell;
							[unroll]
							for(int x1=-1; x1<=1; x1++){
								[unroll]
								for(int y1=-1; y1<=1; y1++){
									[unroll]
									for(int z1=-1; z1<=1; z1++){
										float3 cell = baseCell + float3(x1, y1, z1);
										float3 tiledCell = modulo3(cell, period);
										float3 cellPosition = cell + rand3dTo3d(tiledCell)*angleOffset;
										float3 toCell = cellPosition - value;
										float distToCell = length(toCell);
										if(distToCell < minDistToCell){
											minDistToCell = distToCell;
											closestCell = cell;
											toClosestCell = toCell;
										}
									}
								}
							}
							//second pass to find the distance to the closest edge
							float minEdgeDistance = 10;
							[unroll]
							for(int x2=-1; x2<=1; x2++){
								[unroll]
								for(int y2=-1; y2<=1; y2++){
									[unroll]
									for(int z2=-1; z2<=1; z2++){
										float3 cell = baseCell + float3(x2, y2, z2);
										float3 tiledCell = modulo3(cell, period);
										float3 cellPosition = cell + rand3dTo3d(tiledCell);
										float3 toCell = cellPosition - value;
										float3 diffToClosestCell = abs(closestCell - cell);
										bool isClosestCell = diffToClosestCell.x + diffToClosestCell.y + diffToClosestCell.z < 0.1;
										if(!isClosestCell){
											float3 toCenter = (toClosestCell + toCell) * 0.5;
											float3 cellDifference = normalize(toCell - toClosestCell);
											float edgeDistance = dot(toCenter, cellDifference);
											minEdgeDistance = min(minEdgeDistance, edgeDistance);
										}
									}
								}
							}
							float random = rand3dTo1d1Param(closestCell);
							return float3(minDistToCell, random, minEdgeDistance);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 panner53 = ( _Time.y * _WaveSpeed + v.texcoord.xy);
			float3 appendResult14_g2 = (float3(panner53 , _Float1));
			float3 value5_g2 = ( appendResult14_g2 * (float)_Int0 );
			float3 temp_cast_1 = _Int0;
			float3 period5_g2 = temp_cast_1;
			float3 angleOffset5_g2 = float3(1,1,1);
			float3 localvoronoiNoise5_g2 = voronoiNoise( value5_g2 , period5_g2 , angleOffset5_g2 );
			float3 break9_g2 = localvoronoiNoise5_g2;
			float temp_output_51_0 = ( break9_g2.x * 1.0 );
			float4 temp_cast_2 = (temp_output_51_0).xxxx;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( temp_cast_2 * _VertDirection * float4( ase_vertexNormal , 0.0 ) ) - float4( ( ( _VertDirection * 0.2 ) * ase_vertexNormal ) , 0.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner53 = ( _Time.y * _WaveSpeed + i.uv_texcoord);
			float3 appendResult14_g2 = (float3(panner53 , _Float1));
			float3 value5_g2 = ( appendResult14_g2 * (float)_Int0 );
			float3 temp_cast_1 = _Int0;
			float3 period5_g2 = temp_cast_1;
			float3 angleOffset5_g2 = float3(1,1,1);
			float3 localvoronoiNoise5_g2 = voronoiNoise( value5_g2 , period5_g2 , angleOffset5_g2 );
			float3 break9_g2 = localvoronoiNoise5_g2;
			float temp_output_51_0 = ( break9_g2.x * 1.0 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth27 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth27 = abs( ( screenDepth27 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _IntersectIntensity ) );
			float clampResult28 = clamp( distanceDepth27 , 0.0 , 1.0 );
			float4 lerpResult30 = lerp( _EdgeColour , ( _BaseColour + ( temp_output_51_0 * _WaveBrightness ) ) , clampResult28);
			o.Albedo = lerpResult30.rgb;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;1033.674;0.08679199;1;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;55;-364.3408,979.6116;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;54;-356.8863,848.6229;Inherit;False;Property;_WaveSpeed;Wave Speed;4;0;Create;True;0;0;False;0;0,0;0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-409.2769,725.333;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;53;-89.94756,817.6898;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;66;-38.75604,1026.972;Inherit;False;Property;_Int0;Int 0;13;0;Create;True;0;0;False;0;0;4;0;1;INT;0
Node;AmplifyShaderEditor.Vector3Node;45;-66.32704,667.6045;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;47;-36.71063,945.025;Inherit;False;Property;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;50;254.2894,805.0255;Inherit;True;VoronoiNoise3DTiled;-1;;2;73ed0a6f92eaf7a468d8a4b71f8f6990;0;5;19;FLOAT3;0,0,0;False;12;FLOAT2;0,0;False;13;FLOAT;0;False;18;FLOAT;0;False;17;FLOAT3;4,4,4;False;3;FLOAT;0;FLOAT;11;FLOAT;10
Node;AmplifyShaderEditor.RangedFloatNode;10;291.522,1070.22;Inherit;False;Property;_VertDirection;Vert Direction;3;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;598.2894,805.0255;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;451.9549,406.7192;Inherit;False;Property;_WaveBrightness;Wave Brightness;12;0;Create;True;0;0;False;0;0;0.75;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;19.28314,-180.7346;Float;False;Property;_IntersectIntensity;Intersect Intensity;10;0;Create;True;0;0;False;0;0.2;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;238.9,-72;Inherit;False;Property;_BaseColour;Base Colour;1;0;Create;True;0;0;False;0;0,0.4037895,1,1;0,0.4037895,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;747.3198,335.4242;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;27;323.2825,-212.7346;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;784.7733,1008.154;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;60;964.7733,1097.154;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;28;595.2827,-244.7346;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;690.2825,-442.7343;Inherit;False;Property;_EdgeColour;Edge Colour;9;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;815.1979,66.53529;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;56;987.8808,750.3081;Inherit;False;VertexOffset;-1;;3;b9a3cc058467e064aa80449e66217e26;0;2;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1162.773,918.1538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-499.6738,440.9132;Inherit;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;False;0;0.04705882;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-1027.614,241.0637;Inherit;False;Constant;_Float2;Float 2;14;0;Create;True;0;0;False;0;8.058824;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;68;-967.6142,117.0636;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;67;-746.6142,119.0636;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.SmoothstepOpNode;70;-439.1182,201.9043;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;71;-152.6738,298.9132;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-823.2026,-89.9279;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;97.32617,387.9132;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;1052.898,235.979;Inherit;False;Property;_Opacity;Opacity;8;0;Create;True;0;0;False;0;0;0.758;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;58;1183.773,738.1539;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-85.71063,1213.025;Inherit;False;Property;_Period;Period;7;0;Create;True;0;0;False;0;8;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;30;998.4892,-358.8539;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2283.555,92.53372;Float;True;Property;_Float0;Float 0;2;0;Create;True;0;0;False;0;5;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;73;-691.6738,378.9132;Inherit;False;Constant;_Vector1;Vector 1;14;0;Create;True;0;0;False;0;0,1.31;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;48;56.28937,1198.025;Inherit;False;Property;_CellCount;Cell Count;6;0;Create;True;0;0;False;0;16;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;860.7732,898.1539;Inherit;False;Property;_Vertex0Point;Vertex 0 Point;11;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;32;-1101.148,-115.4679;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;75;-228.6738,531.9132;Inherit;False;Constant;_Float4;Float 4;14;0;Create;True;0;0;False;0;10;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1394,15;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;WaterShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;53;0;52;0
WireConnection;53;2;54;0
WireConnection;53;1;55;0
WireConnection;50;19;45;0
WireConnection;50;12;53;0
WireConnection;50;13;47;0
WireConnection;50;18;66;0
WireConnection;50;17;66;0
WireConnection;51;0;50;0
WireConnection;64;0;51;0
WireConnection;64;1;65;0
WireConnection;27;0;26;0
WireConnection;63;0;10;0
WireConnection;28;0;27;0
WireConnection;23;0;1;0
WireConnection;23;1;64;0
WireConnection;56;1;51;0
WireConnection;56;2;10;0
WireConnection;61;0;63;0
WireConnection;61;1;60;0
WireConnection;67;0;68;0
WireConnection;67;2;69;0
WireConnection;70;0;67;0
WireConnection;70;1;73;1
WireConnection;70;2;73;2
WireConnection;71;0;70;0
WireConnection;71;1;72;0
WireConnection;34;0;32;1
WireConnection;34;1;32;3
WireConnection;74;0;71;0
WireConnection;74;1;75;0
WireConnection;58;0;56;0
WireConnection;58;1;61;0
WireConnection;30;0;29;0
WireConnection;30;1;23;0
WireConnection;30;2;28;0
WireConnection;0;0;30;0
WireConnection;0;9;24;0
WireConnection;0;11;58;0
ASEEND*/
//CHKSM=AD54092682FACC0FE3A97F52465078EFC38B4FB6