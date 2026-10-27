-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.ibd_image_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_hshift
import Theorems.Thm_BookProof_CarlemanGeneralHop_mem_ibd
import Theorems.Thm_BookProof_CarlemanGeneralHop_ibd_multiplicity
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (p m : Fin d →₀ ℕ) (y : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => y ∈ (ibd d N m).image (hshift p m))).card) ≤ 1 := by

  classical
  refine le_trans (Finset.card_le_card ?_) (ibd_multiplicity m (hshift m p y) M)
  intro N hN
  simp only [Finset.mem_filter, Finset.mem_image] at hN ⊢
  obtain ⟨hNr, b, hb, hby⟩ := hN
  have hbi := hb
  rw [mem_ibd] at hbi
  have hyb : hshift m p y = b := by rw [← hby, hshift_hshift hbi.2.1]
  exact ⟨hNr, by rw [hyb]; exact hb⟩
