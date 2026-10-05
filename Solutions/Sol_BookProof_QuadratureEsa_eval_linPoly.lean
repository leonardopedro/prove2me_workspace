-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.eval_linPoly
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin d → ℝ) (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (linPoly b) = ((linSymb b x : ℝ) : ℂ) := by

  rw [linPoly, map_sum, linSymb]
  push_cast
  simp
