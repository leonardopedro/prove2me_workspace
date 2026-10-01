-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.integral_conj_mul_symbol_sub_eq_zero
import Mathlib
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

 simp only [fourier_constCoeffOp_apply, map_mul, Complex.conj_ofReal]
  ring

theorem BookProof.StrichartzWave.integral_conj_mul_symbol_sub_eq_zero (c : ι → ℝ) (w : ι → V) (κ : ℝ) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (constCoeffOp c w κ) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRi := by sorry
