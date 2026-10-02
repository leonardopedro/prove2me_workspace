-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.momPoly_eq_lop
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) :
    momPoly (d := d) i = (Complex.I / 2) • lop (-1) i := by

  refine LinearMap.ext fun p => ?_
  rw [momPoly_eq_cre_sub_ann]
  simp only [lop, LinearMap.smul_apply, LinearMap.add_apply, neg_smul, one_smul,
    LinearMap.neg_apply]
  rw [sub_eq_add_neg]
