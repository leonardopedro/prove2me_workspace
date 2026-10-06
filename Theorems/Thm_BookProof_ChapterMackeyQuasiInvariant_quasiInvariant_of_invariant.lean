-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.quasiInvariant_of_invariant
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyQuasiInvariant

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}


open MeasureTheory Measure



theorem BookProof.ChapterMackeyQuasiInvariant.quasiInvariant_of_invariant {μ : Measure X}
    (hm : ∀ g : G, Measurable fun x : X => g • x)
    (hinv : ∀ g : G, (μ.map fun x : X => g • x) = μ) : QuasiInvariant μ G := by sorry
