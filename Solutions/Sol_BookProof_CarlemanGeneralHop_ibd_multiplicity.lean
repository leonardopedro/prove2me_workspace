-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.ibd_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_mem_ibd
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin d →₀ ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => b ∈ ibd d N m)).card) ≤ 1 := by

  classical
  set S := Finset.univ.sup (fun k : Fin d => b k) with hS
  have hsub : ((Finset.range M).filter (fun N => b ∈ ibd d N m)) ⊆ Finset.Ico (S - 1) S := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_ibd] at hN
    obtain ⟨hle, -, hnot⟩ := hN.2
    push_neg at hnot
    obtain ⟨k, hk⟩ := hnot
    have h1 : S ≤ N + 1 := Finset.sup_le fun j _ => hle j
    have h2 : b k ≤ S := Finset.le_sup (f := fun k : Fin d => b k) (Finset.mem_univ k)
    exact Finset.mem_Ico.mpr ⟨by omega, by omega⟩
  calc (((Finset.range M).filter (fun N => b ∈ ibd d N m)).card)
      ≤ (Finset.Ico (S - 1) S).card := Finset.card_le_card hsub
    _ = S - (S - 1) := Nat.card_Ico _ _
    _ ≤ 1 := by omega
