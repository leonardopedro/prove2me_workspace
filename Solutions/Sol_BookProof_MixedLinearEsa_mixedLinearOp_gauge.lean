-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.mixedLinearOp_gauge
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_momentumOp_apply
import Theorems.Thm_BookProof_MixedLinearEsa_mixedLinearOp_apply
import Theorems.Thm_BookProof_MixedLinearEsa_hasDerivAt_gaugeFun_line
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (b m : V) (hm : m ≠ 0) (φ : 𝓢(V, ℂ))
    (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (mixedLinearOp b m (gaugeSchwartz b m φ hφ)) x
      = gaugeFun b m x * (momentumOp m φ x) := by

  have hφd : HasDerivAt (fun t : ℝ => φ (x + t • m)) (fderiv ℝ (φ : V → ℂ) x m) 0 :=
    (φ.differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hνd := hasDerivAt_gaugeFun_line b m hm x
  have hprod : HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m) * φ (x + t • m))
      ((gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) * φ x
        + gaugeFun b m x * fderiv ℝ (φ : V → ℂ) x m) 0 := by
    have h := hνd.mul hφd
    simp only [zero_smul, add_zero] at h
    exact h
  have hgd : HasDerivAt (fun t : ℝ => (gaugeSchwartz b m φ hφ) (x + t • m))
      (fderiv ℝ ((gaugeSchwartz b m φ hφ) : V → ℂ) x m) 0 :=
    ((gaugeSchwartz b m φ hφ).differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hval := hgd.unique hprod
  rw [mixedLinearOp_apply, hval, momentumOp_apply, gaugeSchwartz_apply]
  push_cast
  linear_combination ((inner ℝ x b : ℝ) : ℂ) * gaugeFun b m x * φ x * Complex.I_mul_I
