-- Generated from ChapterCarlemanGeneralHop.lean — solution of BookProof.CarlemanGeneralHop.hshift_hshift
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Theorems.Thm_BookProof_CarlemanGeneralHop_hshift_apply
open BookProof.CarlemanGeneralHop




open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p m a : Fin d →₀ ℕ} (h : ∀ k, m k ≤ a k) :
    hshift m p (hshift p m a) = a := by

  ext k
  rw [hshift_apply, hshift_apply]
  have := h k
  omega
