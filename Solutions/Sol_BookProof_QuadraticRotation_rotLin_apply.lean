-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotLin_apply
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (O : Matrix (Fin d) (Fin d) ℝ) (x : Vd d) (i : Fin d) :
    rotLin O x i = ∑ j, O j i * x j := rfl
