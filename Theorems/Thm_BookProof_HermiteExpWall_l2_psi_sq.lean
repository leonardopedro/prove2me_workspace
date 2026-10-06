-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.l2_psi_sq
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteProductCore
open BookProof.GhostField
open BookProof.HermiteProductCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.l2_psi_sq (N : ℕ) : l2 (psi N) ^ 2 = gaussMoment (2 * N) := by sorry
