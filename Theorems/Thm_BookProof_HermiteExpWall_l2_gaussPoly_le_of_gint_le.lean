-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.l2_gaussPoly_le_of_gint_le
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
open BookProof.GhostField
open BookProof.HermiteCore
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.l2_gaussPoly_le_of_gint_le {q : Polynomial ℝ} {K : ℝ} (hK : 0 ≤ K) (N : ℕ)
    (h : gint (q * q) ≤ K ^ 2 * gaussMoment (2 * N)) :
    l2 (gaussPoly q) ≤ K * l2 (psi N) := by sorry
