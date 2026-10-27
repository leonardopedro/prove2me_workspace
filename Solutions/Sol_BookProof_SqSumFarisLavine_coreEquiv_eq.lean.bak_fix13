-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.coreEquiv_eq
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
open BookProof.SqSumFarisLavine




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    BookProof.NavierStokesFlow.DifferentialL2.coreEquiv p
      = (⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := D)) := Subtype.ext (BookProof.NavierStokesFlow.DifferentialL2.coreEquiv_coe p)
