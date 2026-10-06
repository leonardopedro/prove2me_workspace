-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.fourier_vecMomentumOp_apply
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier




open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable (V F) in
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution (m : V) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (vecMomentumOp m f) : 𝓢(V, F)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) • (𝓕 f : 𝓢(V, F)) x := by

  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  have hlin : (𝓕 (vecMomentumOp m f) : 𝓢(V, F))
      = (-Complex.I) • (𝓕 (∂_{m} f : 𝓢(V, F)) : 𝓢(V, F)) := by
    change fourierTransformCLM ℂ (vecMomentumOp m f) = _
    simp [vecMomentumOp]
  rw [hlin]
  simp only [SchwartzMap.smul_apply, fourier_lineDerivOp_eq, h, smulLeftCLM_apply,
    Complex.ofReal_mul, Complex.ofReal_ofNat, smul_smul]
  rw [← Complex.coe_smul, smul_smul]
  congr 1
  rw [show (-Complex.I * (2 * (Real.pi : ℂ) * Complex.I)) * ((inner ℝ x m : ℝ) : ℂ)
      = (-(Complex.I * Complex.I)) * (2 * (Real.pi : ℂ) * ((inner ℝ x m : ℝ) : ℂ)) by ring,
    show Complex.I * Complex.I = -1 from Complex.I_mul_I]
  ring
