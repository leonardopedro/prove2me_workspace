-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.dsFibOp_commForm_le
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_hasSum_commForm
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

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable (C : ∀ i, Comparison (G i))
variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)
variable {C H}

set_option maxHeartbeats 1000000 in
theorem solution {K c : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (hcomm : ∀ (i : ι) (u : (C i).dom), |commForm (H i) (C i).op u| ≤ c * quadForm (C i).op u)
    (x : dsDom C) :
    |commForm (dsFibOp C H K hrel) (dsCompOp C) x| ≤ c * quadForm (dsCompOp C) x := by

  have hs := dsFibOp_hasSum_commForm hrel x
  have hq := (dsCompOp_hasSum_quadForm C x).mul_left c
  have hle : ∀ i, commForm (H i) (C i).op (fib C x i) ≤ c * quadForm (C i).op (fib C x i) :=
    fun i => le_trans (le_abs_self _) (hcomm i (fib C x i))
  have hge : ∀ i, -(commForm (H i) (C i).op (fib C x i)) ≤ c * quadForm (C i).op (fib C x i) :=
    fun i => le_trans (neg_le_abs _) (hcomm i (fib C x i))
  have h1 := hasSum_le hle hs hq
  have h2 := hasSum_le hge hs.neg hq
  rw [abs_le]
  constructor
  · linarith
  · exact h1
