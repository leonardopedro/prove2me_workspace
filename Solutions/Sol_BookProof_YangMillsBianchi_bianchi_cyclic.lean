-- Generated from ChapterYangMillsBianchi.lean — solution of BookProof.YangMillsBianchi.bianchi_cyclic
import Mathlib
import Definitions.Def_ChapterYangMillsBianchi
open BookProof.YangMillsBianchi










open BigOperators



variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D : Fin 3 → R) (i j k : Fin 3) :
    ⁅D i, ⁅D j, D k⁆⁆ + ⁅D j, ⁅D k, D i⁆⁆ + ⁅D k, ⁅D i, D j⁆⁆ = 0 := lie_jacobi (D i) (D j) (D k)
