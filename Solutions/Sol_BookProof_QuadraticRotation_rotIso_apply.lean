-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotIso_apply
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
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (x : Vd d) :
    (rotIso hO x : Vd d) = rotLin O x := rfl
