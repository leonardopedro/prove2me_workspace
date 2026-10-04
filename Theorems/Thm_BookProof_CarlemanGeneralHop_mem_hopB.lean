-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.mem_hopB
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterA4
open BookProof.CarlemanGeneralHop

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanGeneralHop.mem_hopB {A : Finset (Fin d →₀ ℕ)} {p m b : Fin d →₀ ℕ} :
    b ∈ hopB A p m ↔ (∀ k, m k ≤ b k) ∧ hshift p m b ∈ A := by sorry
