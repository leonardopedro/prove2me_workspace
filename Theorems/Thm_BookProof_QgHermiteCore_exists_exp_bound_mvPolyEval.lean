-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.exists_exp_bound_mvPolyEval
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

theorem BookProof.QgHermiteCore.exists_exp_bound_mvPolyEval (p : MvPolynomial (Fin d) ℂ) :
    ∃ C c : ℝ, 0 ≤ C ∧ 0 ≤ c ∧ ∀ x : Vd d,
      ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ ≤ C * Real.exp (c * ‖x‖) := by sorry
