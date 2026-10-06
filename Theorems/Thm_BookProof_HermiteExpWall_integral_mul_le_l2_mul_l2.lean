-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.integral_mul_le_l2_mul_l2
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.integral_mul_le_l2_mul_l2 (f g : ℝ → ℝ) (hf : MemLp f 2 volume)
    (hg : MemLp g 2 volume) : ∫ x, ‖f x‖ * ‖g x‖ ≤ l2 f * l2 g := by sorry
