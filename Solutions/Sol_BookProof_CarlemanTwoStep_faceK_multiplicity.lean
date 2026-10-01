-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.faceK_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Theorems.Thm_BookProof_CarlemanTwoStep_mem_faceK
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (k : ℕ) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ faceK d N i k)).card) ≤ k := by

  classical
  have hsub : ((Finset.range M).filter (fun N => a ∈ faceK d N i k))
      ⊆ Finset.Ico (a i) (a i + k) := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_faceK] at hN
    exact Finset.mem_Ico.mpr ⟨hN.2.1 i, hN.2.2⟩
  calc (((Finset.range M).filter (fun N => a ∈ faceK d N i k)).card)
      ≤ (Finset.Ico (a i) (a i + k)).card := Finset.card_le_card hsub
    _ = k := by rw [Nat.card_Ico]; omega
