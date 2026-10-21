-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.potMomOp_gauge
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_momentumOp_apply
import Theorems.Thm_BookProof_MixedLinearEsa_potMomOp_apply
import Theorems.Thm_BookProof_MixedLinearEsa_hasDerivAt_phaseFun_line
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W) {m : V}
    (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0)
    (φ : 𝓢(V, ℂ)) (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (potMomOp W m (phaseSchwartz hθ φ hφ)) x = phaseFun θ x * (momentumOp m φ x) := by

  have hφd : HasDerivAt (fun t : ℝ => φ (x + t • m)) (fderiv ℝ (φ : V → ℂ) x m) 0 :=
    (φ.differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hνd := hasDerivAt_phaseFun_line hθd x
  have hprod : HasDerivAt (fun t : ℝ => phaseFun θ (x + t • m) * φ (x + t • m))
      ((phaseFun θ x * (Complex.I * ((-(W x) : ℝ) : ℂ))) * φ x
        + phaseFun θ x * fderiv ℝ (φ : V → ℂ) x m) 0 := by
    have h := hνd.mul hφd
    simp only [zero_smul, add_zero] at h
    exact h
  have hgd : HasDerivAt (fun t : ℝ => (phaseSchwartz hθ φ hφ) (x + t • m))
      (fderiv ℝ ((phaseSchwartz hθ φ hφ) : V → ℂ) x m) 0 :=
    ((phaseSchwartz hθ φ hφ).differentiableAt).hasFDerivAt.hasLineDerivAt m
  have hval := hgd.unique hprod
  rw [potMomOp_apply hW, hval, momentumOp_apply, phaseSchwartz_apply]
  push_cast
  linear_combination ((W x : ℝ) : ℂ) * phaseFun θ x * φ x * Complex.I_mul_I
