// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BaneArt/EchoRing"
{
	Properties
	{
		_DepthFadeDistance("Depth Fade Distance", Float) = 0
		_IntersectionColor("Intersection Color", Color) = (0.4338235,0.4377282,1,0)

	}
	
	SubShader
	{
		LOD 0

		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		
		Pass
		{
			
			Name "First Pass"
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off
			ColorMask RGBA
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float4 _IntersectionColor;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _DepthFadeDistance;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float4 IntersectionColor184 = _IntersectionColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth146 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFadeDistance ) );
				float SaturatedDepthFade186 = saturate( distanceDepth146 );
				float4 appendResult143 = (float4((IntersectionColor184).rgb , ( 1.0 - SaturatedDepthFade186 )));
				
				
				finalColor = appendResult143;
				return finalColor;
			}
			ENDCG
		}

		
		Pass
		{
			Name "Second Pass"
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Back
			ColorMask RGBA
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _DepthFadeDistance;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth146 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFadeDistance ) );
				float SaturatedDepthFade186 = saturate( distanceDepth146 );
				float4 appendResult154 = (float4(SaturatedDepthFade186 , (float3( 0,0,0 )).xyz));
				
				
				finalColor = appendResult154;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
2173;204;1390;660;-746.8961;1846.298;1.923158;True;False
Node;AmplifyShaderEditor.CommentaryNode;188;1586,-1560.752;Inherit;False;1268.871;416.1864;;9;143;174;148;184;186;149;172;146;147;First Pass only renders intersection;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;147;1636,-1252;Float;False;Property;_DepthFadeDistance;Depth Fade Distance;0;0;Create;True;0;0;False;0;0;2.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;146;1876,-1268;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;149;2068,-1268;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;192;2188.621,-1077.181;Inherit;False;668.4583;299.6378;;3;180;154;187;Combining everything through generated alphas;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;2244,-1300;Float;False;SaturatedDepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;2403.213,-1014.743;Inherit;False;186;SaturatedDepthFade;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;180;2439.03,-928.3812;Inherit;False;True;True;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;148;2500.241,-1323.973;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;184;2180,-1508;Float;False;IntersectionColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;174;2414.56,-1510.752;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;172;1940,-1508;Float;False;Property;_IntersectionColor;Intersection Color;1;0;Create;True;0;0;False;0;0.4338235,0.4377282,1,0;0.04313726,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;143;2682.616,-1443.884;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;154;2684.079,-968.7732;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;135;2913.303,-1447.391;Float;False;True;-1;2;ASEMaterialInspector;0;9;BaneArt/EchoRing;003dfa9c16768d048b74f75c088119d8;True;First;0;0;First Pass;2;False;False;False;False;False;False;False;False;False;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;False;0;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;True;2;0;;0;0;Standard;0;0;2;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;138;2902.324,-986.4421;Float;False;False;-1;2;ASEMaterialInspector;0;9;ASETemplateShaders/DoublePassUnlit;003dfa9c16768d048b74f75c088119d8;True;Second;0;1;Second Pass;2;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;0;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;True;2;0;;0;0;Standard;0;0
WireConnection;146;0;147;0
WireConnection;149;0;146;0
WireConnection;186;0;149;0
WireConnection;148;0;186;0
WireConnection;184;0;172;0
WireConnection;174;0;184;0
WireConnection;143;0;174;0
WireConnection;143;3;148;0
WireConnection;154;0;187;0
WireConnection;154;1;180;0
WireConnection;135;0;143;0
WireConnection;138;0;154;0
ASEEND*/
//CHKSM=3595BBA235400F26341653FCC1808482ADB3FD53