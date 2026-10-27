-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.commForm_witness_eq_neg_two
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_testState_mem_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_testState_coe_zero
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_testState_coe_one
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    commForm (pertHam linSymbol (eState 0) (eState 1)) (diagMax linSymbol)
      ⟨testState, testState_mem_maxDom⟩ = -2 := by

  classical
  set x : maxDom linSymbol := ⟨testState, testState_mem_maxDom⟩ with hx
  have hxu : (inner ℂ (eState 0) ((x : L2I ℕ)) : ℂ) = 1 := by
    rw [hx]
    simp only [eState]
    rw [lp.inner_single_left]
    simp [testState_coe_zero]
  have hxw : (inner ℂ (eState 1) ((x : L2I ℕ)) : ℂ) = Complex.I := by
    rw [hx]
    simp only [eState]
    rw [lp.inner_single_left]
    simp [testState_coe_one]
  have hNu : (inner ℂ (eState 0) (diagMax linSymbol x) : ℂ) = 1 := by
    simp only [eState]
    rw [lp.inner_single_left]
    simp only [RCLike.inner_apply, map_one]
    rw [diagMax_coe]
    simp [hx, testState_coe_zero, linSymbol]
  have hNw : (inner ℂ (eState 1) (diagMax linSymbol x) : ℂ) = 2 * Complex.I := by
    simp only [eState]
    rw [lp.inner_single_left]
    simp only [RCLike.inner_apply, map_one]
    rw [diagMax_coe]
    simp [hx, testState_coe_one, linSymbol]
    ring
  have hdiag : (inner ℂ (diagMax linSymbol x) (diagMax linSymbol x) : ℂ).im = 0 := by
    simpa using inner_self_im (𝕜 := ℂ) ((diagMax linSymbol x))
  have hexp : (inner ℂ (pertHam linSymbol (eState 0) (eState 1) x)
      (diagMax linSymbol x) : ℂ) = (inner ℂ (diagMax linSymbol x) (diagMax linSymbol x) : ℂ)
        + ((starRingEnd ℂ) (inner ℂ (eState 0) ((x : L2I ℕ)) : ℂ)
            * inner ℂ (eState 1) (diagMax linSymbol x)
          + (starRingEnd ℂ) (inner ℂ (eState 1) ((x : L2I ℕ)) : ℂ)
            * inner ℂ (eState 0) (diagMax linSymbol x)) := by
    rw [pertHam_apply, inner_add_left]
    congr 1
    simp only [rankTwo_apply, inner_add_left, inner_smul_left]
  rw [commForm_eq, hexp, Complex.add_im, hdiag, zero_add, hxu, hxw, hNu, hNw]
  simp
  norm_num
