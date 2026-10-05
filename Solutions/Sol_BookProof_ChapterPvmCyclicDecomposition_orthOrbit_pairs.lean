-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.orthOrbit_pairs
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F) :
    ⟪P.p E ψ, P.p F φ⟫_ℂ = 0 := by

  have h1 : ⟪P.p E ψ, P.p F φ⟫_ℂ = ⟪ψ, P.p E (P.p F φ)⟫_ℂ := P.symm hE _ _
  rw [h1, P.inter hE hF]
  exact h _ (hE.inter hF)
