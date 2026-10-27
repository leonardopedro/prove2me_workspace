-- Generated from ChapterG.lean — solution of BookProof.ChapterG.haarAverage_smul
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution [MeasurableMul G]
    (f : X → ℝ) (g₀ : G) (x : X) :
    haarAverage (μG := by

  simp only [haarAverage]
  have key : (fun g : G => f (g⁻¹ • (g₀ • x)))
      = fun g : G => (fun h => f (h⁻¹ • x)) (g₀⁻¹ * g) := by
    funext g
    simp only [smul_smul, mul_inv_rev, inv_inv]
  rw [key]
  exact integral_mul_left_eq_self (fun h => f (h⁻¹ • x)) g₀⁻¹
