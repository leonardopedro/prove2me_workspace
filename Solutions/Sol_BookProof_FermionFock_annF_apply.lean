-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.annF_apply
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_erase
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) (S : FConf) :
    annF j u S = if j ∈ S then 0 else fsign j S * u (insert j S) := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
    simp only [map_add, Finsupp.add_apply, hf, hg]
    by_cases h : j ∈ S <;> simp [h, mul_add]
  | single T c =>
    rw [annF_single]
    by_cases hT : j ∈ T
    · by_cases hS : j ∈ S
      · rw [if_pos hT, if_pos hS, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul]
        have : T.erase j ≠ S := fun hc => (Finset.notMem_erase j T) (hc ▸ hS)
        rw [if_neg this, mul_zero]
      · rw [if_pos hT, if_neg hS, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul,
          Finsupp.single_apply]
        by_cases hTS : T.erase j = S
        · subst hTS
          rw [if_pos rfl, if_pos (Finset.insert_erase hT).symm, fsign_erase]
          ring
        · rw [if_neg hTS, mul_zero]
          have : T ≠ insert j S := by
            intro hc
            exact hTS (by rw [hc, Finset.erase_insert (by simpa using hS)])
          rw [if_neg this, mul_zero]
    · rw [if_neg hT, smul_zero, Finsupp.zero_apply]
      by_cases hS : j ∈ S
      · rw [if_pos hS]
      · rw [if_neg hS, Finsupp.single_apply]
        have : T ≠ insert j S := fun hc => hT (hc ▸ Finset.mem_insert_self j S)
        rw [if_neg this, mul_zero]
