-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.mem_hopB
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_hshift
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_le
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Finset (Fin d →₀ ℕ)} {p m b : Fin d →₀ ℕ} :
    b ∈ hopB A p m ↔ (∀ k, m k ≤ b k) ∧ hshift p m b ∈ A := by

  classical
  constructor
  · intro hb
    rw [hopB, Finset.mem_image] at hb
    obtain ⟨a, ha, rfl⟩ := hb
    rw [Finset.mem_filter] at ha
    refine ⟨fun k => hshift_le ha.2 k, ?_⟩
    rw [hshift_hshift ha.2]
    exact ha.1
  · rintro ⟨hm, hA⟩
    rw [hopB, Finset.mem_image]
    refine ⟨hshift p m b, ?_, ?_⟩
    · rw [Finset.mem_filter]
      exact ⟨hA, fun k => hshift_le hm k⟩
    · rw [hshift_hshift hm]
