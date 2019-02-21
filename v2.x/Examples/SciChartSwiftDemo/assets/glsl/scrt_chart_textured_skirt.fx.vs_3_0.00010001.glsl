struct sGridParams {
  highp vec4 ContourScale;
  highp vec4 ContourOffset;
  highp vec4 ContourThickness;
  highp vec4 ContourColorX;
  highp vec4 ContourColorY;
  highp vec4 ContourColorZ;
  highp vec4 Params;
  highp vec4 SurfaceNormal;
  highp vec4 Lighting;
};
uniform highp mat4 matProj;
uniform highp mat4 matWorld;
uniform highp mat4 matWorldView;
uniform sampler2D HeightMapTexture;
uniform sampler2D HeightMapOffsetsTexture;
uniform highp vec4 TextureDimensionsInv;
uniform highp vec4 MeshCellOfssetScalePosition;
uniform highp vec4 MeshCellOfssetScaleTexCoord;
uniform highp vec4 MeshCellOfssetScaleHeights;
uniform sGridParams GridParams;
attribute highp vec4 vPosition;
attribute highp vec4 vTexCoord0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.w = vPosition.w;
  tmpvar_2.zw = vTexCoord0.zw;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1.xz = ((vPosition.xz * MeshCellOfssetScalePosition.xy) + MeshCellOfssetScalePosition.zw);
  highp vec2 _texCoord_6;
  _texCoord_6 = ((vTexCoord0.xy * MeshCellOfssetScaleTexCoord.xy) + MeshCellOfssetScaleTexCoord.zw);
  _texCoord_6.x = mix (TextureDimensionsInv.x, TextureDimensionsInv.z, _texCoord_6.x);
  _texCoord_6.y = mix (TextureDimensionsInv.y, TextureDimensionsInv.w, _texCoord_6.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (HeightMapTexture, _texCoord_6, 0.0);
  tmpvar_1.y = (tmpvar_7.w * vPosition.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = matWorld[0].xyz;
  tmpvar_8[1] = matWorld[1].xyz;
  tmpvar_8[2] = matWorld[2].xyz;
  highp vec2 _texCoord_9;
  _texCoord_9 = ((vTexCoord0.zw * MeshCellOfssetScaleTexCoord.xy) + MeshCellOfssetScaleTexCoord.zw);
  _texCoord_9.x = mix (TextureDimensionsInv.x, TextureDimensionsInv.z, _texCoord_9.x);
  _texCoord_9.y = mix (TextureDimensionsInv.y, TextureDimensionsInv.w, _texCoord_9.y);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DLod (HeightMapTexture, _texCoord_9, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = GridParams.Params.w;
  highp float tmpvar_12;
  tmpvar_12 = mix (tmpvar_1.y, (tmpvar_10.w * vPosition.w), tmpvar_11);
  tmpvar_2.xy = mix (vTexCoord0.xy, vTexCoord0.zw, vec2(tmpvar_11));
  tmpvar_5 = tmpvar_2;
  tmpvar_2.xy = clamp (tmpvar_2.xy, 0.0, 1.0);
  tmpvar_2.xy = mix (TextureDimensionsInv.xy, TextureDimensionsInv.zw, tmpvar_2.xy);
  tmpvar_2.xy = ((tmpvar_2.xy * MeshCellOfssetScaleTexCoord.xy) + MeshCellOfssetScaleTexCoord.zw);
  tmpvar_1.y = ((tmpvar_1.y * MeshCellOfssetScaleHeights.x) + MeshCellOfssetScaleHeights.y);
  tmpvar_4 = tmpvar_1;
  highp vec2 _texCoord_13;
  _texCoord_13 = ((tmpvar_2.xy * MeshCellOfssetScaleTexCoord.xy) + MeshCellOfssetScaleTexCoord.zw);
  _texCoord_13.x = mix (TextureDimensionsInv.x, TextureDimensionsInv.z, _texCoord_13.x);
  _texCoord_13.y = mix (TextureDimensionsInv.y, TextureDimensionsInv.w, _texCoord_13.y);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DLod (HeightMapOffsetsTexture, _texCoord_13, 0.0);
  highp vec2 tmpvar_15;
  tmpvar_15 = tmpvar_14.xy;
  tmpvar_1.xz = (tmpvar_1.xz + tmpvar_15);
  tmpvar_1.w = 1.0;
  tmpvar_3.xy = tmpvar_2.xy;
  tmpvar_3.zw = tmpvar_2.zw;
  gl_Position = (tmpvar_1 * (matWorldView * matProj));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (GridParams.SurfaceNormal.xyz * tmpvar_8);
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_5;
}

