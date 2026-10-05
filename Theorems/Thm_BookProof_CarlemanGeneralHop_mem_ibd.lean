-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.mem_ibd
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanGeneralHop

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanGeneralHop.mem_ibd {N : ℕ} {m b : Fin d →₀ ℕ} :
    b ∈ ibd d N m ↔ (∀ k, b k ≤ N + 1) ∧ (∀ k, m k ≤ b k) ∧ ¬ (∀ k, b k ≤ N) := by sorry
