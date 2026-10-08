-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.in_mem_ibd
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_apply
import Theorems.Thm_BookProof_CarlemanGeneralHop_mem_hopB
import Theorems.Thm_BookProof_CarlemanGeneralHop_mem_ibd
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} {p m : Fin d →₀ ℕ} (hm1 : ∀ k, m k ≤ 1) {b : Fin d →₀ ℕ}
    (hb : b ∈ hopB (cube d N) p m \ cube d N) : b ∈ ibd d N m := by

  classical
  rw [Finset.mem_sdiff, mem_hopB] at hb
  obtain ⟨⟨hm, hc⟩, hout⟩ := hb
  rw [mem_cube] at hc
  refine mem_ibd.mpr ⟨fun k => ?_, hm, ?_⟩
  · have h1 := hc k
    rw [hshift_apply] at h1
    have := hm k
    have := hm1 k
    omega
  · intro hall
    exact hout (mem_cube.mpr hall)
