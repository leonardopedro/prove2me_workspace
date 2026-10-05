-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.obd_multiplicity
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


theorem BookProof.CarlemanGeneralHop.obd_multiplicity (p m : Fin d →₀ ℕ) (hp : ∀ k, p k ≤ 2) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ obd d N p m)).card) ≤ 2 := by sorry
