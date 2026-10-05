-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.lintegral_enorm_sq_restrict
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {F : Set X} (hF : MeasurableSet F)
    (u : Lp ℂ 2 μ) :
    ∫⁻ x in F, ‖(u : X → ℂ) x‖ₑ ^ 2 ∂μ = ENNReal.ofReal (‖proj μ hF u‖ ^ 2) := by

  have hnorm : ‖proj μ hF u‖ ^ 2 = ∫ x in F, ‖(u : X → ℂ) x‖ ^ 2 ∂μ := by
    rw [lp2_norm_sq_eq_integral μ (proj μ hF u)]
    rw [← integral_indicator hF]
    refine integral_congr_ae ?_
    filter_upwards [proj_coeFn μ hF u] with x e1
    rw [e1]
    by_cases hx : x ∈ F
    · simp [Set.indicator_of_mem hx]
    · simp [Set.indicator_of_notMem hx]
  rw [hnorm]
  have hint : Integrable (fun x => ‖(u : X → ℂ) x‖ ^ 2) (μ.restrict F) :=
    (integrable_norm_sq μ u).restrict
  rw [ofReal_integral_eq_lintegral_ofReal hint (by filter_upwards with x; positivity)]
  refine lintegral_congr fun x => ?_
  rw [← ofReal_norm_eq_enorm, ← ENNReal.ofReal_pow (norm_nonneg _)]
