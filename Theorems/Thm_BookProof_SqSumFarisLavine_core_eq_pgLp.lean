-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.core_eq_pgLp
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

theorem BookProof.SqSumFarisLavine.core_eq_pgLp (u : polyGaussCore (d := D)) :
    ∃ p : MvPolynomial (Fin D) ℂ, u = ⟨pgLp p, pgLp_mem_core p⟩ := by sorry
