-- Generated from ChapterYangMillsSU3.lean — solution of BookProof.YangMillsSU3.structureConstant_antisymm_swap
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
import Theorems.Thm_BookProof_YangMillsSU3_structureConstant_formula
open BookProof.YangMillsSU3








open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

set_option maxHeartbeats 1000000 in
theorem solution
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c : Fin d) :
    f a b c = - f b a c := by

  have := structureConstant_formula hT hf a b c
  have := structureConstant_formula hT hf b a c
  simp_all [ Complex.ext_iff, mul_assoc ]
  simp [ sub_mul, mul_sub, Matrix.trace ]
