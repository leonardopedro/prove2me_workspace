-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.ExpBounded.const_mul
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.ExpBounded.const_mul {f : E → ℝ} (hf : ExpBounded f) (a : ℝ) :
    ExpBounded (fun x => a * f x) := by sorry
