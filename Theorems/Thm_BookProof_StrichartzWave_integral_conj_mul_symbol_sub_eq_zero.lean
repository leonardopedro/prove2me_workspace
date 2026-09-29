-- Generated from ChapterStrichartzWave.lean — theorem BookProof.StrichartzWave.integral_conj_mul_symbol_sub_eq_zero
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.StrichartzWave










open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

theorem BookProof.StrichartzWave.integral_conj_mul_symbol_sub_eq_zero (c : ι → ℝ) (w : ι → V) (κ : ℝ) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (constCoeffOp c w κ) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((symbolFn c w κ x : ℝ) : ℂ) - z) *
      ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) = 0 := by sorry
