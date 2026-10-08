-- Generated from ChapterYangMillsFieldStrength.lean — theorem BookProof.YangMillsFieldStrength.nonabelian_fieldStrength
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength


open Complex



variable {R : Type*} [Ring R]


theorem BookProof.YangMillsFieldStrength.nonabelian_fieldStrength
    (δ : Fin 3 → R → R) (a : Fin 3 → R)
    (hadd : ∀ j x y, δ j (x + y) = δ j x + δ j y)
    (hleib : ∀ j x y, δ j (x * y) = δ j x * y + x * δ j y)
    (hcomm : ∀ j k x, δ j (δ k x) = δ k (δ j x))
    (j k : Fin 3) (x : R) :
    Dcov δ a j (Dcov δ a k x) - Dcov δ a k (Dcov δ a j x) = fieldStrengthMul δ a j k * x := by sorry
