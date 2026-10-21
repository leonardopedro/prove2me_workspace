-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.diagMax_eState
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_eState_mem_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    (diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
      = ((linSymbol k : ℂ)) • eState k := by

  classical
  refine lp.ext (funext fun j => ?_)
  rw [diagMax_coe]
  simp only [eState, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, lp.single_apply, Pi.single_apply]
  by_cases hjk : j = k
  · subst hjk; simp
  · simp [hjk]
