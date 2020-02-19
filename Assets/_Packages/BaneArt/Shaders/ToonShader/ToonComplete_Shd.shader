// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33051,y:32756,varname:node_3138,prsc:2|normal-18-OUT,emission-9336-OUT,custl-4934-OUT,olwid-2765-OUT,olcol-8671-OUT;n:type:ShaderForge.SFN_Slider,id:9037,x:32541,y:33054,ptovrint:False,ptlb:Outline Thickness,ptin:_OutlineThickness,varname:node_9037,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.02,max:1;n:type:ShaderForge.SFN_Vector1,id:5779,x:32698,y:33124,varname:node_5779,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:2765,x:32867,y:33054,varname:node_2765,prsc:2|A-9037-OUT,B-5779-OUT;n:type:ShaderForge.SFN_Color,id:8218,x:30963,y:32807,ptovrint:False,ptlb:Colour,ptin:_Colour,varname:node_8218,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.1075368,c2:0.361917,c3:0.8602941,c4:1;n:type:ShaderForge.SFN_NormalVector,id:3440,x:30969,y:32348,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:7901,x:30969,y:32188,varname:node_7901,prsc:2;n:type:ShaderForge.SFN_Dot,id:9112,x:31135,y:32188,varname:node_9112,prsc:2,dt:1|A-7901-OUT,B-3440-OUT;n:type:ShaderForge.SFN_Posterize,id:5086,x:31521,y:32188,varname:node_5086,prsc:2|IN-3855-OUT,STPS-3571-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7875,x:30963,y:32737,ptovrint:False,ptlb:Posterise Steps,ptin:_PosteriseSteps,varname:node_7875,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Multiply,id:7646,x:32698,y:33174,varname:node_7646,prsc:2|A-4381-OUT,B-4496-OUT;n:type:ShaderForge.SFN_Slider,id:4496,x:32372,y:33223,ptovrint:False,ptlb:Outline Darkness,ptin:_OutlineDarkness,varname:node_4496,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5641026,max:1;n:type:ShaderForge.SFN_Set,id:6202,x:31276,y:32817,varname:Colour,prsc:2|IN-9803-OUT;n:type:ShaderForge.SFN_Get,id:9336,x:32867,y:32873,varname:node_9336,prsc:2|IN-6202-OUT;n:type:ShaderForge.SFN_LightColor,id:7500,x:31302,y:32358,varname:node_7500,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:5903,x:31135,y:32358,varname:node_5903,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3855,x:31302,y:32188,varname:node_3855,prsc:2|A-9112-OUT,B-5903-OUT;n:type:ShaderForge.SFN_Add,id:9939,x:31730,y:32309,varname:node_9939,prsc:2|A-4971-OUT,B-2127-OUT;n:type:ShaderForge.SFN_Posterize,id:4814,x:31521,y:32051,varname:node_4814,prsc:2|IN-3855-OUT,STPS-5885-OUT;n:type:ShaderForge.SFN_Multiply,id:8327,x:31730,y:32051,varname:node_8327,prsc:2|A-4814-OUT,B-5086-OUT;n:type:ShaderForge.SFN_Set,id:3072,x:31276,y:32737,varname:StepValue,prsc:2|IN-3622-OUT;n:type:ShaderForge.SFN_Get,id:3571,x:31281,y:32309,varname:node_3571,prsc:2|IN-3072-OUT;n:type:ShaderForge.SFN_Get,id:1860,x:31125,y:32051,varname:node_1860,prsc:2|IN-3072-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4971,x:31730,y:32188,ptovrint:False,ptlb:Step Blend,ptin:_StepBlend,varname:node_4971,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-5086-OUT,B-8327-OUT;n:type:ShaderForge.SFN_Multiply,id:5885,x:31302,y:32051,varname:node_5885,prsc:2|A-1860-OUT,B-1860-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4927,x:31916,y:32314,ptovrint:False,ptlb:React With Light Colour,ptin:_ReactWithLightColour,varname:node_4927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-4971-OUT,B-9939-OUT;n:type:ShaderForge.SFN_Tex2d,id:7413,x:30963,y:32963,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_7413,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3fc84c97ef065574e8fbe1febcd56537,ntxv:0,isnm:False|UVIN-1473-UVOUT;n:type:ShaderForge.SFN_SwitchProperty,id:9803,x:31130,y:32817,ptovrint:False,ptlb:Use Diffuse On/Off,ptin:_UseDiffuseOnOff,varname:node_9803,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-8218-RGB,B-7413-RGB;n:type:ShaderForge.SFN_Get,id:4381,x:32508,y:33148,varname:node_4381,prsc:2|IN-6202-OUT;n:type:ShaderForge.SFN_Relay,id:3622,x:31159,y:32737,cmnt:Output Node Zone,varname:node_3622,prsc:2|IN-7875-OUT;n:type:ShaderForge.SFN_Divide,id:2127,x:31521,y:32309,varname:node_2127,prsc:2|A-7500-RGB,B-6132-OUT;n:type:ShaderForge.SFN_Slider,id:5904,x:30978,y:32515,ptovrint:False,ptlb:Colour Strength - Fine,ptin:_ColourStrengthFine,varname:node_5904,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.4,cur:5.348718,max:10;n:type:ShaderForge.SFN_HalfVector,id:2879,x:30950,y:33287,varname:node_2879,prsc:2;n:type:ShaderForge.SFN_Dot,id:2897,x:31116,y:33277,varname:node_2897,prsc:2,dt:1|A-4703-OUT,B-2879-OUT;n:type:ShaderForge.SFN_Power,id:4894,x:31283,y:33277,varname:node_4894,prsc:2|VAL-2897-OUT,EXP-4089-OUT;n:type:ShaderForge.SFN_Exp,id:4089,x:31116,y:33417,varname:node_4089,prsc:2,et:1|IN-9313-OUT;n:type:ShaderForge.SFN_Slider,id:5167,x:30634,y:33417,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_5167,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7281877,max:1;n:type:ShaderForge.SFN_Multiply,id:9313,x:30950,y:33417,varname:node_9313,prsc:2|A-5167-OUT,B-5220-OUT;n:type:ShaderForge.SFN_Vector1,id:5220,x:30791,y:33486,varname:node_5220,prsc:2,v1:10;n:type:ShaderForge.SFN_Posterize,id:4187,x:31446,y:33277,varname:node_4187,prsc:2|IN-4894-OUT,STPS-1808-OUT;n:type:ShaderForge.SFN_Get,id:1808,x:31262,y:33400,varname:node_1808,prsc:2|IN-3072-OUT;n:type:ShaderForge.SFN_NormalVector,id:4703,x:30950,y:33150,prsc:2,pt:False;n:type:ShaderForge.SFN_TexCoord,id:1473,x:30803,y:32963,varname:node_1473,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Get,id:836,x:31916,y:32174,varname:node_836,prsc:2|IN-6202-OUT;n:type:ShaderForge.SFN_Multiply,id:6967,x:32125,y:32174,varname:node_6967,prsc:2|A-836-OUT,B-4489-OUT,C-4927-OUT;n:type:ShaderForge.SFN_Add,id:4779,x:31618,y:33277,varname:node_4779,prsc:2|A-4982-RGB,B-4187-OUT,C-9622-OUT,D-7113-RGB;n:type:ShaderForge.SFN_AmbientLight,id:4982,x:31446,y:33161,varname:node_4982,prsc:2;n:type:ShaderForge.SFN_Get,id:9622,x:31425,y:33400,varname:node_9622,prsc:2|IN-6202-OUT;n:type:ShaderForge.SFN_Set,id:7797,x:31776,y:33277,varname:Gloss,prsc:2|IN-4779-OUT;n:type:ShaderForge.SFN_Get,id:4489,x:31916,y:32224,varname:node_4489,prsc:2|IN-7797-OUT;n:type:ShaderForge.SFN_Set,id:6392,x:32282,y:32314,varname:Toon,prsc:2|IN-7953-OUT;n:type:ShaderForge.SFN_Get,id:4934,x:32867,y:32934,varname:node_4934,prsc:2|IN-6392-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:7953,x:32125,y:32314,ptovrint:False,ptlb:Legacy Mode,ptin:_LegacyMode,varname:node_7953,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6967-OUT,B-4927-OUT;n:type:ShaderForge.SFN_LightColor,id:7113,x:31446,y:33451,varname:node_7113,prsc:2;n:type:ShaderForge.SFN_SwitchProperty,id:8671,x:32867,y:33217,ptovrint:False,ptlb:Custom Outline Colour On/Off,ptin:_CustomOutlineColourOnOff,varname:node_8671,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7646-OUT,B-5615-RGB;n:type:ShaderForge.SFN_Color,id:5615,x:32698,y:33312,ptovrint:False,ptlb:Outline Colour,ptin:_OutlineColour,varname:node_5615,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_TexCoord,id:4015,x:32293,y:32630,varname:node_4015,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:9225,x:32467,y:32630,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:_Diffuse_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bcc5393d69e14ce42840670bfa9a7b73,ntxv:3,isnm:False|UVIN-4015-UVOUT;n:type:ShaderForge.SFN_Set,id:9832,x:32633,y:32630,varname:Normal,prsc:2|IN-9225-RGB;n:type:ShaderForge.SFN_Get,id:18,x:32867,y:32814,varname:node_18,prsc:2|IN-9832-OUT;n:type:ShaderForge.SFN_Multiply,id:6132,x:31302,y:32515,varname:node_6132,prsc:2|A-5904-OUT,B-5984-OUT;n:type:ShaderForge.SFN_Slider,id:5984,x:30978,y:32604,ptovrint:False,ptlb:Colour Strength - Broad,ptin:_ColourStrengthBroad,varname:_LightColourStrength_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-50,cur:10,max:10;proporder:8218-9037-4496-7875-4971-9803-7413-4927-5984-5904-5167-7953-8671-5615-9225;pass:END;sub:END;*/

Shader "Shader Forge/ToonOutline" {
    Properties {
        _Colour ("Colour", Color) = (0.1075368,0.361917,0.8602941,1)
        _OutlineThickness ("Outline Thickness", Range(0, 1)) = 0.02
        _OutlineDarkness ("Outline Darkness", Range(0, 1)) = 0.5641026
        _PosteriseSteps ("Posterise Steps", Float ) = 4
        [MaterialToggle] _StepBlend ("Step Blend", Float ) = 0
        [MaterialToggle] _UseDiffuseOnOff ("Use Diffuse On/Off", Float ) = 0
        _Diffuse ("Diffuse", 2D) = "white" {}
        [MaterialToggle] _ReactWithLightColour ("React With Light Colour", Float ) = 0
        _ColourStrengthBroad ("Colour Strength - Broad", Range(-50, 10)) = 10
        _ColourStrengthFine ("Colour Strength - Fine", Range(0.4, 10)) = 5.348718
        _Gloss ("Gloss", Range(0, 1)) = 0.7281877
        [MaterialToggle] _LegacyMode ("Legacy Mode", Float ) = 0
        [MaterialToggle] _CustomOutlineColourOnOff ("Custom Outline Colour On/Off", Float ) = 0
        _OutlineColour ("Outline Colour", Color) = (1,0,0,1)
        _Normal ("Normal", 2D) = "bump" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float _OutlineThickness;
            uniform float4 _Colour;
            uniform float _OutlineDarkness;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform fixed _UseDiffuseOnOff;
            uniform fixed _CustomOutlineColourOnOff;
            uniform float4 _OutlineColour;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*(_OutlineThickness*0.1),1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 Colour = lerp( _Colour.rgb, _Diffuse_var.rgb, _UseDiffuseOnOff );
                return fixed4(lerp( (Colour*_OutlineDarkness), _OutlineColour.rgb, _CustomOutlineColourOnOff ),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float4 _Colour;
            uniform float _PosteriseSteps;
            uniform fixed _StepBlend;
            uniform fixed _ReactWithLightColour;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform fixed _UseDiffuseOnOff;
            uniform float _ColourStrengthFine;
            uniform float _Gloss;
            uniform fixed _LegacyMode;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _ColourStrengthBroad;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Normal_var = tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal));
                float3 Normal = _Normal_var.rgb;
                float3 normalLocal = Normal;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 Colour = lerp( _Colour.rgb, _Diffuse_var.rgb, _UseDiffuseOnOff );
                float3 emissive = Colour;
                float StepValue = _PosteriseSteps;
                float node_1808 = StepValue;
                float3 Gloss = (UNITY_LIGHTMODEL_AMBIENT.rgb+floor(pow(max(0,dot(i.normalDir,halfDirection)),exp2((_Gloss*10.0))) * node_1808) / (node_1808 - 1)+Colour+_LightColor0.rgb);
                float node_3855 = (max(0,dot(lightDirection,i.normalDir))*attenuation);
                float node_3571 = StepValue;
                float node_5086 = floor(node_3855 * node_3571) / (node_3571 - 1);
                float node_1860 = StepValue;
                float node_5885 = (node_1860*node_1860);
                float _StepBlend_var = lerp( node_5086, (floor(node_3855 * node_5885) / (node_5885 - 1)*node_5086), _StepBlend );
                float3 _ReactWithLightColour_var = lerp( _StepBlend_var, (_StepBlend_var+(_LightColor0.rgb/(_ColourStrengthFine*_ColourStrengthBroad))), _ReactWithLightColour );
                float3 Toon = lerp( (Colour*Gloss*_ReactWithLightColour_var), _ReactWithLightColour_var, _LegacyMode );
                float3 finalColor = emissive + Toon;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float4 _Colour;
            uniform float _PosteriseSteps;
            uniform fixed _StepBlend;
            uniform fixed _ReactWithLightColour;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform fixed _UseDiffuseOnOff;
            uniform float _ColourStrengthFine;
            uniform float _Gloss;
            uniform fixed _LegacyMode;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _ColourStrengthBroad;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Normal_var = tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal));
                float3 Normal = _Normal_var.rgb;
                float3 normalLocal = Normal;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 Colour = lerp( _Colour.rgb, _Diffuse_var.rgb, _UseDiffuseOnOff );
                float StepValue = _PosteriseSteps;
                float node_1808 = StepValue;
                float3 Gloss = (UNITY_LIGHTMODEL_AMBIENT.rgb+floor(pow(max(0,dot(i.normalDir,halfDirection)),exp2((_Gloss*10.0))) * node_1808) / (node_1808 - 1)+Colour+_LightColor0.rgb);
                float node_3855 = (max(0,dot(lightDirection,i.normalDir))*attenuation);
                float node_3571 = StepValue;
                float node_5086 = floor(node_3855 * node_3571) / (node_3571 - 1);
                float node_1860 = StepValue;
                float node_5885 = (node_1860*node_1860);
                float _StepBlend_var = lerp( node_5086, (floor(node_3855 * node_5885) / (node_5885 - 1)*node_5086), _StepBlend );
                float3 _ReactWithLightColour_var = lerp( _StepBlend_var, (_StepBlend_var+(_LightColor0.rgb/(_ColourStrengthFine*_ColourStrengthBroad))), _ReactWithLightColour );
                float3 Toon = lerp( (Colour*Gloss*_ReactWithLightColour_var), _ReactWithLightColour_var, _LegacyMode );
                float3 finalColor = Toon;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
