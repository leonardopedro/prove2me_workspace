-- Generated from ChapterCarlemanGeneralHop.lean — theorem BookProof.CarlemanGeneralHop.hshift_le
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanGeneralHop
import Definitions.Def_ChapterA4
open BookProof.CarlemanGeneralHop

variable {d : ℕ}



open Finset
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanGeneralHop.hshift_le {p m a : Fin d →₀ ℕ} (h : ∀ k, m k ≤ a k) (k : Fin d) :
    p k ≤ hshift p m a k := by sorry
