-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.shiftedK_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Theorems.Thm_BookProof_CarlemanTwoStep_mem_faceK
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (k : ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k))).card) ≤ k := by

  classical
  have hsub : ((Finset.range M).filter
        (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k)))
      ⊆ Finset.Ico (b i - k) (b i) := by
    intro N hN
    simp only [Finset.mem_filter, Finset.mem_image] at hN
    obtain ⟨a, ha, hab⟩ := hN.2
    rw [mem_faceK] at ha
    have hbi : b i = a i + k := by
      rw [← hab]; simp
    refine Finset.mem_Ico.mpr ⟨?_, ?_⟩
    · have := ha.1 i; omega
    · have := ha.2; omega
  calc (((Finset.range M).filter
        (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k))).card)
      ≤ (Finset.Ico (b i - k) (b i)).card := Finset.card_le_card hsub
    _ ≤ k := by rw [Nat.card_Ico]; omega
