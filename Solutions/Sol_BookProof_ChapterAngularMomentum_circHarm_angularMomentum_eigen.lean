-- Generated from ChapterAngularMomentum.lean — solution of BookProof.ChapterAngularMomentum.circHarm_angularMomentum_eigen
import Mathlib
import Definitions.Def_ChapterAngularMomentum
import Theorems.Thm_BookProof_ChapterAngularMomentum_angularMomentum_eigen
import Theorems.Thm_BookProof_ChapterAngularMomentum_circHarm_rotate
import Theorems.Thm_BookProof_ChapterAngularMomentum_circHarm_differentiableAt
open BookProof.ChapterAngularMomentum




open Complex

set_option maxHeartbeats 1000000 in
theorem solution (μ : ℕ) {z : ℂ} (hz : z ≠ 0) :
    -Complex.I * (z.re * fderiv ℝ (circHarm μ) z Complex.I
        - z.im * fderiv ℝ (circHarm μ) z 1)
      = (μ : ℂ) * circHarm μ z :=
  angularMomentum_eigen (μ := (μ : ℝ)) (circHarm_differentiableAt hz)
      (by intro t; simpa using circHarm_rotate μ t z)
