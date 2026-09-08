-- Generated from ChapterMajoranaProp76.lean — theorem BookProof.ChapterMajoranaProp76.energyMomentum_unitary
import Mathlib
import Definitions.Def_ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76










open scoped InnerProductSpace


variable {𝕜 : Type*} [RCLike 𝕜]


variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]






variable {H K : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]

theorem BookProof.ChapterMajoranaProp76.energyMomentum_unitary (Θ : H ≃ₗᵢ[𝕜] K) {V : H → H} {FM : K → K}
    (hV : IsNote4Unitary 𝕜 V) (hFM : IsNote4Unitary 𝕜 FM) :
    IsNote4Unitary 𝕜 (energyTransform Θ V ∘ FM) := by sorry
