-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.in_mem_ibd
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanGeneralHop



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanGeneralHop.in_mem_ibd {N : ℕ} {p m : Fin d →₀ ℕ} (hm1 : ∀ k, m k ≤ 1) {b : Fin d →₀ ℕ}
    (hb : b ∈ hopB (cube d N) p m \ cube d N) : b ∈ ibd d N m := by sorry
