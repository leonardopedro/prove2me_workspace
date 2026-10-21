-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.creF_apply
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_insert_self
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) (S : FConf) :
    creF j u S = if j ∈ S then fsign j S * u (S.erase j) else 0 := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
    simp only [map_add, Finsupp.add_apply, hf, hg]
    by_cases h : j ∈ S <;> simp [h, mul_add]
  | single T c =>
    rw [creF_single]
    by_cases hT : j ∈ T
    · have hne : ∀ hS : j ∈ S, T ≠ S.erase j := by
        intro _ hc
        exact (Finset.notMem_erase j S) (hc ▸ hT)
      simp only [hT, if_true, smul_zero, Finsupp.zero_apply]
      by_cases hS : j ∈ S
      · rw [if_pos hS, Finsupp.single_apply, if_neg (hne hS), mul_zero]
      · rw [if_neg hS]
    · have hins : j ∈ insert j T := Finset.mem_insert_self j T
      by_cases hS : j ∈ S
      · rw [if_neg hT, if_pos hS, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul]
        by_cases hTS : insert j T = S
        · subst hTS
          rw [if_pos rfl, Finsupp.single_apply,
            if_pos (Finset.erase_insert (by simpa using hT)).symm,
            fsign_insert_self]
          ring
        · rw [if_neg hTS, mul_zero, Finsupp.single_apply]
          have : T ≠ S.erase j := by
            intro hc
            exact hTS (by rw [hc, Finset.insert_erase hS])
          rw [if_neg this, mul_zero]
      · rw [if_neg hT, if_neg hS, Finsupp.smul_apply, Finsupp.single_apply, smul_eq_mul]
        have : insert j T ≠ S := fun hc => hS (hc ▸ hins)
        rw [if_neg this, mul_zero]
