-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.integrable_exp_mul_pow_gaussW
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.integrable_exp_mul_pow_gaussW (c : ℝ) (k : ℕ) :
    Integrable (fun x : ℝ => Real.exp (c * x) * (x ^ k * gaussW x)) := by sorry
