-- Generated from ChapterAngularMomentum.lean — theorem BookProof.ChapterAngularMomentum.fderiv_rotationVector
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum



open Complex

theorem BookProof.ChapterAngularMomentum.fderiv_rotationVector (u : ℂ → ℂ) (z : ℂ) :
    fderiv ℝ u z (Complex.I * z)
      = z.re * fderiv ℝ u z Complex.I - z.im * fderiv ℝ u z 1 := by sorry
