-- Generated from ChapterMajoranaProp76.lean — theorem BookProof.ChapterMajoranaProp76.note4_comp
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

theorem BookProof.ChapterMajoranaProp76.note4_comp {f : H → K} {g : K → L}
    (hf : IsNote4Unitary 𝕜 f) (hg : IsNote4Unitary 𝕜 g) :
    IsNote4Unitary 𝕜 (g ∘ f) := by sorry
