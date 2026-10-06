-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.gaussMoment_shift_eight
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

theorem BookProof.HermiteExpWall.gaussMoment_shift_eight (N : ℕ) : gaussMoment (2 * N + 8)
    = ((2 * (N:ℝ)) + 7) * ((2 * (N:ℝ)) + 5) * ((2 * (N:ℝ)) + 3) * ((2 * (N:ℝ)) + 1)
        * gaussMoment (2 * N) := by sorry
