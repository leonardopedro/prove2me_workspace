-- Generated from PhysFunctionalAnalysis.lean — solution of PhysFunctionalAnalysis.sqrt_density_memLp
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
open PhysFunctionalAnalysis



open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (p : α → ℝ) (hp : Integrable p μ) (hp0 : 0 ≤ᵐ[μ] p) :
    MemLp (fun x => Real.sqrt (p x)) 2 μ := by

  constructor;
  · exact Real.continuous_sqrt.comp_aestronglyMeasurable hp.1;
  · rw [ MeasureTheory.eLpNorm_eq_lintegral_rpow_enorm_toReal ] <;> norm_num [ hp0 ];
    refine ENNReal.rpow_lt_top_of_nonneg ?_ ?_ <;> norm_num;
    refine ne_of_lt (lt_of_le_of_lt
      (MeasureTheory.lintegral_mono_ae (g := fun x => ENNReal.ofReal (p x)) ?_) ?_);
    · filter_upwards [ hp0 ] with x hx using by
        rw [ Real.enorm_eq_ofReal ( Real.sqrt_nonneg _ ) ]
        rw [ ← ENNReal.ofReal_pow ( Real.sqrt_nonneg _ ) ]
        rw [ Real.sq_sqrt hx ]
    · exact hp.lintegral_lt_top
