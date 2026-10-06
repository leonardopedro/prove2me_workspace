-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.memLp_scalaron_psi
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.GhostField
open BookProof.QgHermiteCore
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.Starobinsky
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.memLp_scalaron_psi (M alpha : ℝ) (hM : 0 < M) (N : ℕ) :
    MemLp (fun x => starobinskyV M alpha x * psi N x) 2 volume := by sorry
