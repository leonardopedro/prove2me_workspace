-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.ibd_image_multiplicity
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


theorem BookProof.CarlemanGeneralHop.ibd_image_multiplicity (p m : Fin d →₀ ℕ) (y : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => y ∈ (ibd d N m).image (hshift p m))).card) ≤ 1 := by sorry
