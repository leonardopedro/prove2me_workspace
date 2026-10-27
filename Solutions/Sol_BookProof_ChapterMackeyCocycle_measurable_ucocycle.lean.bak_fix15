-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.measurable_ucocycle
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_measurable_wrep
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) :
    Measurable (ucocycle V g) := by

  refine Measurable.ite ?_ measurable_const
    ((measurable_wrep V g).div (Complex.measurable_ofReal.comp (measurable_wrep V g).norm))
  exact measurableSet_eq_fun (measurable_wrep V g) measurable_const
