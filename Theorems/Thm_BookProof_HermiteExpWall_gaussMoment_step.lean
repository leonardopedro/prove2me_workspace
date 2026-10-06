-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.gaussMoment_step
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteExpWall



open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

theorem BookProof.HermiteExpWall.gaussMoment_step (k : ℕ) : gaussMoment (k + 2) = ((k : ℝ) + 1) * gaussMoment k := by sorry
