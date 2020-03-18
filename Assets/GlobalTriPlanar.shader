// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/GlobalTriPlanar"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Falloff("Falloff", Float) = 0
		_Scale("Scale", Float) = 0
		_Contrast("Contrast", Range( -10 , 0)) = -1.638255
		_HeightSharpness("Height Sharpness", Range( 0 , 10)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#define ASE_TEXTURE_PARAMS(textureName) textureName

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
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _Contrast;
		uniform sampler2D _Texture0;
		uniform float _Scale;
		uniform float _Falloff;
		uniform float _HeightSharpness;


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


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float3 appendResult14_g2 = (float3(i.uv_texcoord , 0.0));
			float3 value5_g2 = ( appendResult14_g2 * 16.0 );
			float3 temp_cast_0 = (8.0).xxx;
			float3 period5_g2 = temp_cast_0;
			float3 angleOffset5_g2 = float3(1,1,1);
			float3 localvoronoiNoise5_g2 = voronoiNoise( value5_g2 , period5_g2 , angleOffset5_g2 );
			float3 break9_g2 = localvoronoiNoise5_g2;
			float3 temp_cast_1 = (( break9_g2.x * 1.0 )).xxx;
			o.Albedo = temp_cast_1;
			float2 appendResult7 = (float2(_Scale , _Scale));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 objToWorld22 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float4 triplanar1 = TriplanarSamplingSF( _Texture0, objToWorld22, ase_worldNormal, _Falloff, appendResult7, 1.0, 0 );
			float grayscale10_g1 = Luminance(( CalculateContrast((-10.0 + (1.0 - -1.0) * (20.0 - -10.0) / (1.0 - -1.0)),( 1.0 - CalculateContrast(_Contrast,triplanar1) )) * _HeightSharpness ).rgb);
			float clampResult11_g1 = clamp( grayscale10_g1 , 0.0 , 1.0 );
			float3 temp_cast_4 = (( 1.0 - clampResult11_g1 )).xxx;
			o.Emission = temp_cast_4;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
Version=17500
2104;140;1390;791;680.8324;125.9329;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;6;-973,75;Inherit;False;Property;_Scale;Scale;5;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-843,166;Inherit;False;Property;_Falloff;Falloff;4;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-820,70;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformPositionNode;22;-900.8324,-76.93286;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexturePropertyNode;2;-981.3,-281.7998;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;None;e280124c74dc03f42b90c2fefd900752;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-477.0572,98.61846;Inherit;False;Property;_Contrast;Contrast;6;0;Create;True;0;0;False;0;-1.638255;-1.47;-10;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;32;-906.8324,318.0671;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-972.8324,496.0671;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-480.4234,178.5168;Inherit;False;Property;_HeightSharpness;Height Sharpness;7;0;Create;True;0;0;False;0;2;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-911.8324,621.0671;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-910.8324,709.0671;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-904.8324,810.0671;Inherit;False;Constant;_Float2;Float 1;6;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;1;-587,-93;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;-1;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;8;-153.9816,-29.03299;Inherit;False;HeightFromTexture;1;;1;5212fa4bb062b9847bd4845fd9d7b7d6;0;3;15;COLOR;-1.6,0,0,0;False;14;FLOAT;-1.6;False;13;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;23;-564.8324,402.0671;Inherit;True;VoronoiNoise3DTiled;-1;;2;73ed0a6f92eaf7a468d8a4b71f8f6990;0;5;19;FLOAT3;0,0,0;False;12;FLOAT2;0,0;False;13;FLOAT;0;False;18;FLOAT;0;False;17;FLOAT3;4,4,4;False;3;FLOAT;0;FLOAT;11;FLOAT;10
Node;AmplifyShaderEditor.WireNode;20;-687.9339,0.06935501;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;197.6907,-120.2757;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;11;65.49837,-29.71953;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-216.5095,-281.1756;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-423.1092,-211.0759;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-95.8324,260.0671;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-96.8324,470.0671;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-95.8324,681.0671;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-551.8091,-188.9762;Inherit;False;2;2;0;FLOAT2;10,10;False;1;FLOAT2;10,10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;358.6462,-88.68637;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/GlobalTriPlanar;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;6;0
WireConnection;7;1;6;0
WireConnection;1;0;2;0
WireConnection;1;9;22;0
WireConnection;1;3;7;0
WireConnection;1;4;4;0
WireConnection;8;15;1;0
WireConnection;8;14;9;0
WireConnection;8;13;10;0
WireConnection;23;19;32;0
WireConnection;23;12;24;0
WireConnection;23;13;25;0
WireConnection;23;18;26;0
WireConnection;23;17;31;0
WireConnection;20;0;7;0
WireConnection;17;0;18;0
WireConnection;17;1;1;0
WireConnection;11;0;8;0
WireConnection;18;0;2;0
WireConnection;18;1;19;0
WireConnection;19;0;21;0
WireConnection;28;0;23;0
WireConnection;29;0;23;11
WireConnection;30;0;23;10
WireConnection;21;1;20;0
WireConnection;0;0;28;0
WireConnection;0;2;11;0
ASEEND*/
//CHKSM=5A22147465E968D453BC1DC6359D6D260529047E