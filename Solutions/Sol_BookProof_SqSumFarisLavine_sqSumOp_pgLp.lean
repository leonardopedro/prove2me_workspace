-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.sqSumOp_pgLp
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_SqSumFarisLavine_coreEquiv_eq
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) (p : MvPolynomial (Fin D) ℂ) :
    sqSumOp kappa v ⟨pgLp p, pgLp_mem_core p⟩ = pgLp (sqSumPoly kappa v p) := by

  rw [← coreEquiv_eq, sqSumOp]
  simp only [LinearMap.comp_apply, BookProof.NavierStokesFlow.DifferentialL2.coreOp_coreEquiv,
    Submodule.subtype_apply]
  rw [BookProof.NavierStokesFlow.DifferentialL2.coreEquiv_coe]
