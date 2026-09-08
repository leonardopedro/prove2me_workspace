-- Generated from ChapterYangMillsBianchi.lean — theorem BookProof.YangMillsBianchi.bianchi_cyclic
import Mathlib
import Definitions.Def_ChapterYangMillsBianchi
open BookProof.YangMillsBianchi









open BigOperators



variable {R : Type*} [Ring R]

theorem BookProof.YangMillsBianchi.bianchi_cyclic (D : Fin 3 → R) (i j k : Fin 3) :
    ⁅D i, ⁅D j, D k⁆⁆ + ⁅D j, ⁅D k, D i⁆⁆ + ⁅D k, ⁅D i, D j⁆⁆ = 0 := by sorry
