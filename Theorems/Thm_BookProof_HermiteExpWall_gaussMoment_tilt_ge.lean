-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.gaussMoment_tilt_ge
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteCore
open BookProof.HermiteProductCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.gaussMoment_tilt_ge (s : ℝ) (N : ℕ) :
    (s ^ 8 / 315) * gaussMoment (2 * N + 8)
      ≤ ∫ x : ℝ, Real.exp (-(2 * s) * x) * (x ^ (2 * N) * gaussW x) := by sorry
