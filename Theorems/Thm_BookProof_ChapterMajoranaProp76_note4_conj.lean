-- Generated from ChapterMajoranaProp76.lean — theorem BookProof.ChapterMajoranaProp76.note4_conj
import Mathlib
import Definitions.Def_ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76

variable {𝕜 : Type*} [RCLike 𝕜]
variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]
variable {H K : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
variable {E F : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]


open scoped InnerProductSpace


variable {𝕜 : Type*} [RCLike 𝕜]


variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]

theorem BookProof.ChapterMajoranaProp76.note4_conj (Θ : H ≃ₗᵢ[𝕜] K) {V : H → H} (hV : IsNote4Unitary 𝕜 V) :
    IsNote4Unitary 𝕜 ((Θ : H → K) ∘ V ∘ (Θ.symm : K → H)) := by sorry
