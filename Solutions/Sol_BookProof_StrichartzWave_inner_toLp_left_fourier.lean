-- Generated from ChapterStrichartzWave.lean — solution of BookProof.StrichartzWave.inner_toLp_left_fourier
import Mathlib
import Definitions.Def_ChapterStrichartzWave
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
tegral_congr_ae ?_
  filter_upwards [(𝓕 g : 𝓢(V, ℂ)).coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]

theorem solution (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) :=
  u : ℂ)
        = ∫ x, (starRingEnd ℂ) ((𝓕 f : 𝓢(V, ℂ)) x) * ((𝓕 u : Lp ℂ 2 (volume : Measure V)) x) := by
    rw [← M
