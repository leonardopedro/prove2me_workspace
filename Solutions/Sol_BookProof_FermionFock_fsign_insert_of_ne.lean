-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.fsign_insert_of_ne
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (S : FConf) (hkS : k ∉ S) (hkj : k ≠ j) :
    fsign j (insert k S) = (if k < j then (-1 : ℂ) else 1) * fsign j S := by

  classical
  by_cases hlt : k < j
  · have hfil : (insert k S).filter (fun i => i < j)
        = insert k (S.filter (fun i => i < j)) := by
      ext i
      simp only [Finset.mem_filter, Finset.mem_insert]
      constructor
      · rintro ⟨hi | hi, h2⟩
        · exact Or.inl hi
        · exact Or.inr ⟨hi, h2⟩
      · rintro (rfl | ⟨hi, h2⟩)
        · exact ⟨Or.inl rfl, hlt⟩
        · exact ⟨Or.inr hi, h2⟩
    have hnot : k ∉ S.filter (fun i => i < j) := fun h => hkS (Finset.mem_filter.mp h).1
    rw [fsign, fsign, hfil, Finset.card_insert_of_notMem hnot, pow_succ, if_pos hlt]
    ring
  · have hfil : (insert k S).filter (fun i => i < j) = S.filter (fun i => i < j) := by
      ext i
      simp only [Finset.mem_filter, Finset.mem_insert]
      constructor
      · rintro ⟨hi | hi, h2⟩
        · exact absurd (hi ▸ h2) hlt
        · exact ⟨hi, h2⟩
      · rintro ⟨hi, h2⟩; exact ⟨Or.inr hi, h2⟩
    rw [fsign, fsign, hfil, if_neg hlt, one_mul]
