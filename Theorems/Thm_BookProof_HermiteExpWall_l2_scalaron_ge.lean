-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.l2_scalaron_ge
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterQgHermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.GhostField
open BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.l2_scalaron_ge (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) (N : ℕ) :
    (M ^ 4 / (16 * alpha)) *
        ((8 * (Real.sqrt (2 / 3) / M) ^ 8 / 315) * (N : ℝ) ^ 4 - 1) * l2 (psi N)
      ≤ l2 (fun x => starobinskyV M alpha x * psi N x) := by sorry
