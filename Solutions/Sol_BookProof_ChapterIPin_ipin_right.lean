-- Generated from ChapterIPin.lean — solution of BookProof.ChapterIPin.ipin_right
import Mathlib
import Definitions.Def_ChapterIPin
open BookProof.ChapterIPin




open Multiplicative

variable {P V : Type*} [Group P] [AddCommGroup V] (Λ : P →* Multiplicative (AddAut V))

variable {P V : Type*} [Group P] [AddCommGroup V] (Λ : P →* Multiplicative (AddAut V))

set_option maxHeartbeats 1000000 in
theorem solution (Λ : P →* Multiplicative (AddAut V)) (x y : IPin Λ) :
    (x * y).right = x.right * y.right := SemidirectProduct.mul_right x y
