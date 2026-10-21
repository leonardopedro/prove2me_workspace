-- Generated from ChapterG.lean — solution of BookProof.ChapterG.haarAverage_of_invariant
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (f : X → ℝ) (hf : ∀ g : G, ∀ x, f (g • x) = f x) :
    haarAverage (μG := by

  funext x
  simp only [haarAverage]
  have : (fun g : G => f (g⁻¹ • x)) = fun _ => f x := by
    funext g; rw [hf g⁻¹ x]
  rw [this, integral_const]; simp
