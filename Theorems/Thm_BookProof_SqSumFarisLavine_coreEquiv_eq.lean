-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.coreEquiv_eq
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine

variable {D : ℕ} {R : Type*} [Fintype R]



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

theorem BookProof.SqSumFarisLavine.coreEquiv_eq (p : MvPolynomial (Fin D) ℂ) :
    BookProof.NavierStokesFlow.DifferentialL2.coreEquiv p
      = (⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := D)) := by sorry
