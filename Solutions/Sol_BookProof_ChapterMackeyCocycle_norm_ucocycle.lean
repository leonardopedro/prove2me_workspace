-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.norm_ucocycle
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) (x : X) :
    ‖ucocycle V g x‖ = 1 := by

  rw [ucocycle]
  split_ifs with h
  · simp
  · rw [norm_div, Complex.norm_real, norm_norm, div_self]
    simpa using h
