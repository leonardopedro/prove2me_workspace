-- Generated from ChapterIPin.lean — theorem BookProof.ChapterIPin.ipin_right
import Mathlib
import Definitions.Def_ChapterIPin
open BookProof.ChapterIPin



open Multiplicative

variable {P V : Type*} [Group P] [AddCommGroup V] (Λ : P →* Multiplicative (AddAut V))


theorem BookProof.ChapterIPin.ipin_right (Λ : P →* Multiplicative (AddAut V)) (x y : IPin Λ) :
    (x * y).right = x.right * y.right := by sorry
