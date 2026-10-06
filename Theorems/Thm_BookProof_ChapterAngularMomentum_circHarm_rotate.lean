-- Generated from ChapterAngularMomentum.lean — theorem BookProof.ChapterAngularMomentum.circHarm_rotate
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum



open Complex

theorem BookProof.ChapterAngularMomentum.circHarm_rotate (μ : ℕ) (t : ℝ) (z : ℂ) :
    circHarm μ (Complex.exp ((t : ℂ) * Complex.I) * z)
      = Complex.exp ((μ : ℂ) * (t : ℂ) * Complex.I) * circHarm μ z := by sorry
