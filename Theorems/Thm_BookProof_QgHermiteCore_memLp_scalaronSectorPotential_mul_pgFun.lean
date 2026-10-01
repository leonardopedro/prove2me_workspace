-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.memLp_scalaronSectorPotential_mul_pgFun
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

theorem BookProof.QgHermiteCore.memLp_scalaronSectorPotential_mul_pgFun (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ)
    (p : MvPolynomial (Fin 2) ℂ) :
    MemLp (fun x : Vd 2 => ((scalaronSectorPotential M alpha V3 x : ℝ) : ℂ) * pgFun p x) 2
      (volume : Measure (Vd 2)) := by sorry
