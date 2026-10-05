-- Generated from PhysFunctionalAnalysis.lean — solution of PhysFunctionalAnalysis.sqrt_density_norm
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Theorems.Thm_PhysFunctionalAnalysis_sqrt_density_memLp
open PhysFunctionalAnalysis



open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (p : α → ℝ) (hp : Integrable p μ) (hp0 : 0 ≤ᵐ[μ] p)
    (hp1 : ∫ x, p x ∂μ = 1) :
    ‖(sqrt_density_memLp μ p hp hp0).toLp _‖ = 1 := by

  rw [ Lp.norm_toLp ];
  rw [ MeasureTheory.eLpNorm_eq_lintegral_rpow_enorm_toReal ];
  · convert congr_arg ENNReal.toReal ( congr_arg ( · ^ ( 1 / 2 : ℝ ) ) ( show ( ∫⁻ x : α,
    ENNReal.ofReal ( p x ) ∂μ ) = 1 from ?_ ) ) using 1 <;> norm_num;
    · rw [ MeasureTheory.lintegral_congr_ae ];
      filter_upwards [ hp0 ] with x hx using by
        rw [ Real.enorm_eq_ofReal ( Real.sqrt_nonneg _ ) ]
        rw [ ← ENNReal.ofReal_pow ( Real.sqrt_nonneg _ ) ]
        rw [ Real.sq_sqrt hx ]
    · convert MeasureTheory.ofReal_integral_eq_lintegral_ofReal hp using 1;
      aesop;
  · norm_num;
  · norm_num
