-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.dsFibOp_hasSum_commForm
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_fib
open BookProof.QgOuterFockFL



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (x : dsDom C) :
    HasSum (fun i => commForm (H i) (C i).op (fib C x i))
      (commForm (dsFibOp C H K hrel) (dsCompOp C) x) := by

  set Hx := dsFibOp C H K hrel x with hHx
  set Nx := dsCompOp C x with hNx
  have h1 : HasSum (fun i => (inner ℂ ((Hx : lp G 2) i) ((Nx : lp G 2) i) : ℂ))
      (inner ℂ (Hx : lp G 2) (Nx : lp G 2)) := lp.hasSum_inner _ _
  have h2 : HasSum (fun i => (inner ℂ ((Nx : lp G 2) i) ((Hx : lp G 2) i) : ℂ))
      (inner ℂ (Nx : lp G 2) (Hx : lp G 2)) := lp.hasSum_inner _ _
  have h3 := (h1.sub h2).mul_left Complex.I
  have h4 := Complex.reCLM.hasSum h3
  have hfun : (fun i => Complex.reCLM (Complex.I *
        ((inner ℂ ((Hx : lp G 2) i) ((Nx : lp G 2) i) : ℂ)
          - (inner ℂ ((Nx : lp G 2) i) ((Hx : lp G 2) i) : ℂ))))
      = fun i => commForm (H i) (C i).op (fib C x i) := by
    funext i
    rw [Complex.reCLM_apply, commForm, hHx, hNx, dsFibOp_fib, dsCompOp_fib]
  rw [hfun] at h4
  exact h4
