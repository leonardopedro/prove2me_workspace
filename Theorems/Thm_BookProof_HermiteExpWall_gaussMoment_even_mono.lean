-- Generated from ChapterHermiteExpWall.lean — theorem BookProof.HermiteExpWall.gaussMoment_even_mono
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

theorem BookProof.HermiteExpWall.gaussMoment_even_mono {m n : ℕ} (h : m ≤ n) :
    gaussMoment (2 * m) ≤ gaussMoment (2 * n) := by sorry
