-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.expBounded_pow
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.expBounded_pow (k : ℕ) : ExpBounded (fun x : ℝ => x ^ k) := by sorry
