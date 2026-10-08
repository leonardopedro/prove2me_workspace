-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.mem_obd
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

theorem BookProof.CarlemanGeneralHop.mem_obd {N : ℕ} {p m a : Fin d →₀ ℕ} :
    a ∈ obd d N p m ↔ (∀ k, a k ≤ N) ∧ (∀ k, m k ≤ a k) ∧ ∃ k, N < a k + p k := by sorry
