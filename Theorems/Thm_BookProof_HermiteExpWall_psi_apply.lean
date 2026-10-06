-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.psi_apply
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteFunctions
open BookProof.GhostField
open BookProof.HermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.psi_apply (N : ℕ) (x : ℝ) : psi N x = x ^ N * gaussH x := by sorry
