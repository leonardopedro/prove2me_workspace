-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.integral_complex_eq_prod
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (G : ℂ → ℂ) :
    ∫ z : ℂ, G z = ∫ p : ℝ × ℝ, G (p.1 + p.2 * Complex.I) := by

  rw [← (Complex.volume_preserving_equiv_real_prod.symm).integral_comp
    Complex.measurableEquivRealProd.symm.measurableEmbedding G]
  refine integral_congr_ae (Eventually.of_forall fun p => ?_)
  simp only
  congr 1
  rw [Complex.measurableEquivRealProd_symm_apply]
  apply Complex.ext <;> simp
