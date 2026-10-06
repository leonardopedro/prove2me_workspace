-- Generated from ChapterAngularMomentum.lean — theorem BookProof.ChapterAngularMomentum.circHarm_angularMomentum_eigen
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum



open Complex

theorem BookProof.ChapterAngularMomentum.circHarm_angularMomentum_eigen (μ : ℕ) {z : ℂ} (hz : z ≠ 0) :
    -Complex.I * (z.re * fderiv ℝ (circHarm μ) z Complex.I
        - z.im * fderiv ℝ (circHarm μ) z 1)
      = (μ : ℂ) * circHarm μ z := by sorry
