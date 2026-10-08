-- Generated from ChapterYangMillsBianchi.lean — theorem BookProof.YangMillsBianchi.bianchi_fieldStrength
import Mathlib
import Definitions.Def_ChapterYangMillsBianchi
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.YangMillsBianchi


open BigOperators



variable {R : Type*} [Ring R]


theorem BookProof.YangMillsBianchi.bianchi_fieldStrength (D : Fin 3 → R) :
    ∑ i, ∑ j, ∑ k, (eps i j k) • ⁅D i, fieldStrength D j k⁆ = 0 := by sorry
