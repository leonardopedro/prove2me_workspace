-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.ExpBounded.mul
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteCore.ExpBounded

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.ExpBounded.mul {f g : E → ℝ} (hf : ExpBounded f) (hg : ExpBounded g) :
    ExpBounded (fun x => f x * g x) := by sorry
