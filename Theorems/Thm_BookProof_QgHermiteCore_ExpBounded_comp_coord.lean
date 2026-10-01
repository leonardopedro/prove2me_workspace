-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.ExpBounded.comp_coord
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.ExpBounded.comp_coord {f : ℝ → ℝ} (hf : ExpBounded f) (i : Fin d) :
    ExpBounded (fun x : Vd d => f (x i)) := by sorry
