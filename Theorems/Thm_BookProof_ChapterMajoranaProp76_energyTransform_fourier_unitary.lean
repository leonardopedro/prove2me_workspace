-- Generated from ChapterMajoranaProp76.lean — theorem BookProof.ChapterMajoranaProp76.energyTransform_fourier_unitary
import Mathlib
import Definitions.Def_ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76


open scoped InnerProductSpace


variable {𝕜 : Type*} [RCLike 𝕜]


variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]

theorem BookProof.ChapterMajoranaProp76.energyTransform_fourier_unitary {K : Type*} [NormedAddCommGroup K]
    [InnerProductSpace ℂ K] (Θ : Lp F 2 volume ≃ₗᵢ[ℂ] K) :
    IsNote4Unitary ℂ (energyTransform Θ (Lp.fourierTransformₗᵢ E F)) := by sorry
