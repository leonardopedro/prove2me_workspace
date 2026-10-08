-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.amp_eq_zero_of_not_mem_obd
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

theorem BookProof.CarlemanGeneralHop.amp_eq_zero_of_not_mem_obd {N : ℕ} {p m : Fin d →₀ ℕ} {c : (Fin d →₀ ℕ) → ℝ}
    (hvanR : ∀ a : Fin d →₀ ℕ, ¬ (∀ k, m k ≤ a k) → c a = 0) {a : Fin d →₀ ℕ}
    (ha : a ∈ cube d N \ hopB (cube d N) p m) (hne : a ∉ obd d N p m) : c a = 0 := by sorry
