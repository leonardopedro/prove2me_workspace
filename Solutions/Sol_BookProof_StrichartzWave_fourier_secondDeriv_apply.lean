-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.fourier_secondDeriv_apply
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave











open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (f : 𝓢(V, ℂ)) (m : V) (x : V) :
    (𝓕 (secondDeriv m f) : 𝓢(V, ℂ)) x
      = ((-4 * Real.pi ^ 2 * (inner ℝ x m) ^ 2 : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by

  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  change (𝓕 (∂_{m} (∂_{m} f) : 𝓢(V, ℂ)) : 𝓢(V, ℂ)) x = _
  rw [fourier_lineDerivOp_eq, fourier_lineDerivOp_eq]
  simp only [h, smulLeftCLM_apply, SchwartzMap.smul_apply, smul_eq_mul, Complex.real_smul,
    Complex.ofReal_mul, Complex.ofReal_neg, Complex.ofReal_pow, Complex.ofReal_ofNat]
  rw [show ((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) *
      (((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x))) =
      (Complex.I ^ 2) * (4 * (Real.pi : ℂ) ^ 2 * ((inner ℝ x m : ℝ) : ℂ) ^ 2 *
        (𝓕 f : 𝓢(V, ℂ)) x) by ring, Complex.I_sq]
  ring
