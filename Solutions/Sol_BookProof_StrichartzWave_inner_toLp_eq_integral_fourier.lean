-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.inner_toLp_eq_integral_fourier
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
?_
  filter_upwards [f.coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]
  simp [RCLike.inner_apply, mul_comm]

theorem solution (f g : 𝓢(V, ℂ)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) (g.toLp 2 (vo :=
  lume : Measure V)) : ℂ)
        = ∫ x, (starRingEnd ℂ) ((𝓕 f : 𝓢(V, ℂ)) x) * ((𝓕 g : 𝓢(V, ℂ)) x) := by
    rw [← MeasureTheory.Lp.inner_fourier_eq (f.toLp 2 (volume : Measure V))
        (g.toLp 2 (volume : Measure V)), SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
      inner_toLp_left]
    refine
