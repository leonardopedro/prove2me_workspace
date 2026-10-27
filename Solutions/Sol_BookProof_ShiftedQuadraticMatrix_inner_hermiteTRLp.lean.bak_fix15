-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.inner_hermiteTRLp
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_QuadraticRotation_inner_pgLp_rotPoly
open BookProof.ShiftedQuadraticMatrix




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (a k : Vd d)
    (α β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteTRLp O a k α) (hermiteTRLp O a k β) : ℂ)
      = (inner ℂ (hermiteMvLp (d := d) α) (hermiteMvLp (d := d) β) : ℂ) := by

  rw [hermiteTRLp, hermiteTRLp, hermiteMvLp, hermiteMvLp, inner_smul_left, inner_smul_right,
    inner_smul_left, inner_smul_right, inner_pgLpT, inner_pgLp_rotPoly hO]
