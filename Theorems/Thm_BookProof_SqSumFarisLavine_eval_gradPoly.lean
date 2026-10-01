-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.eval_gradPoly
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

theorem BookProof.SqSumFarisLavine.eval_gradPoly (v : R → Fin D → ℝ) (k : Fin D) (x : Vd D) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (gradPoly v k) = ((gradFun v k x : ℝ) : ℂ) := by sorry
