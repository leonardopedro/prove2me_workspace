-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.ibd_multiplicity
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
open BookProof.CarlemanGeneralHop



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanGeneralHop.ibd_multiplicity (m : Fin d →₀ ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => b ∈ ibd d N m)).card) ≤ 1 := by sorry
