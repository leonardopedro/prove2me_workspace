-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.sum_ltG
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
open BookProof.CarlemanGeneralHop

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanGeneralHop.sum_ltG {w : ℂ} {c c' : (Fin d →₀ ℕ) → ℝ} {p m : Fin d →₀ ℕ}
    (hcomp : ∀ b : Fin d →₀ ℕ, (∀ k, m k ≤ b k) → c' (hshift p m b) = c b)
    (hvanL : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, p k ≤ a k) → c' a = 0) (A : Finset (Fin d →₀ ℕ)) :
    ∑ a ∈ A, ltG u w c' p m a
      = (starRingEnd ℂ) (∑ b ∈ hopB A p m, rtG u w c p m b) := by sorry
