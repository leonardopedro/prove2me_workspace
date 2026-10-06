-- Generated from ChapterIPin.lean — theorem BookProof.ChapterIPin.ipin_left
import Mathlib
import Definitions.Def_ChapterIPin
open BookProof.ChapterIPin

variable {P V : Type*} [Group P] [AddCommGroup V] (Λ : P →* Multiplicative (AddAut V))



open Multiplicative


theorem BookProof.ChapterIPin.ipin_left (Λ : P →* Multiplicative (AddAut V)) (x y : IPin Λ) :
    toAdd (x * y).left = toAdd x.left + Multiplicative.toAdd (Λ x.right) (toAdd y.left) := by sorry
